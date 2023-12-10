class MatriculaModel {
  final int id;
  final int alunoId;
  final int cursoId;
  final String aluno;
  final String curso;

  MatriculaModel(
      {required this.id,
      required this.alunoId,
      required this.cursoId,
      required this.aluno,
      required this.curso});

  factory MatriculaModel.fromMap(Map<String, dynamic> map) {
    return MatriculaModel(
        id: map['id'],
        alunoId: map['alunoId'],
        cursoId: map['cursoId'],
        aluno: map['aluno']['nome'],
        curso: map['curso']['descricao']);
  }

  factory MatriculaModel.fromJson(Map<String, dynamic> json) {
    return MatriculaModel(
        id: json['id'],
        alunoId: json['alunoId'],
        cursoId: json['cursoId'],
        aluno: json['aluno']['nome'],
        curso: json['curso']['descricao']);
  }
}
