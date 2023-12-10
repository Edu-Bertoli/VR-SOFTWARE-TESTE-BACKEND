import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/data/repositories/aluno_repository_impl.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/routes/app_routes.dart';
import 'package:vr_flutter_project/features/stores/aluno_store.dart';

class AlunoPage extends StatefulWidget {
  const AlunoPage({Key? key}) : super(key: key);
  @override
  State<AlunoPage> createState() => _AlunoState();
}

@override
class _AlunoState extends State<AlunoPage> {
  final AlunoStore store =
      AlunoStore(repository: AlunoRepositoryImpl(client: HttpClientImpl()));

  @override
  void initState() {
    super.initState();
    store.todosAlunos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Lista de Alunos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Container(
            width: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: IconButton(
              icon: const Icon(Icons.add),
              color: Colors.white,
              onPressed: () async {
                await Navigator.of(context).pushNamed(AppRoutes.alunocriar);
              },
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([store.isLoading, store.erro, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (store.state.value.isEmpty) {
            return const Center(
                child: Text(
              'Nenhum item na lista',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ));
          } else {
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 32,
                    ),
                itemCount: store.state.value.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, index) {
                  final item = store.state.value[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(item.nome),
                        iconColor: Colors.orange,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              child: const Icon(Icons.edit),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.alunoatualizar,
                                    arguments: item);
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: const Icon(Icons.delete),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => Center(
                                          child: AlertDialog(
                                            title: const Text(
                                                'Deseja excluir o aluno?'),
                                            content: const Text(
                                                'Aperte sim para confirmar'),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        await store
                                                            .deletarAluno(
                                                                item.id);
                                                        await store
                                                            .todosAlunos();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.orange,
                                                              fixedSize:
                                                                  const Size(
                                                                      60, 15)),
                                                      child: const Text('Sim')),
                                                  const SizedBox(width: 10),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.orange,
                                                              fixedSize:
                                                                  const Size(
                                                                      60, 15)),
                                                      child: const Text('Não'))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  
                });
          }
        },
      ),
    );
  }
}
