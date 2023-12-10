import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/http/exceptions.dart';
import 'package:vr_flutter_project/features/models/matricula_model.dart';
import 'package:vr_flutter_project/features/repositories/matricula_repository.dart';

class MatriculaStore {
  final MatriculaRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<MatriculaModel>> state =
      ValueNotifier<List<MatriculaModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  MatriculaStore({required this.repository});

  Future todasMatriculas() async {
    isLoading.value = true;
    try {
      final result = await repository.todasMatriculas();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future criarMatricula(int cursoId, int alunoId) async {
    isLoading.value = true;

    try {
      await repository.criarMatricula(cursoId, alunoId);
      await todasMatriculas();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future deletarMatricula(int id) async {
    isLoading.value = true;
    try {
      await repository.deletarMatricula(id);
      await todasMatriculas();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
