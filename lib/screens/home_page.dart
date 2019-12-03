import 'package:flutter/material.dart';
import 'package:myapp/screens/hello_listview.dart';
import 'package:myapp/screens/hello_page2.dart';
import 'package:myapp/screens/hello_page3.dart';
import 'package:myapp/utils/nav.dart';
import 'package:myapp/widgets/blue_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../drawer_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // O Scaffold foi colocado dentro desse widget para poder renderizar a TabBar
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Início'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          //colocando TabBar
          bottom: TabBar(tabs: <Widget>[
            Tab(text: "TAB 1",),
            Tab(text: "TAB 2",),
            Tab(text: "TAB 3",),
          ],),
        ),
        //TabBarView -> renderiza as TabBars
        body: TabBarView(children: <Widget>[
          _body(context),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          ),
        ],),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _onClickFab();
          },
        ),
        //Criando o menu lateral
        drawer: DrawerList(),
      ),
    );
  }

  _onClickFab() {
    print("Adicionar");
  }
}

_body(context) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _text(),
          _pageView(),
          _buttons(context),
        ],
      ),
    ),
  );
}

//_body(context) {
//  return Column(
//    children: <Widget>[
//      Expanded(
//        flex: 6,
//        child: _pageView(),
//      ),
//      Expanded(
//        flex: 4,
//        child: _pageView(),
//      ),
//    ],
//  );
//}

_pageView() {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 20),
    height: 300,
    child: PageView(
      children: <Widget>[
        _img('assets/images/dog1.png'),
        _img('assets/images/dog2.png'),
        _img('assets/images/dog3.png'),
        _img('assets/images/dog4.png'),
        _img('assets/images/dog5.png'),
      ],
    ),
  );
}

_buttons(context) {
  return Builder(
    builder: (context) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BlueButton("ListView",
                  onPressed: () => _onClickNavigator(context, HelloListView())),
              BlueButton("Page 2",
                  onPressed: () => _onClickNavigator(context, HelloPage2())),
              BlueButton("Page 3",
                  onPressed: () => _onClickNavigator(context, HelloPage3())),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BlueButton("Snack", onPressed: () => _onClickSnack(context)),
              BlueButton("Dialog", onPressed: () => _onClickDialog(context)),
              BlueButton("Toast", onPressed: _onClickToast),
            ],
          ),
        ],
      );
    },
  );
}

void _onClickNavigator(BuildContext context, Widget page) async {
  String s = await push(context, page);
  print(">> $s");
}

_onClickSnack(context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text("Olá Flutter"),
    action: SnackBarAction(
      textColor: Colors.yellow,
      label: "OK!",
      onPressed: () {
        print("OK!");
      },
    ),
  ));
}

_onClickDialog(context) {
  showDialog(
      context: context,
      //Para não fechar a caixa de diálogo qdo clicar fora dela
      barrierDismissible: false,
      builder: (context) {
        //AlertDialog foi envolvido pelo WillPopScope para usar o "onWillPop"
        return WillPopScope(
          //Para não permitir que a caixa de diálogo feche qdo clicar em voltar no Aparelho
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Flutter é muito legal!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  //fechando o alerta
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                  print("Ok!!!");
                },
              ),
            ],
          ),
        );
      });
}

//Toast, por padrão, não existe no flutter, foi preciso baixar a biblioteca fluttertoast
_onClickToast() {
  Fluttertoast.showToast(
      msg: "Flutter é Sensacional!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 5,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.white,
      fontSize: 24.0);
}

_img(String img) {
  return Image.asset(
    img,
    fit: BoxFit.cover,
  );
}

_text() {
  return Text(
    'Hello Flutter',
    style: TextStyle(
      fontSize: 30,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      //decoration: TextDecoration.underline,
      //decorationColor: Colors.pink,
    ),
  );
}
