import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/tarefa_model.dart';

class TarefasRepositore extends ChangeNotifier {
  final CollectionReference _tarefasCollection =
      FirebaseFirestore.instance.collection('tarefas');

  Stream<List<Tarefa>> tarefasStream() {
    return _tarefasCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Tarefa(
          id: data['id'],
          titulo: data['titulo'],
          descricao: data['descricao'],
        );
      }).toList();
    });
  }

  Future<Tarefa?> getTarefa(String docId) async {
    try {
      DocumentSnapshot doc = await _tarefasCollection.doc(docId).get();
      if (doc.exists) {
        return Tarefa.fromFirestore(doc);
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar documento $e');
      return null;
    }
  }

  Future<void> addTarefa(BuildContext context, Tarefa tarefa) async {
    await _tarefasCollection.doc(tarefa.id).set({
      'id': tarefa.id,
      'titulo': tarefa.titulo,
      'descricao': tarefa.descricao,
    });
  }

  Future<void> editarTarefa(Tarefa tarefaAtualizada) async {
    await _tarefasCollection.doc(tarefaAtualizada.id).update({
      'titulo': tarefaAtualizada.titulo,
      'descricao': tarefaAtualizada.descricao,
    });
  }

  deleteTarefa(Tarefa tarefa) async {
    await _tarefasCollection.doc(tarefa.id).delete();
  }
}
