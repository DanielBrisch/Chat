import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagem {
  String id;
  String mensagem;
  DateTime hora;
  String deviceId;

  Mensagem(
      {required this.id,
      required this.mensagem,
      required this.hora,
      required this.deviceId});

  Mensagem.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        mensagem = map["mensagem"],
        hora = (map['hora'] as Timestamp).toDate(),
        deviceId = map["deviceId"];

  Map<String, dynamic> toMap() {
    return {"id": id, "mensagem": mensagem, "hora": hora, "deviceId": deviceId};
  }
}
