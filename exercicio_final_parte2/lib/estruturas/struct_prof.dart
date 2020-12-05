class EProf {
  String id;
  String nome;
  String senha;
  String serie;
  String email;

  EProf(
    this.id,
    this.nome,
    this.senha,
    this.serie,
    this.email,
  );

  EProf.fromMap(Map<String, dynamic> map, String id){
      this.id = id ?? '';
      this.nome = map["nome"];
      this.senha = map["senha"];
      this.serie = map["serie"];
      this.email = map["email"];
  }
}
