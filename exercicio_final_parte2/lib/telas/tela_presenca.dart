import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_aluno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_format/date_format.dart';




class TelaPresenca extends StatefulWidget {
  @override
  _TelaPresencaState createState() => _TelaPresencaState();

}

enum SingingCharacter { presente, ausente }

class _TelaPresencaState extends State<TelaPresenca> {

  var db = FirebaseFirestore.instance;

  

  List<EAluno> alunos = List();

  SingingCharacter _character = SingingCharacter.presente;

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
          title: Text('Lista de Presença'),
          actions: <Widget>[
            Center(child: Text(formatDate(DateTime.now(), [dd, '/', m, '/', yyyy]) + "  ",style: TextStyle(fontSize: 18)))
          ],
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
                          trailing:Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[  
                              const Text('Presente\nhoje', style: TextStyle(fontSize: 14, color: Colors.white)),
                              Radio(
                              value: SingingCharacter.presente,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                              ),
                              const Text('Ausente\nhoje', style: TextStyle(fontSize: 14, color: Colors.white)),
                              Radio(
                                value: SingingCharacter.ausente,
                                groupValue: _character,
                                onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                              ),
                            ]
                          )
                        ),

                        
                      );
                    }
                   );
                }
              }
          )
    );
  }
}