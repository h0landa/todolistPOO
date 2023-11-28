import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa {
  String id;
  String titulo;
  String descricao;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
  });
  factory Tarefa.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Tarefa(
      id: doc.id,
      titulo: data['titulo'] ?? '',
      descricao: data['descricao'] ?? '',
    );
  }
}
