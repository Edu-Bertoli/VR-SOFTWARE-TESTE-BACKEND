import 'package:vr_flutter_project/features/models/matricula_model.dart';

abstract class MatriculaRepository {
  Future<List<MatriculaModel>> todasMatriculas();
  Future<void> criarMatricula(int cursoId, int alunoId);
  Future<void> deletarMatricula(int id);
}
