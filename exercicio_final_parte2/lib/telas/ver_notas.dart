//tela de login aluno

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_notas.dart';
import 'package:flutter/material.dart';

class VerNotas extends StatefulWidget {

  @override
  _VerNotasState createState() => _VerNotasState();
}
  String dropdownValue = 'Primeiro Bimestre';


class _VerNotasState extends State<VerNotas> {

  var db = FirebaseFirestore.instance;

  List<ENotas> notas = List();

  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState() {
    super.initState();

    ouvidor?.cancel();

    ouvidor = db.collection("notas").snapshots().listen((res) {

      setState(() {
        notas = res.docs.map((e) => ENotas.fromMap(e.data(), e.id)).toList();
      });

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Notas e faltas'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: Center(
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Matérias', style: TextStyle(fontSize: 24, color: Colors.white), textAlign: TextAlign.left),
                  Text('\nPortugês\nMatemática\nGeografia\nHistória\nCiências',
                    style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.left),
              ]),

               Column(
                children: [
                  Text('Notas',
                    style: TextStyle(fontSize: 24, color: Colors.white)),
                  Text('\n',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              ]),

               Column(
                children: [
                  Text('Faltas', style: TextStyle(fontSize: 24, color: Colors.white)),
                  
                  Text('\n4\n7\n0\n4\n2',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              ]),

              SizedBox(height: 30),

              
              ],
          ),
        ),
      ),
    );
  }
}
