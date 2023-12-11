import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/http/exceptions.dart';
import 'package:vr_flutter_project/features/models/curso_model.dart';
import 'package:vr_flutter_project/features/repositories/curso_repository.dart';

class CursoStore {
  final CursoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<CursoModel>> state =
      ValueNotifier<List<CursoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  CursoStore({required this.repository});

  Future todosCursos() async {
    isLoading.value = true;
    try {
      final result = await repository.todosCursos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future criarCurso(String descricao, String ementa) async {
    isLoading.value = true;
    try {
      await repository.criarCurso(descricao, ementa);
      await todosCursos();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future atualizarCurso(int id, String descricao, String ementa) async {
    isLoading.value = true;
    try {
      await repository.atualizarCurso(id, descricao, ementa);
      await todosCursos();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future deletarCurso(int id) async {
    isLoading.value = true;
    try {
      await repository.deletarCurso(id);
      await todosCursos();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
