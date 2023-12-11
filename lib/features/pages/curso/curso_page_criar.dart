import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/data/repositories/curso_repository_impl.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/stores/curso_store.dart';

class CriarCursoPage extends StatefulWidget {
  const CriarCursoPage({Key? key}) : super(key: key);
  @override
  State<CriarCursoPage> createState() => _CriarCursoState();
}

class _CriarCursoState extends State<CriarCursoPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CursoStore store =
      CursoStore(repository: CursoRepositoryImpl(client: HttpClientImpl()));

  TextEditingController descricaoController = TextEditingController();
  TextEditingController ementaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criação de Curso',
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
                  decoration: const InputDecoration(labelText: 'Nome do curso'),
                  controller: descricaoController,
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
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Ementa'),
                  controller: ementaController,
                ),
                const SizedBox(height: 40),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String descricao = descricaoController.text;
                        String ementa = ementaController.text;
                        await store.criarCurso(descricao, ementa);
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
