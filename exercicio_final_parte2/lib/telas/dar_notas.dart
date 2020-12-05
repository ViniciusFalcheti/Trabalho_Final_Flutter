import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_aluno.dart';
import 'package:exercicio_final_parte2/estruturas/struct_notas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';




class DarNotas extends StatefulWidget {
  @override
  _DarNotasState createState() => _DarNotasState();

}

class _DarNotasState extends State<DarNotas> {

  var db = FirebaseFirestore.instance;

  

  List<ENotas> notas = List();
  List<EAluno> alunos = List();
  var txtNotaGeo = TextEditingController();
  var txtNotaHistoria = TextEditingController();
  var txtNotaPort = TextEditingController();
  var txtNotaMat = TextEditingController();
  var txtNotaCiencias = TextEditingController();


  StreamSubscription<QuerySnapshot> ouvidor;
  StreamSubscription<QuerySnapshot> ouvidor2;
  
 

  @override
  void initState() {
    super.initState();
      ouvidor?.cancel();
      ouvidor2?.cancel();

      ouvidor = db.collection("notas").snapshots().listen((res) {

      setState(() {
        notas = res.docs.map((e) => ENotas.fromMap(e.data(), e.id)).toList();
      });

    });

          ouvidor2 = db.collection("alunos").snapshots().listen((res) {

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
          title: Text('Dar notas para os alunos'),
          
      ),
            body: StreamBuilder<QuerySnapshot>(
              stream: db.collection("aluno").snapshots(),
              builder: (context, snapshot){
                switch (snapshot.connectionState) {
                   
                  case ConnectionState.none:
                    return Center(child: Text("Erro ao conectar no Firebase"));
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:return ListView.builder(
                    itemCount: alunos.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: ListTile(
                            title:
                              Text(alunos[index].nome, style: TextStyle(fontSize: 20, color: Colors.white)),
                            subtitle:
                               
                              TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: true,
                                  obscureText: true,
                                  controller: txtNotaMat,
                                  decoration: InputDecoration(
                                    
                                    hintStyle: TextStyle(color: Colors.white),
                                    labelText: "Nota Matemática",
                                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                  onSaved: (value) => txtNotaMat.text = value,
                                 ),
                          ),

                          
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