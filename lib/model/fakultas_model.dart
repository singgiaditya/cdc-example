class FakultasModel {
  final int id;
  final String name;

  FakultasModel({required this.id, required this.name});

  factory FakultasModel.fromMap(Map<String, dynamic> map) {
    return FakultasModel(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }
}
