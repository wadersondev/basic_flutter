import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Drawer colocado dentro do SafeArea para mostrar a barra superior do smartphone numa cor só (estava estranho antes)
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            //Desenhando os dados do usuário
            UserAccountsDrawerHeader(
              accountName: Text("Wanderson Pereira"),
              accountEmail: Text("wanderson@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9GPYe71-HkCkMQOXb4JBfzznEc_QPF_r0bnwJHQ-_PUC-vp1X&s"),
              ),
            ),
            //ListTile recebe 3 itens: Esqueda (leading), Centro (title e subtitle) e Direita (trailing)
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 2");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 3");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
