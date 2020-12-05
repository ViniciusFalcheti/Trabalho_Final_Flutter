import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercicio_final_parte2/telas/cadastrar_alunos.dart';
import 'package:exercicio_final_parte2/telas/dar_notas.dart';
import 'package:exercicio_final_parte2/telas/tela_presenca.dart';
import 'package:exercicio_final_parte2/telas/telaedit_alunos.dart';
import 'package:exercicio_final_parte2/telas/ver_notas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:exercicio_final_parte2/telas/cadastro_professor.dart';
import 'package:exercicio_final_parte2/telas/login_aluno.dart';
import 'package:exercicio_final_parte2/telas/tela_aluno.dart';
import 'package:exercicio_final_parte2/telas/tela_professor.dart';
import 'package:flutter/material.dart';
import 'package:exercicio_final_parte2/telas/login_professor.dart';
import 'package:exercicio_final_parte2/telas/sobre.dart';





void main() async{
  //registrar firebase no app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sistema Escolar',
    theme: ThemeData(
      backgroundColor: Color.fromRGBO(33, 34, 38, 1),
      primaryColor: Color.fromRGBO(49, 51, 56, 1),
      fontFamily: 'Arial',
      hoverColor: Color.fromRGBO(227, 68, 64, 1),
      buttonColor: Color.fromRGBO(196, 33, 28, 1),
    ),
    initialRoute: '/home',
    routes: {
      '/home': (context) => TelaHome(),
      '/loginAluno': (context) => LoginAluno(),
      '/loginProf': (context) => LoginProf(),
      '/cadProf': (context) => CadastroProfessor(),
      '/telaAluno': (context) => TelaAluno(),
      '/telaProf': (context) => TelaProf(),
      '/sobre': (context) => TelaSobre(), 
      '/cadAluno': (context) => CadAluno(),   
      '/editAluno' : (context) => TelaEditAlunos(),
      '/presenca' : (context) => TelaPresenca(),
      '/verNotas' : (context) => VerNotas(),
      '/darNotas' : (context) => DarNotas(),
    },
  ));

  //teste do firebase

 // var db = FirebaseFirestore.instance;

  //db.collection("alunos").add(
    //{
       // "nome" : "Jorge Aragão",
        //"ra" : "1234567891234",
        //"senha" : "12345678",
        //"serie" : "Primeira série",
    //}
  //);
  
  //print("Documento add com sucesso");

}

//
// TELA PRINCIPAL
//
class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    
      body: Container(
        padding: EdgeInsets.all(60),
        child: ListView(

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              Container(
                child: Image.asset(
                  'imagens/logo_sistema_escolar.png',
                  height: 350,       
                ),
              ),
            ),
            
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
                child: Text('Aluno',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/loginAluno',
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
                    '/loginProf',
                  );
                },
                child: Text('Professor',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            SizedBox(height: 15),
            ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              hoverColor: Theme.of(context).hoverColor,
              buttonColor: Theme.of(context).buttonColor,
              minWidth: 150,
              height: 100,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/sobre',
                  );
                },
                child: Text('Sobre',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

