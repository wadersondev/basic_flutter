import 'package:flutter/material.dart';
import 'package:myapp/screens/dog_page.dart';
import 'package:myapp/utils/nav.dart';
import 'package:myapp/widgets/blue_button.dart';

class Dog {
  String nome;
  String foto;

  Dog(this.nome, this.foto);
}

class HelloListView extends StatefulWidget {
  @override
  _HelloListViewState createState() => _HelloListViewState();
}

class _HelloListViewState extends State<HelloListView> {
  bool _gridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              print("Lista");
              // Redesenhando a tela depois de clicar no botão
              setState(() {
                _gridView = false;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {
              print("Grid");
              setState(() {
                _gridView = true;
              });
            },
          ),
        ],
      ),
      body: _body(context),
    );
  }

  _body(context) {
    // criando um array (como se estivesse recebendo os dados de um webservice)
    List<Dog> dogs = [
      Dog('Jack Russel', 'assets/images/dog1.png'),
      Dog('Labrador', 'assets/images/dog2.png'),
      Dog('Pug', 'assets/images/dog3.png'),
      Dog('Rottweiler', 'assets/images/dog4.png'),
      Dog('Pastor', 'assets/images/dog5.png'),
    ];

    if(_gridView) {
      //".builder" tem a função de converter em widget
      return GridView.builder(
        itemCount: dogs.length,
        //"crossAxisCount:" -> define quantos itens terá cada linha
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return _itemView(dogs, index);
        },
      );
    } else {
      //".builder" tem a função de converter em widget
      return ListView.builder(
        itemCount: dogs.length,
        itemExtent: 350,
        itemBuilder: (context, index) {
          return _itemView(dogs, index);
        },
      );
    }
  }

  _itemView(List<Dog> dogs, int index) {
    //Recuperando os itens do array 'dog'
    Dog dog = dogs[index];
    //Stack funciona como umap pilha colocando um widget sobre o outro
    return GestureDetector(
      onTap: () {
        push(context, DogPage(dog));
      },
      child: Stack(
        //StackFit.expand -> expande o widget até o tamanho pré-definido
        fit: StackFit.expand,
        children: <Widget>[
          _img(dog.foto),
          //O texto foi colocando num Container para ajuste da posição dele na tela
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  //black45 -> 45% de opacidade
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                dog.nome,
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _img(String img) {
    return Image.asset(
      img,
      //BoxFit.cover -> faz as imagens se expandirem
      fit: BoxFit.cover,
    );
  }
}
