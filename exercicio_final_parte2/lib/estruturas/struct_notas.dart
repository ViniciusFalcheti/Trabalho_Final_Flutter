class ENotas {
  String id;
  String bimestre;
  String notamat;
  String notaport;
  String notaciencias;
  String notageo;
  String notahistoria;
  String idAluno;

  ENotas(
    this.id,
    this.bimestre,
    this.notamat,
    this.notaport,
    this.notaciencias,
    this.notageo,
    this.notahistoria,
    this.idAluno,
  );


  ENotas.fromMap(Map<String, dynamic> map, String id){

        this.id = id ?? '';
        this.bimestre = map["bimestre"];
        this.notamat = map["notamat"];
        this.notaport =  map ["notaport"];
        this.notaciencias =  map["notaciencias"];
        this.notageo =  map["notageo"];
        this.notahistoria = map["notahistoria"];
        this.idAluno = map["idAluno"];
  }
}