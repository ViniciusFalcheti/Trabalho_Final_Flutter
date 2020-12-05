import 'package:exercicio_final_parte2/estruturas/struct_notas.dart';

class EAluno {
  String id;
  String nome;
  String ra;
  String senha;
  String serie;
  ENotas notas;

  EAluno(
    this.id,
    this.nome,
    this.ra,
    this.senha,
    this.serie,
    this.notas,
  );

  EAluno.fromMap(Map<String, dynamic> map, String id){
        this.id = id ?? '';
        this.nome = map["nome"];
        this.ra = map["ra"];
        this.senha = map["senha"];
        this.serie = map["serie"];
        this.notas = map["notas"];
  }
}