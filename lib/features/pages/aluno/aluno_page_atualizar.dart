import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/data/repositories/aluno_repository_impl.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/models/aluno_model.dart';
import 'package:vr_flutter_project/features/stores/aluno_store.dart';

class AtualizarAlunoPage extends StatefulWidget {
  const AtualizarAlunoPage({Key? key}) : super(key: key);
  @override
  State<AtualizarAlunoPage> createState() => _AtualizarAlunoState();
}

@override
class _AtualizarAlunoState extends State<AtualizarAlunoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AlunoStore store =
      AlunoStore(repository: AlunoRepositoryImpl(client: HttpClientImpl()));

  TextEditingController nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments as AlunoModel;
    nomeController.text = arguments.nome;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição de Aluno',
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
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome do curso'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome do curso não pode estar vazio';
                    }
                    if (value.trim().length < 3) {
                      return 'Nome do curso está muito pequeno';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        int id = arguments.id;
                        String nome = nomeController.text;
                        await store.atualizarAluno(id, nome);
                        setState(() {});
                        Navigator.pop(context, true);
                      }
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        fixedSize: const Size(100, 15)),
                    child: const Text('Atualizar')),
              ],
            )),
      ),
    );
  }
}
