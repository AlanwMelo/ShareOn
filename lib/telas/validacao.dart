import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:aplicativo_shareon/telas/home.dart';
import 'package:aplicativo_shareon/utils/alter_debit.dart';
import 'package:aplicativo_shareon/utils/avaliacao.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toast/toast.dart';

class TelaValidacao extends StatefulWidget {
  final String userId;
  final String solicitationId;
  var productPrice;

  TelaValidacao(
      {@required this.userId,
      @required this.solicitationId,
      this.productPrice});

  @override
  _TelaValidacaoState createState() => _TelaValidacaoState();
}

class _TelaValidacaoState extends State<TelaValidacao> {
  String barcode = "";
  String pin = "";
  Timestamp pinCreatedTime;
  int pinDuration = 0;
  GlobalKey globalKey = new GlobalKey();
  String qrMap;
  bool loading = false;
  bool canPop = true;
  String validacao = "Validação";
  int retiradaDevolucao; // 0 retirada 1 devolução
  String otherUserID = "";
  String ownerID = "";
  String requesterID = "";
  String productID = "";
  final databaseReference = Firestore.instance;
  bool timerStop = false;
  bool pinStop = false;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 10), (Timer t) => timerPIN());
    Timer.periodic(Duration(seconds: 5), (Timer t) => timerVerificaStatus());
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    qrMap =
        "{\"otherUserID\": \"${widget.userId}\", \"otherUserPIN\": \"$pin\", \"solicitationID\": \"${widget.solicitationId}\"}";
    return WillPopScope(
      onWillPop: () async {
        if (canPop == true) {
          return true;
        } else {
          _toast("Aguarde os dados serem carregados", context);
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          title: Text(validacao),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
        ),
        body: loading == false
            ? telaValidacao()
            : Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  telaValidacao() {
    return SingleChildScrollView(
      child: Container(
        height: 600,
        padding: EdgeInsets.all(12),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                    child: _text(
                        "Para validar uma transação escaneie o código do outro usuário, ou peça para ele escanear o seu."),
                  ),
                ),
                _qrZone(qrMap.toString()),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      scan();
                    },
                    child: Text(
                      "Escanear",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateQR() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      _validator(barcode, qrCall: true);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  _textPin() {
    if (pinDuration > 1) {
      return _textAlerta(
          "Seu PIN é: $pin. E é válido por mais $pinDuration minutos.");
    } else if (pinDuration == 1) {
      return _textAlerta(
          "Seu PIN é: $pin. E é válido por mais $pinDuration minuto.");
    } else {
      return _textAlerta("Seu PIN é: $pin. E é válido por menos de um minuto.");
    }
  }

  Future getData() async {
    await databaseReference
        .collection("users")
        .where("userID", isEqualTo: widget.userId)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        Map userData = f.data;

        if (userData["lastPINCreatedTS"] != null) {
          Timestamp createdDate = userData["lastPINCreatedTS"];
          int timeNow =
              Timestamp.fromDate(DateTime.now()).millisecondsSinceEpoch;
          int createdAux = createdDate.millisecondsSinceEpoch;

          if ((timeNow - createdAux) > 120000) {
            _updatePIN();
          } else {
            pin = userData["PIN"];
            pinCreatedTime = userData["lastPINCreatedTS"];
          }
        } else {
          _updatePIN();
        }
      });
    });
    await databaseReference
        .collection("solicitations")
        .where("solicitationID", isEqualTo: widget.solicitationId)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        Map solicitationData = f.data;

        ownerID = solicitationData["ownerID"];
        requesterID = solicitationData["requesterID"];
        productID = solicitationData["productID"];

        if (solicitationData["ownerID"] == widget.userId) {
          otherUserID = solicitationData["requesterID"];
        } else {
          otherUserID = solicitationData["ownerID"];
        }
        if (solicitationData["status"] == "aprovada") {
          validacao = "Validar retirada";
          retiradaDevolucao = 0;
        } else if (solicitationData["status"] == "em andamento") {
          validacao = "Validar devolução";
          retiradaDevolucao = 1;
        }
      });
    });
    setState(() {});
  }

  _updatePIN() async {
    if (pinStop == false) {
      String newPIN = "";

      newPIN =
          "${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}";

      pinCreatedTime = Timestamp.fromDate(DateTime.now());

      Map<String, dynamic> updatePin = {
        "lastPINCreatedTS": Timestamp.fromDate(DateTime.now()),
        "PIN": newPIN,
      };

      await databaseReference
          .collection("users")
          .document(widget.userId)
          .updateData(updatePin);

      setState(() {
        pin = newPIN;
        pinDuration = 2;
      });
    }
  }

  timerPIN() {
    if (pinStop == false) {
      int timePin = pinCreatedTime.millisecondsSinceEpoch;
      int timeNow = Timestamp.fromDate(DateTime.now()).millisecondsSinceEpoch;
      int dif = (timeNow - timePin);
      int difInMin = (dif ~/ 60000).toInt();
      if (difInMin >= 3) {
        _updatePIN();
        pinDuration = (2 - difInMin);
      } else {
        pinDuration = (2 - difInMin);
      }
      setState(() {});
    }
  }

  _qrZone(String qrText) {
    return Container(
      margin: EdgeInsets.only(top: 36, bottom: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 300,
          minHeight: 300,
          maxHeight: 300,
          maxWidth: 300,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: pin == ""
              ? Container(
                  color: Colors.white,
                )
              : QrImage(
                  backgroundColor: Colors.white,
                  data: qrText,
                  size: 300,
                ),
        ),
      ),
    );
  }

  _textAlerta(String texto) {
    return Text(
      "$texto",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.yellow,
      ),
    );
  }

  _text(String texto, {bool titulo = false, bool resumo = false}) {
    if (titulo == true) {
      return Text(
        "$texto",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 30,
        ),
      );
    } else if (resumo == true) {
      return Text(
        "$texto",
        style: TextStyle(
          fontSize: 16,
        ),
      );
    } else {
      return Text(
        "$texto",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      );
    }
  }

  _toast(String x, BuildContext context) {
    Toast.show(x, context,
        duration: 3,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8));
  }

  _validator(String barcode, {bool qrCall = false}) async {
    if (qrCall == true) {
      Map validator = jsonDecode(barcode);

      if (validator["solicitationID"] != widget.solicitationId) {
        _toast("Este QRCode é o de outra reserva", context);
      } else if (validator["otherUserID"] == widget.userId) {
        _toast("Você não pode validar uma reserva com seu próprio QRCode",
            context);
      } else {
        await databaseReference
            .collection("users")
            .where("userID", isEqualTo: validator["otherUserID"])
            .getDocuments()
            .timeout(Duration(seconds: 60))
            .then((QuerySnapshot snapshot) {
          snapshot.documents.forEach((f) async {
            Map validaQR = f.data;

            if (validaQR["PIN"] != validator["otherUserPIN"]) {
              _toast("erro PIN incorreto", context);
            } else {
              // 0 retirada 1 devolução
              if (retiradaDevolucao == 0) {
                _validaRetirada();
              }
              if (retiradaDevolucao == 1) {
                _validaDevolucao();
              }
            }
          });
        });
      }
    } else {}
  }

  timerVerificaStatus() async {
    if (timerStop == false) {
      await databaseReference
          .collection("solicitations")
          .where("solicitationID", isEqualTo: widget.solicitationId)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          Map validado = f.data;

          if (retiradaDevolucao == 0) {
            // 0 retirada 1 devolução
            if (validado["status"] == "em andamento") {
              _toast("Retirada validada", context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext contex) {
                return Home();
              }));
            }
          }
          if (retiradaDevolucao == 1) {
            // 0 retirada 1 devolução
            if (validado["status"] == "concluido") {
              _toast("Devolução validada", context);

              setState(() {
                timerStop = true;
                pinStop = true;
              });

              showDialog(
                  context: context,
                  builder: (_) {
                    return Avaliacao(
                        requesterID: requesterID,
                        userID: widget.userId,
                        ownerID: ownerID,
                        productID: productID);
                  });
            }
          }
        });
      });
    }
  }

  _strgDia(int dia, int hora, int min) {
    if (dia > 0 && hora == 0) {
      if (dia == 0) {
        return "";
      } else if (dia == 1) {
        return "$dia Dia e ";
      } else if (dia > 1) {
        return "$dia Dias e ";
      }
    } else {
      if (dia == 0) {
        return "";
      } else if (dia == 1) {
        return "$dia Dia ";
      } else if (dia > 1) {
        return "$dia Dias ";
      }
    }
  }

  _strgHora(int hora, int min) {
    if (min > 0) {
      if (hora == 0) {
        return "";
      } else if (hora == 1) {
        return "$hora Hora e ";
      } else if (hora > 1) {
        return "$hora Horas e ";
      }
    } else {
      if (hora == 0) {
        return "";
      } else if (hora == 1) {
        return "$hora Hora";
      } else if (hora > 1) {
        return "$hora Horas";
      }
    }
  }

  _strgMin(int min) {
    if (min == 0) {
      return "";
    } else if (min == 1) {
      return "$min minuto";
    } else if (min > 1) {
      return "$min minutos";
    }
  }

  Future _validaRetirada() async {
    Map<String, dynamic> validaTransacao = {
      "finalStartDate": Timestamp.fromDate(DateTime.now()),
      "status": "em andamento",
      "motivoStatus": "retirada",
    };

    await databaseReference
        .collection("solicitations")
        .document(widget.solicitationId)
        .updateData(validaTransacao);

    _toast("Retirada validada", context);

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext contex) {
      return Home();
    }));
  }

  Future _validaDevolucao() async {
    setState(() {
      canPop = false;
      loading = true;
    });
    await databaseReference
        .collection("solicitations")
        .where("solicitationID", isEqualTo: widget.solicitationId)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        Map endTransaction = f.data;

        Timestamp tsStarTime = endTransaction["finalStartDate"];
        DateTime dtStarTime = DateTime.fromMillisecondsSinceEpoch(
            tsStarTime.millisecondsSinceEpoch);

        int duracao = (DateTime.now().difference(dtStarTime).inMinutes);

        double totalOfMins = duracao.toDouble();
        double dias = totalOfMins / 1440;
        double horas = (totalOfMins % 1440) / 60;
        double min = totalOfMins % 60;

        String strgDuracao =
            "${_strgDia(dias.toInt(), horas.toInt(), min.toInt())}"
            "${_strgHora(horas.toInt(), min.toInt())}"
            "${_strgMin(min.toInt())}";

        var auxPrice = widget.productPrice / (60);

        double endPrice = duracao.toDouble() * auxPrice;

        Map<String, dynamic> validaTransacao = {
          "finalEndDate": Timestamp.fromDate(DateTime.now()),
          "status": "concluido",
          "finalEndPrice": endPrice,
          "finalDuration": strgDuracao,
          "motivoStatus": "devolução",
        };

        await databaseReference
            .collection("solicitations")
            .document(widget.solicitationId)
            .updateData(validaTransacao);

        String owner = endTransaction["ownerID"];
        Map<String, dynamic> debitADD = {
          "userID": owner,
          "solicitation": widget.solicitationId,
          "reason": "aluguel",
          "debit": endPrice,
          "statusTS": Timestamp.fromDate(DateTime.now()),
        };

        await databaseReference.collection("debitHist").add(debitADD);

        double subtrai = endPrice * -1;

        String requester = endTransaction["requesterID"];
        Map<String, dynamic> debitSub = {
          "userID": requester,
          "solicitation": widget.solicitationId,
          "reason": "aluguel",
          "debit": subtrai,
          "statusTS": Timestamp.fromDate(DateTime.now()),
        };

        await databaseReference.collection("debitHist").add(debitSub);

        var alterOwnerDebit = new AlterDebit(userID: owner);
        var alterRequesterDebit = new AlterDebit(userID: requester);

        alterOwnerDebit.alterdebit();
        alterRequesterDebit.alterdebit();

        showDialog(
            context: context,
            builder: (_) {
              return Avaliacao(
                  requesterID: requesterID,
                  userID: widget.userId,
                  ownerID: ownerID,
                  productID: productID);
            });
      });
    });

    setState(() {
      canPop = true;
      loading = false;
    });
  }
}
