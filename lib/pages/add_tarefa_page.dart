import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/models/tarefa_model.dart';
import 'package:todo_list/modules/gerador_id.dart';
import 'package:todo_list/repositories/tarefas_repositore.dart';
import 'package:todo_list/widgets/my_text_field.dart';

class NovaTarefaPage extends StatelessWidget {
  const NovaTarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper dbHelper = DatabaseHelper();
    TextEditingController _tituloTarefa = TextEditingController();
    TextEditingController _descricaoTarefa = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tarefa'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myTextField(
                'Titulo',
                'Trabalho de casa',
                _tituloTarefa,
              ),
              const SizedBox(height: 10.0),
              myTextField(
                'Descrição',
                'Fazer atividade de matematica',
                _descricaoTarefa,
              ),
              SizedBox(
                height: 300,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<TarefasRepositore>(context, listen: false)
                            .addTarefa(
                          context,
                          Tarefa(
                            id: gerarId(),
                            titulo: _tituloTarefa.text,
                            descricao: _descricaoTarefa.text,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        'ENVIAR',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
