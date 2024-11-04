import 'package:cdc_form/model/fakultas_model.dart';

class ProdiModel {
  final int id;
  final FakultasModel fakultas;
  final String name;

  ProdiModel({required this.id, required this.fakultas, required this.name});

  factory ProdiModel.fromMap(Map<String, dynamic> map) {
    return ProdiModel(
        id: map['id'],
        fakultas: FakultasModel(
            id: map['fakultas_id'][0], name: map['fakultas_id'][1]),
        name: map['name']);
  }
}
