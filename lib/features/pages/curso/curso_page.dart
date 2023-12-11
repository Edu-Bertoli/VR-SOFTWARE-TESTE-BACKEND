import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/data/repositories/curso_repository_impl.dart';
import 'package:vr_flutter_project/features/http/http_client.dart';
import 'package:vr_flutter_project/features/routes/app_routes.dart';
import 'package:vr_flutter_project/features/stores/curso_store.dart';

class CursoPage extends StatefulWidget {
  const CursoPage({Key? key}) : super(key: key);
  @override
  State<CursoPage> createState() => _CursoState();
}

class _CursoState extends State<CursoPage> {
  final CursoStore store =
      CursoStore(repository: CursoRepositoryImpl(client: HttpClientImpl()));

  @override
  void initState() {
    super.initState();
    store.todosCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Lista de Cursos',
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
                await Navigator.of(context).pushNamed(AppRoutes.cursocriar);
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
                        title: Text(item.descricao),
                        iconColor: Colors.orange,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              child: const Icon(Icons.edit),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.cursoatualizar,
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
                                                'Deseja excluir o usuario?'),
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
                                                            .deletarCurso(
                                                                item.id);
                                                        await store
                                                            .todosCursos();
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
                              item.ementa,
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
