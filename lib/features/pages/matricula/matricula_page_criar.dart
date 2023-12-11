import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/data/repositories/aluno_repository_impl.dart';
import 'package:vr_flutter_project/features/data/repositories/curso_repository_impl.dart';
import 'package:vr_flutter_project/features/data/repositories/matricula_repository_impl.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/stores/aluno_store.dart';
import 'package:vr_flutter_project/features/stores/curso_store.dart';
import 'package:vr_flutter_project/features/stores/matricula_store.dart';

class CriarMatriculaPage extends StatefulWidget {
  const CriarMatriculaPage({Key? key}) : super(key: key);

  @override
  State<CriarMatriculaPage> createState() => _CriarMatriculaState();
}

class _CriarMatriculaState extends State<CriarMatriculaPage> {
  String selectedAluno = '';
  String selectedCurso = '';
  int selectedAlunoId = 0;
  int selectedCursoId = 0;

  final CursoStore cursostore =
      CursoStore(repository: CursoRepositoryImpl(client: HttpClientImpl()));

  final MatriculaStore store = MatriculaStore(
      repository: MatriculaRepositoryImpl(client: HttpClientImpl()));

  final AlunoStore alunostore =
      AlunoStore(repository: AlunoRepositoryImpl(client: HttpClientImpl()));

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await cursostore.todosCursos();
    await alunostore.todosAlunos();
    selectedAluno =
        alunostore.state.value.isNotEmpty ? alunostore.state.value[0].nome : '';
    selectedCurso = cursostore.state.value.isNotEmpty
        ? cursostore.state.value[0].descricao
        : '';
    selectedAlunoId =
        alunostore.state.value.isNotEmpty ? alunostore.state.value[0].id : 0;
    selectedCursoId =
        cursostore.state.value.isNotEmpty ? cursostore.state.value[0].id : 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Criar Matricula',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDropdown(
              'Aluno',
              alunostore.state.value.map((aluno) => aluno.nome).toList(),
              selectedAluno,
              alunostore.state.value.map((aluno) => aluno.id).toList(),
              (String? value, int? id) {
                setState(() {
                  selectedAluno = value!;
                  selectedAlunoId = id ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            buildDropdown(
              'Curso',
              cursostore.state.value.map((curso) => curso.descricao).toList(),
              selectedCurso,
              cursostore.state.value.map((curso) => curso.id).toList(),
              (String? value, int? id) {
                setState(() {
                  selectedCurso = value!;
                  selectedCursoId = id ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedAluno.isNotEmpty && selectedCurso.isNotEmpty) {
                  await store.criarMatricula(selectedCursoId, selectedAlunoId);
                  await store.todasMatriculas();
                  setState(() {});
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String value,
      List<int> ids, void Function(String?, int?) onChanged) {
    if (items.isEmpty) {
      return Text('Sem $label disponível');
    }

    return DropdownButton<String>(
      isExpanded: true,
      hint: Text(
        'Selecione $label',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      value: value,
      onChanged: (String? newValue) {
        int index = items.indexOf(newValue!);
        int? id = index != -1 ? ids[index] : null;
        onChanged(newValue, id);
      },
    );
  }
}
