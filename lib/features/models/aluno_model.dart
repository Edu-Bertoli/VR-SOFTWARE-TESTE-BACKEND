class AlunoModel {
  final int id;
  final String nome;

  AlunoModel({required this.id, required this.nome});

  factory AlunoModel.fromMap(Map<String, dynamic> map) {
    return AlunoModel(id: map['id'], nome: map['nome']);
  }

  factory AlunoModel.fromJson(Map<String, dynamic> json) {
    return AlunoModel(id: json['id'], nome: json['nome']);
  }
}
