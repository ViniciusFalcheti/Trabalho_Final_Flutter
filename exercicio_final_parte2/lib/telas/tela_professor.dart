import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_aluno.dart';
import 'package:flutter/material.dart';

class TelaProf extends StatefulWidget {
  @override
  _TelaProfState createState() => _TelaProfState();
}

class _TelaProfState extends State<TelaProf> {

  var db = FirebaseFirestore.instance;

  List<EAluno> alunos = List();

  StreamSubscription<QuerySnapshot> ouvidor;
 

  @override
  void initState() {
    super.initState();
      ouvidor?.cancel();

      ouvidor = db.collection("alunos").snapshots().listen((res) {

      setState(() {
        alunos = res.docs.map((e) => EAluno.fromMap(e.data(), e.id)).toList();
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Home Professor')
      ),
            body: Container(
        padding: EdgeInsets.all(60),
        child: ListView(
          children: [
            Text('Bem vindo!',
                style: TextStyle(fontSize: 42, color: Colors.white)),
            SizedBox(height: 30),
            ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              minWidth: 150.0,
              height: 100.0,
              hoverColor: Theme.of(context).hoverColor,
              buttonColor: Theme.of(context).buttonColor,
              child: RaisedButton(
                child: Text(' Cadastrar Alunos',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/editAluno',
                  );
                },
              ),
            ),
            SizedBox(height: 15),

          ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              minWidth: 150.0,
              height: 100.0,
              hoverColor: Theme.of(context).hoverColor,
              buttonColor: Theme.of(context).buttonColor,
              child: RaisedButton(
                child: Text(' Dar Notas',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/darNotas',
                  );
                },
              ),
            ),
            SizedBox(height: 15),

            ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              hoverColor: Theme.of(context).hoverColor,
              buttonColor: Theme.of(context).buttonColor,
              minWidth: 150.0,
              height: 100.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/presenca',
                  );
                },
                child: Text('Presença',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
