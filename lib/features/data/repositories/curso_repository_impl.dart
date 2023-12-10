import 'dart:convert';

import 'package:vr_flutter_project/features/http/exceptions.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/models/curso_model.dart';
import 'package:vr_flutter_project/features/repositories/curso_repository.dart';

class CursoRepositoryImpl implements CursoRepository {
  final IHttpClient client;

  CursoRepositoryImpl({required this.client});

  @override
  Future<List<CursoModel>> todosCursos() async {
    final response =
        await client.get(url: 'http://localhost:3000/curso/cursos');

    if (response.statusCode == 200) {
      final List<CursoModel> cursos = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final CursoModel curso = CursoModel.fromMap(item);
        cursos.add(curso);
      }).toList();

      return cursos;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é valida');
    } else {
      throw Exception('Não foi possivel achar os cursos');
    }
  }

  @override
  Future<void> criarCurso(String descricao, String ementa) async {
    try {
      final response =
          await client.post(url: 'http://localhost:3000/curso/criar', body: {
        'descricao': descricao,
        'ementa': ementa,
      });

      if (response.statusCode == 201) {
      } else {
        throw Exception(
            'Falhou ao criar o curso. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao criar o curso. $e');
    }
  }

  @override
  Future<void> atualizarCurso(int id, String descricao, String ementa) async {
    try {
      final response =
          await client.put(url: 'http://localhost:3000/curso/$id', body: {
        'descricao': descricao,
        'ementa': ementa,
      });
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Falhou ao atualizar o curso. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao atualizar o curso. $e');
    }
  }

  @override
  Future<void> deletarCurso(int id) async {
    try {
      final response =
          await client.delete(url: 'http://localhost:3000/curso/$id');
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Falhou ao deletar o curso. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao deletar o curso. $e');
    }
  }
}
