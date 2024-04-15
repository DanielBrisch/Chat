import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagem {
  String id;
  String mensagem;
  DateTime hora;

  Mensagem({required this.id, required this.mensagem, required this.hora});

  Mensagem.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        mensagem = map["mensagem"],
        hora = (map['data'] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    return {"id": id, "mensagem": mensagem, "data": hora};
  }
}
