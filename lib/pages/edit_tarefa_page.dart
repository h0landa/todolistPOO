import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/tarefa_model.dart';
import 'package:todo_list/modules/gerador_id.dart';
import 'package:todo_list/repositories/tarefas_repositore.dart';
import 'package:todo_list/widgets/my_text_field.dart';

class EditTarefa extends StatefulWidget {
  Tarefa tarefa;
  EditTarefa({super.key, required this.tarefa});

  @override
  State<EditTarefa> createState() => _EditTarefaState();
}

class _EditTarefaState extends State<EditTarefa> {
  TextEditingController _tituloTarefa = TextEditingController();
  TextEditingController _descricaoTarefa = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _tituloTarefa.text = widget.tarefa.titulo;
    _descricaoTarefa.text = widget.tarefa.descricao;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tarefa'),
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
                            .editarTarefa(
                          Tarefa(
                            id: widget.tarefa.id,
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
