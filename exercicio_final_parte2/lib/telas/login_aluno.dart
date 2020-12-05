//tela de login aluno

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_aluno.dart';
import 'package:flutter/material.dart';

class LoginAluno extends StatefulWidget {

  String nomealuno;

  @override
  _LoginAlunoState createState() => _LoginAlunoState();
}




class _LoginAlunoState extends State<LoginAluno> {

  var txtLoginAluno = TextEditingController();
  var txtSenhaAluno = TextEditingController();
  EAluno aluno;
  int erro=0;

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
          title: Text("Login Aluno"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    txtLoginAluno.text = "";
                    txtSenhaAluno.text = "";
                  });
                })
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.login_rounded,
                  color: Theme.of(context).buttonColor, size: 120),
              SizedBox(height: 30),
              TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 13,
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  obscureText: false,
                  controller: txtLoginAluno,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.account_box,
                      color: Theme.of(context).buttonColor,
                    ),
                    hintText: "Qual o seu RA",
                    helperStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "RA",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  validator: (value) {
                    return (value.isEmpty) ? "Informe o valor" : null;
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  obscureText: true,
                  controller: txtSenhaAluno,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Theme.of(context).buttonColor,
                    ),
                    hintText: "Qual a sua senha",
                    helperStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  validator: (value) {
                    return (value.isEmpty) ? "Informe o valor" : null;
                  }),
              SizedBox(height: 30),
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
                    erro = 0;

                    for(int i = 0;i<alunos.length;i++){
                          
                            if(alunos[i].ra.contains(txtLoginAluno.text) && alunos[i].senha.contains(txtSenhaAluno.text) && txtLoginAluno.text != null && txtSenhaAluno.text != null){  
                              widget.nomealuno = alunos[i].nome; 
                              erro++;
                              Navigator.pushNamed(
                                context,
                                '/telaAluno',
                                
                            );
                            }
                          
                        }
                        
                      if(erro == 0){
                        showDialog(
                             context: context,
                             builder: (BuildContext context) {
                                 
                                return AlertDialog(
                                title: new Text("RA ou senha errados"),
                                  content: new Text(
                                     "Se o erro persistir consulte a secrataria"),
                                );
                              });
                      }
                  },
                  child: Text('Fazer Login',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              )
            ],
          ),
        ));
  }
}
