import 'dart:convert';

import 'package:vr_flutter_project/features/http/exceptions.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/models/aluno_model.dart';
import 'package:vr_flutter_project/features/repositories/aluno_repository.dart';

class AlunoRepositoryImpl implements AlunoRepository {
  final IHttpClient client;

  AlunoRepositoryImpl({required this.client});
  @override
  Future<void> atualizarAluno(int id, String nome) async {
    try {
      final response = await client
          .put(url: 'http://localhost:3000/aluno/$id', body: {'nome': nome});
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Falhou ao atualizar o aluno. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao atualizar o aluno. $e');
    }
  }

  @override
  Future<void> criarAluno(String nome) async {
    try {
      final response = await client
          .post(url: 'http://localhost:3000/aluno/criar', body: {'nome': nome});
      if (response.statusCode == 201) {
      } else {
        throw Exception(
            'Falhou ao criar o aluno. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao atualizar o curso. $e');
    }
  }

  @override
  Future<void> deletarAluno(int id) async {
    try {
      final response =
          await client.delete(url: 'http://localhost:3000/aluno/$id');
      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Falhou ao deletar o aluno. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falhou ao deletar o aluno. $e');
    }
  }

  @override
  Future<List<AlunoModel>> todosAlunos() async {
    final response =
        await client.get(url: 'http://localhost:3000/aluno/alunos');

    if (response.statusCode == 200) {
      final List<AlunoModel> alunos = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final AlunoModel aluno = AlunoModel.fromMap(item);
        alunos.add(aluno);
      }).toList();

      return alunos;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é valida');
    } else {
      throw Exception('Não foi possivel achar os alunos');
    }
  }
}
