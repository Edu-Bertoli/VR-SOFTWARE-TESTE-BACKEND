class CursoModel {
  final int id;
  final String descricao;
  final String ementa;

  CursoModel({required this.id, required this.descricao, required this.ementa});

  factory CursoModel.fromMap(Map<String, dynamic> map) {
    return CursoModel(
        id: map['id'], descricao: map['descricao'], ementa: map['ementa']);
  }

  factory CursoModel.fromJson(Map<String, dynamic> json) {
    return CursoModel(
      id: json['id'],
      descricao: json['descricao'],
      ementa: json['ementa'],
    );
  }
}
