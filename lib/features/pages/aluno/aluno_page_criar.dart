import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/data/repositories/aluno_repository_impl.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/stores/aluno_store.dart';

class CriarAlunoPage extends StatefulWidget {
  const CriarAlunoPage({Key? key}) : super(key: key);
  @override
  State<CriarAlunoPage> createState() => _CriarAlunoState();
}

@override
class _CriarAlunoState extends State<CriarAlunoPage> {
  final AlunoStore store =
      AlunoStore(repository: AlunoRepositoryImpl(client: HttpClientImpl()));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criação de Aluno',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
        centerTitle: true,
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome:'),
                  controller: nomeController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome do aluno não pode estar vazio';
                    }
                    if (value.trim().length < 3) {
                      return 'Nome do aluno está muito pequeno';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String nome = nomeController.text;
                        await store.criarAluno(nome);
                        setState(() {});
                        Navigator.pop(context, true);
                      }
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        fixedSize: const Size(100, 15)),
                    child: const Text('Cadastrar')),
              ],
            )),
      ),
    );
  }
}
