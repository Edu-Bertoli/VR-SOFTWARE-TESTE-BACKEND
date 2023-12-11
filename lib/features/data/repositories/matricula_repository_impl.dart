import 'dart:convert';

import 'package:vr_flutter_project/features/http/exceptions.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/models/matricula_model.dart';
import 'package:vr_flutter_project/features/repositories/matricula_repository.dart';

class MatriculaRepositoryImpl implements MatriculaRepository {
  final IHttpClient client;

  MatriculaRepositoryImpl({required this.client});

  @override
  Future<void> criarMatricula(int cursoId, int alunoId) async {
    try {
      final response = await client.post(
          url: 'http://localhost:3000/matricula/criar',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'alunoId': alunoId, 'cursoId': cursoId}));
      if (response.statusCode == 201) {
      } else {
        throw Exception(
            'Falhou ao criar a matricula. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao criar a matricula. $e');
    }
  }

  @override
  Future<void> deletarMatricula(int id) async {
    try {
      final response =
          await client.delete(url: 'http://localhost:3000/matricula/$id');

      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Falhou ao deletar a matricula. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao deletar a matricula. $e');
    }
  }

  @override
  Future<List<MatriculaModel>> todasMatriculas() async {
    final response =
        await client.get(url: 'http://localhost:3000/matricula/matriculas');

    if (response.statusCode == 200) {
      final List<MatriculaModel> matriculas = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final MatriculaModel matricula = MatriculaModel.fromMap(item);
        matriculas.add(matricula);
      }).toList();

      return matriculas;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é valida');
    } else {
      throw Exception('Não foi possivel achar as matriculas');
    }
  }
}
