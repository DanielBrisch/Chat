class Device {
  String id;

  Device({required this.id});

  Device.fromMap(Map<String, dynamic> map) : id = map["id"];

  Map<String, dynamic> toMap() {
    return {"id": id};
  }
}
