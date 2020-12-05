//
// TELA SOBRE
//
import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Sobre'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: Center(
          child: ListView(
            children: [ 
              Column(
                children: [
                  Text("Aluno: Vinicius Parigio Falcheti\nRA:2840481923016",
                    style: TextStyle(fontSize: 16, color: Colors.white),),
                  SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                      Container(
                        child: Image.asset(
                          'imagens/foto.jpg',
                          height: 300,
                      
                        ),
                      ),
                  ),
                  SizedBox(height: 20),
                  Text('Título do Projeto: Sistema Escolar',
                    style: TextStyle(fontSize: 26, color: Colors.white,fontWeight: FontWeight.bold)),
                  SizedBox(height: 14),
                  Text('Objetivo do sistema é criar um cadastro dos alunos e professores de uma escola, nela haverá um cadastro para professor e outro para aluno, o aluno poderá checar suas notas nas matérias e o professor poderá cadastrar alunos, dar as notas para eles e visualizar suas notas, mas acabou que gastei tempo demais tentando implementar um banco de dados para armazanar os cadastros dos alunos e além disso não consegui me dedicar esta semana ao aplicativo por conta do trabalho, então a parte de passar os dados dos alunos para o login do aluno eu não consegui implementar e nem dar as notas, mas para a segunda parte do trabalho irei implementar isso e cumprir os objetivos primários do sistema.',
                    style: TextStyle(fontSize: 18, color: Colors.white,))
                    
                    
                ]
              ,)
            ],
          ),
        ),
      ),
    );
  }
}
