import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_aluno.dart';
import 'package:flutter/material.dart';

class CadAluno extends StatefulWidget {
  final EAluno aluno;


  // Construtor para receber uma tarefa quando precisar edita-la
  CadAluno({this.aluno});

  @override
  _CadAlunoState createState() => _CadAlunoState();
}

class _CadAlunoState extends State<CadAluno> {
  final txtNomeAluno = TextEditingController();
  final txtRaAluno = TextEditingController();
  final txtRgAluno = TextEditingController();
  String serie = 'Primeira série';

  EAluno student;

  var db = FirebaseFirestore.instance;

  void getDocumentById(String id) async{

    await db.collection("alunos").doc(id).get()
    .then((doc){

      txtNomeAluno.text = doc.data()['nome'];
      txtRaAluno.text = doc.data()['ra'];
    });
  }

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

    final String id = ModalRoute.of(context).settings.arguments;

    if(id != null){
      if(txtNomeAluno.text == '' && txtRaAluno.text == ''){
        getDocumentById(id);
      }
    }

    return AlertDialog(
      title: Text(widget.aluno == null ? 'Novo aluno' : 'Editar aluno'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
              controller: txtNomeAluno,
              decoration: InputDecoration(labelText: 'Nome'),
              autofocus: true),
          TextField(
              controller: txtRaAluno,
              decoration: InputDecoration(labelText: 'RA')),
          TextField(
              controller: txtRgAluno,
              decoration: InputDecoration(labelText: 'RG')),

          DropdownButton<String>(
              value: serie,
              icon: Icon(Icons.arrow_drop_down,
                color: Theme.of(context).buttonColor),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    serie = newValue;
                  });
                },
                items: <String>[
                  'Primeira série',
                  'Segunda série',
                  'Terceira série',
                  'Quarta série'
                ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                    );
                  }).toList(),
                ),

        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Salvar'),
          onPressed: () async {

            if(id == null){
              await db.collection("alunos").add(
                {
                  "nome" : txtNomeAluno.text,
                  "ra" : txtRaAluno.text,
                  "senha" : txtRgAluno.text,
                  "serie" : serie,
                }
              );
            }else{
               await db.collection("alunos").doc(id).update(
                {
                  "nome" : txtNomeAluno.text,
                  "ra" : txtRaAluno.text,
                  "senha" : txtRgAluno.text,
                  "serie" : serie,
                }
               );
            }

          //student.nome = txtNomeAluno.value.text;
          //student.ra = txtRaAluno.text;

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
