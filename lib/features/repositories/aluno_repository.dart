import 'package:vr_flutter_project/features/models/aluno_model.dart';

abstract class AlunoRepository {
  Future<List<AlunoModel>> todosAlunos();
  Future<void> criarAluno(String nome);
  Future<void> atualizarAluno(int id, String nome);
  Future<void> deletarAluno(int id);



}
