import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:exercicio_final_parte2/estruturas/struct_prof.dart';


// tela de login professor

class LoginProf extends StatefulWidget {
  @override
  _LoginProfState createState() => _LoginProfState();
}

class _LoginProfState extends State<LoginProf> {
  var txtEmailProf = TextEditingController();
  var txtSenhaProf = TextEditingController();
  var formKeyDois = GlobalKey<FormState>();
  EProf prof;
  int erro=0;
  
 // EProf _currentProf1 = EProf();

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
        title: Text("Login Professor"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  txtEmailProf.text = "";
                  txtSenhaProf.text = "";
                });
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Form(
          key: formKeyDois,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.login_rounded,
                  color: Theme.of(context).buttonColor, size: 120),
              SizedBox(height: 30),
              TextFormField(
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  controller: txtEmailProf,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Theme.of(context).buttonColor,
                    ),
                    hintText: "O seu email",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  onSaved: (value) => txtEmailProf.text = value,
                  validator: (value) {
                    return (value.isEmpty) ? "Informe o valor" : null;
                  }),
              TextFormField(
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  obscureText: true,
                  controller: txtSenhaProf,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Theme.of(context).buttonColor,
                    ),
                    hintText: " A sua senha",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  onSaved: (value) => txtSenhaProf.text = value,
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
                  onPressed: () async {
                    if (formKeyDois.currentState.validate()) {                   
                      setState(() {
                        formKeyDois.currentState.save();
                        for(int i = 0;i<professores.length;i++){
                          
                            if(professores[i].email.contains(txtEmailProf.text) && professores[i].senha.contains(txtSenhaProf.text)){      
                              erro++;
                              Navigator.pushNamed(
                                context,
                                '/telaProf',
                                
                            );
                            }
                          
                        }
                        
                      if(erro == 0){
                        showDialog(
                             context: context,
                             builder: (BuildContext context) {
                                 
                                return AlertDialog(
                                title: new Text("Email ou senha errados"),
                                  content: new Text(
                                     "Clique em ainda não é cadastrado, e se cadastre"),
                                );
                              });
                      }


                      });
                    }
                  }
                  ,
                  child: Text('Fazer Login',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),

              SizedBox(height: 15),

              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/cadProf',
                  );
                },
                child: Text("Ainda não é cadastrado? se cadastre aqui!",
                    style: TextStyle(decoration: TextDecoration.underline)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
