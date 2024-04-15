class Divice {
  String id;

  Divice({required this.id});

  Divice.fromMap(Map<String, dynamic> map) : id = map["id"];

  Map<String, dynamic> toMap() {
    return {"id": id};
  }
}
