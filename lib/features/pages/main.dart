import 'package:flutter/material.dart';
import 'package:vr_flutter_project/features/pages/aluno/aluno_page.dart';
import 'package:vr_flutter_project/features/pages/aluno/aluno_page_atualizar.dart';
import 'package:vr_flutter_project/features/pages/aluno/aluno_page_criar.dart';
import 'package:vr_flutter_project/features/pages/curso/curso_page.dart';
import 'package:vr_flutter_project/features/pages/curso/curso_page_atualizar.dart';
import 'package:vr_flutter_project/features/pages/curso/curso_page_criar.dart';
import 'package:vr_flutter_project/features/pages/home.dart';
import 'package:vr_flutter_project/features/pages/matricula/matricula_page.dart';
import 'package:vr_flutter_project/features/pages/matricula/matricula_page_criar.dart';
import 'package:vr_flutter_project/features/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Software Vr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.home: (_) => const Home(),
        AppRoutes.curso: (_) => const CursoPage(),
        AppRoutes.cursocriar: (_) => const CriarCursoPage(),
        AppRoutes.cursoatualizar: (_) => const AtualizaCursoPage(),
        AppRoutes.aluno: (_) => const AlunoPage(),
        AppRoutes.alunocriar: (_) => const CriarAlunoPage(),
        AppRoutes.alunoatualizar: (_) => const AtualizarAlunoPage(),
        AppRoutes.matricula: (_) => const MatriculaPage(),
        AppRoutes.matriculacriar:(_) => const CriarMatriculaPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 50),
          const Text(
            'VR SOFTWARE',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 100,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'Bem-vindo, para ver pendências dos cursos vá em cursos, para ver sobre alunos vá em alunos ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16)),
          ),
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed(AppRoutes.curso);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.orange,
                            fixedSize: const Size(90, 15)),
                        child: const Text('Cursos')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed(AppRoutes.aluno);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.orange,
                            fixedSize: const Size(90, 15)),
                        child: const Text('Alunos')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed(AppRoutes.matricula);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.orange,
                            fixedSize: const Size(100, 15)),
                        child: const Text('Matriculas')),
                  )
                ]),
          )
        ]),
      ),
    );
  }
}
