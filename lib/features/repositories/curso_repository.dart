import 'package:vr_flutter_project/features/models/curso_model.dart';

abstract class CursoRepository {
  Future<List<CursoModel>> todosCursos();
  Future<void> criarCurso(String descricao, String ementa);
  Future<void> atualizarCurso(int id ,String descricao, String ementa);
  Future<void> deletarCurso(int id);
}
