import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/models/tarefa_model.dart';
import 'package:todo_list/pages/add_tarefa_page.dart';
import 'package:todo_list/pages/edit_tarefa_page.dart';
import 'package:todo_list/repositories/tarefas_repositore.dart';
import 'package:todo_list/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TarefasRepositore())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList Flutter',
      theme: myTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<String> tarefasSelecionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo-List'),
      ),
      body: StreamBuilder<List<Tarefa>>(
        stream: Provider.of<TarefasRepositore>(context).tarefasStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Erro ao buscar tarefas');
          } else {
            final tarefas = snapshot.data ?? [];
            return ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                return Dismissible(
                  key: Key(tarefa.id),
                  onDismissed: (direction) {
                    print('AAAAAAAAAA');
                    Provider.of<TarefasRepositore>(context, listen: false)
                        .deleteTarefa(tarefa);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                          color: Colors.grey[400]!,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        tarefa.titulo,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Roboto Condensed',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        tarefa.descricao,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto Condensed',
                          color: Colors.grey,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: () {
                                Provider.of<TarefasRepositore>(context,
                                        listen: false)
                                    .deleteTarefa(tarefa);
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.green[300],
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditTarefa(
                                      tarefa: tarefa,
                                    ),
                                  ),
                                );
                              },
                              icon: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.blue[300],
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NovaTarefaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
