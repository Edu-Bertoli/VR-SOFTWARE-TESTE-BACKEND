import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/http/exceptions.dart';
import 'package:vr_flutter_project/features/models/aluno_model.dart';
import 'package:vr_flutter_project/features/repositories/aluno_repository.dart';

class AlunoStore {
  final AlunoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<AlunoModel>> state =
      ValueNotifier<List<AlunoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  AlunoStore({required this.repository});

  Future todosAlunos() async {
    isLoading.value = true;
    try {
      final result = await repository.todosAlunos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future criarAluno(String name) async {
    isLoading.value = true;
    try {
      await repository.criarAluno(name);
      await todosAlunos();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future atualizarAluno(int id, String name) async {
    isLoading.value = true;
    try {
      await repository.atualizarAluno(id, name);
      await todosAlunos();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  Future deletarAluno(int id) async {
    isLoading.value = true;
    try {
      await repository.deletarAluno(id);
      await todosAlunos();
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
