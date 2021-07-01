import 'package:flutter/material.dart';

import '../auth_service.dart';

class AjoutCommande extends StatefulWidget{
  _AjoutCommande createState() => _AjoutCommande();

}

class _AjoutCommande extends State<AjoutCommande>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une commande'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              AuthService().signOut();
            },
          )
        ],
      ),
        body:Center(
          child: Container(
             child: Text("MOzart est la"),
          )
        ) ,
    );
  }
}