import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_aluno.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'cadastrar_alunos.dart';

class TelaEditAlunos extends StatefulWidget {
  @override
  _TelaEditAlunosState createState() => _TelaEditAlunosState();
}

class _TelaEditAlunosState extends State<TelaEditAlunos> {

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
          title: Text('Lista de Alunos')
      ),
          
      floatingActionButton:
          //color: Theme.of(context).buttonColor,
          FloatingActionButton(
              backgroundColor: Theme.of(context).buttonColor,
              child: Icon(Icons.add),
              onPressed: () { 
                Navigator.pushNamed(
                    context,
                    '/cadAluno',
                  );
              }
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: db.collection("alunos").snapshots(),
              builder: (context, snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(child: Text("Erro ao conectar no Firebase"));
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:return ListView.builder(
                    itemCount: alunos.length,
                    itemBuilder: (context, index){
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: ListTile(
                          title:
                            Text(alunos[index].nome, style: TextStyle(fontSize: 20, color: Colors.white)),
                          subtitle:
                            Text(alunos[index].ra, style: TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            caption: 'Editar',
                            color: Colors.blue,
                            icon: Icons.edit,
                            onTap: () {
                              Navigator.pushNamed(
                                context, '/cadAluno',
                                arguments: alunos[index].id
                              );
                            },
                         ),
                          IconSlideAction(
                            caption: 'Excluir',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              db.collection("alunos").doc(alunos[index].id).delete();
                            },
                          ),
                        ],
                      );
                    }
                   );
                }
              }
          )
    );
  }
}
