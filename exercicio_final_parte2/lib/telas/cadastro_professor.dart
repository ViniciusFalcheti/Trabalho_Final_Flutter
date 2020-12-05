//tela de cadastro de professor

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/estruturas/struct_prof.dart';
import 'package:flutter/material.dart';

class CadastroProfessor extends StatefulWidget {
  final EProf prof;
  CadastroProfessor({this.prof});

  @override
  _CadastroProfessorState createState() => _CadastroProfessorState();
}

class _CadastroProfessorState extends State<CadastroProfessor> {
  //Armazenar valores de login e senha
  var formKey = GlobalKey<FormState>();
  var txtCadEmailProf = TextEditingController();
  var txtCadSenhaProf = TextEditingController();
  var txtNomeProf = TextEditingController();
  String dropdownValue = 'Primeira série';

 var db = FirebaseFirestore.instance;
 

 List<EProf> professores = List();

 StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState() {
    super.initState();

  ouvidor?.cancel();

  ouvidor = db.collection("professores").snapshots().listen((res) {

      setState(() {
        professores = res.docs.map((e) => EProf.fromMap(e.data(), e.id)).toList();
      });

  });

    
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Cadastro de professor"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    txtCadEmailProf.text = "";
                    txtCadSenhaProf.text = "";
                    txtNomeProf.text = "";
                  });
                })
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Icon(Icons.app_registration,
                      color: Theme.of(context).buttonColor, size: 120),
                      
                  TextFormField(
                      style: TextStyle(color: Colors.white),
                      autofocus: true,
                      controller: txtNomeProf,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).buttonColor,
                        ),
                        hintText: "Seu nome completo",
                        helperStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: "Nome",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onSaved: (input) => txtNomeProf.text = input,
                      validator: (value) {
                        return (value.isEmpty) ? "Informe o valor" : null;
                      }),
                                      
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    autofocus: true,
                    controller: txtCadSenhaProf,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
                        color: Theme.of(context).buttonColor,
                      ),
                      hintText: "Escolha uma senha",
                      helperStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      labelText: "Senha",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    onSaved: (input) => txtCadSenhaProf.text = input,
                    validator: (input) => input.length < 8
                        ? 'A senha precisa ter no mínimo 8 caracteres'
                        : null,
                  ),

                  TextFormField(
                      style: TextStyle(color: Colors.white),
                      autofocus: true,
                      controller: txtCadEmailProf,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).buttonColor,
                        ),
                        hintText: "Email",
                        helperStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: "Email",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onSaved: (input) => txtCadEmailProf.text = input,
                      validator: (input) {
                        return (input.isEmpty) ? "Informe o valor" : null;
                      }),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.home_work,
                          color: Theme.of(context).buttonColor),
                          SizedBox(width: 15),
                      Text('Série ',
                          style: TextStyle(fontSize: 22, color: Colors.white)),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: dropdownValue,
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
                            dropdownValue = newValue;
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
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          //add novo documento a coleção professores
                            await db.collection("professores").add(
                              {
                                "nome" : txtNomeProf.text,
                                "email" : txtCadEmailProf.text,
                                "senha" : txtCadSenhaProf.text,
                                "serie" : dropdownValue,
                              }
                            );

                            

                            formKey.currentState.save();
                            Navigator.pop(context);
                          
                        }
                      },
                      child: Text('Fazer Cadastro',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class UserCredential {
}
