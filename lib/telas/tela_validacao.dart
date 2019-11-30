import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:aplicativo_shareon/utils/shareon_appbar.dart';
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

  TelaValidacao({@required this.userId, @required this.solicitationId});

  @override
  _TelaValidacaoState createState() => _TelaValidacaoState();
}

class _TelaValidacaoState extends State<TelaValidacao> {
  String barcode = "";
  int pin = 0;
  Timestamp pinCreatedTime;
  int pinDuration = 0;
  GlobalKey globalKey = new GlobalKey();
  Map<String, dynamic> qrMap;
  bool loading = false;
  bool canPop = true;
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 30), (Timer t) => timerPIN());
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    qrMap = {
      "otherUserID": widget.userId,
      "otherUserPIN": pin,
      "solicitationID": widget.solicitationId,
    };
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
        appBar: shareonAppbar(context, ""),
        body: telaValidacao(),
      ),
    );
  }

  telaValidacao() {
    return SingleChildScrollView(
      child: Container(
        height: 720,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Container(
                child: _text(
                    "Para validar uma transação escaneie o código do outro usuário, ou peça para ele escanear o seu."),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
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
            _qrZone(qrMap.toString()),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 8),
                child: _text(
                    "Ou se preferir digite sua senha no celular dele, ou peça para que ele digite a dele."),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxSenha(),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: _boxSenha(),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: _boxSenha(),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: _boxSenha(),
                    ),
                  ),
                ],
              ),
            ),
            Center(
                child: Container(
              margin: EdgeInsets.only(top: 8),
              child: _textPin(),
            )),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 400,
                    margin: EdgeInsets.only(bottom: 10, top: 8),
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        _updatePIN();
                      },
                      child: Text(
                        "Validar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _boxSenha() {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 60,
          minHeight: 60,
          maxHeight: 60,
          maxWidth: 60,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            color: Colors.white,
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
      setState(() => _toast(barcode, context));
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
    setState(() {});
  }

  _updatePIN() async {
    var newPinString = "";

    var randomizer = new Random();
    for (var i = 0; i < 4; i++) {
      newPinString = newPinString + randomizer.nextInt(9).toString();
    }

    int newPIN = int.parse(newPinString);

    pinCreatedTime = Timestamp.fromDate(DateTime.now());
    pin = newPIN;
    pinDuration = 2;

    Map<String, dynamic> updatePin = {
      "lastPINCreatedTS": Timestamp.fromDate(DateTime.now()),
      "PIN": newPIN,
    };

    await databaseReference
        .collection("users")
        .document(widget.userId)
        .updateData(updatePin);
  }

  timerPIN() {
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

  _qrZone(String qrText) {
    return Container(
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
          child: pin == 0
              ? Container()
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
}
