import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/utils/shareon_appbar.dart';

class ProdutoSelecionado extends StatefulWidget {
  @override
  _ProdutoSelecionadoState createState() => _ProdutoSelecionadoState();
}

class _ProdutoSelecionadoState extends State<ProdutoSelecionado> {

  @override
  Widget build(BuildContext context) {
    return _produto_selecionado();
  }
}

_produto_selecionado() {
  return Scaffold(
    appBar: shareon_appbar(),
    body: SizedBox.expand(
      child: Container(
        color: Colors.indigo,
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: PageView(
                        children: <Widget>[
                          _img(
                              "https://i.pinimg.com/originals/50/8d/1d/508d1d2a8f9bc715aedfd3ca17d10c2b.jpg"),
                          _img(
                              "https://jotacortizo.files.wordpress.com/2016/11/casas-de-hogwarts.jpg"),
                          _img(
                              "https://i.pinimg.com/originals/64/82/0f/64820fd9ad5cce4b795ccf059e382f84.jpg"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: _text("Nome do Objeto", Titulo: true),
                    ),
                    Container(
                        width: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _text("5.0"),
                            _iconEstrela(),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: _text("Nome do dono"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: _text("Descrição vinda do dono:"),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 235,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: Container(
                            color: Colors.white,
                            width: 1000,
                            padding: EdgeInsets.all(8),
                            child: _text(
                                "	Lorem ipsum neque pretium plla dui. consectetur porttitor nisl nunc eget potenti posuere porta augue ullamcorper aenean. donec nibh scelerisque laoreet quis gravida tempus curae lorem, enim nibh sociosqu posuere fermentum vivamus nullam, leo vel auctor mi tellus dictumst mi morbi, vestibulum nibh facilisis sociosqu laoreet aenean. quis risus posuere ipsum ad eu nulla ornare nulla aenean eleifend purus, orci hendrerit a sem vel sagittis senectus tellus ac. ",
                                Resumo: true),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: RaisedButton(
                        onPressed: () {},
                        child: _text("Reservar", Resumo: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

_text(String texto, {bool Titulo = false, bool Resumo = false}) {
  if (Titulo == true) {
    return Text(
      "$texto",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 30,
      ),
    );
  } else if (Resumo == true) {
    return Text(
      "$texto",
      style: TextStyle(
        fontSize: 16,
      ),
    );
  } else {
    return Text(
      "$texto",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}

_img(String url) {
  return Container(
    child: Image.network(
      "$url",
      fit: BoxFit.cover,
    ),
  );
}

_iconEstrela() {
  return Icon(
    Icons.star,
    color: Colors.white,
    size: 20.0,
  );
}
