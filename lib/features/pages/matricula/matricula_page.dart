import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/data/repositories/matricula_repository_impl.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/routes/app_routes.dart';
import 'package:vr_flutter_project/features/stores/matricula_store.dart';

class MatriculaPage extends StatefulWidget {
  const MatriculaPage({Key? key}) : super(key: key);
  @override
  State<MatriculaPage> createState() => _MatriculaState();
}

class _MatriculaState extends State<MatriculaPage> {
  final MatriculaStore store = MatriculaStore(
      repository: MatriculaRepositoryImpl(client: HttpClientImpl()));
  @override
  void initState() {
    super.initState();
    store.todasMatriculas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Lista de Matriculas',
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
                await Navigator.of(context).pushNamed(AppRoutes.matriculacriar);
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
                        title: Text(item.aluno),
                        iconColor: Colors.orange,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                                            .deletarMatricula(
                                                                item.id);
                                                        await store
                                                            .todasMatriculas();
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
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              item.curso,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
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
