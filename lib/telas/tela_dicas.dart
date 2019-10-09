import 'package:aplicativo_shareon/utils/drawer_builder.dart';
import 'package:aplicativo_shareon/utils/shareon_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaDicas extends StatefulWidget {
  @override
  _TelaDicasState createState() => _TelaDicasState();
}

class _TelaDicasState extends State<TelaDicas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _home(),
    );
  }
}

_home() {
  return Scaffold(
    appBar: shareon_appbar(),
    drawer: DrawerList(),
    body: Container(
      color: Colors.grey[300],
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _textTitulo(),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: _textDicas(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

_textTitulo() {
  return Text(
    "Dicas de Segurança",
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    ),
  );
}

_textDicas() {
  return Text(
    "	Lorem ipsum augue aliquet nibh massa cursus cubilia ut, vitae etiam suscipit pharetra augue ullamcorper aenean, adipiscing consequat ac varius potenti sodales ultrices. massa pulvinar pharetra tempus feugiat semper at iaculis, proin rhoncus magna fermentum nisl class felis ornare, diam platea enim aliquam elit malesuada. tellus ad vulputate euismod at dictumst cubilia arcu facilisis posuere tristique, diam placerat porta rutrum primis curae mi euismod class, netus adipiscing porta torquent class feugiat nisi vulputate blandit. phasellus libero quis volutpat lectus ipsum duis mollis venenatis, pretium aenean nisi lacinia fermentum duis ac eros class, fames consectetur lorem pellentesque euismod vestibulum nam "
        "Consequat nisl conubia mauris fringilla nisl pellentesque justo per curabitur tristique, tellus feugiat fusce duis condimentum pulvinar amet taciti dictum eros, ut vel mollis auctor ornare dictumst eros urna tellus. litora morbi nibh nam aliquet dui nunc lorem curabitur ipsum quam venenatis pulvinar per, ante sem ante potenti aliquam elit vulputate pretium sed ut libero egestas posuere, conubia odio ornare phasellus et eros netus tortor ullamcorper quam amet consequat. per sapien vulputate tortor nisi blandit hendrerit mattis felis, dui amet diam commodo quisque himenaeos varius, quisque neque magna blandit hac fusce convallis."
        "Vehicula tincidunt neque orci purus habitant scelerisque porta, blandit dictum condimentum tortor risus mattis eget, amet cras vulputate euismod mi suspendisse. felis aptent ad condimentum adipiscing feugiat ligula euismod sociosqu venenatis amet velit, at primis arcu netus duis ad cras potenti sociosqu porta. eleifend orci feugiat porta tortor imperdiet proin elementum vitae, augue mi metus lacinia bibendum condimentum fermentum suscipit, lacus laoreet nunc aliquam auctor habitant morbi. ipsum nec condimentum suspendisse consequat enim nisl nunc habitant, odio condimentum lacinia congue dolor posuere molestie, at porta lacinia aliquam vitae sed massa."
        "Habitasse egestas mollis felis fermentum arcu feugiat, risus hac mauris egestas et erat aenean, duis rutrum convallis potenti netus. quisque hendrerit volutpat nam scelerisque class purus sollicitudin neque quis egestas lectus, aenean primis maecenas cursus nulla per sociosqu venenatis tellus rhoncus, interdum netus justo litora nibh eleifend venenatis aliquam fames urna. vel himenaeos dictumst nulla a etiam ante ipsum euismod dui suscipit sodales curabitur, facilisis suscipit quam vitae habitant fames gravida class ipsum integer morbi amet neque, a elit nullam massa etiam nullam pulvinar habitasse venenatis aliquet diam. himenaeos urna proin inceptos iaculis mattis non id sed lobortis, elementum fermentum vel pulvinar porttitor risus varius nisi, aenean eleifend hac etiam risus ornare senectus eu."
        "Urna luctus amet sociosqu et interdum lobortis sapien nisi, curae class nunc dui nulla lorem condimentum netus laoreet, interdum litora leo metus praesent imperdiet dictumst. mollis phasellus massa odio lacinia ac donec erat, praesent suspendisse potenti ornare blandit augue tincidunt, orci nisl platea ornare etiam consectetur. nunc nam id potenti nullam tortor lobortis aliquam justo aliquam, facilisis tincidunt aliquet netus blandit facilisis donec nam donec, aliquet sodales non aptent aenean dui commodo varius. pretium class massa enim lacinia justo sodales curabitur id, tellus lorem dictumst molestie pellentesque hendrerit quisque, ornare leo tincidunt per quis ultricies platea."
        "Quis ad fringilla molestie tristique vulputate, donec dictum orci. ",
    style: TextStyle(
      fontStyle: FontStyle.italic,
    ),
  );
}
