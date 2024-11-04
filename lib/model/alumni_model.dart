import 'package:cdc_form/model/fakultas_model.dart';
import 'package:cdc_form/model/prodi_model.dart';

class AlumniModel {
  final int id;
  final String nim;
  final String name;
  final String alamat;
  final String email;
  final String nomor;
  final FakultasModel fakultas;
  final ProdiModel prodi;
  final String status;
  final String tahun;

  AlumniModel(
      {required this.id,
      required this.nim,
      required this.name,
      required this.alamat,
      required this.email,
      required this.nomor,
      required this.fakultas,
      required this.prodi,
      required this.status,
      required this.tahun});

  factory AlumniModel.fromMap(Map<String, dynamic> map) {
    return AlumniModel(
        id: map['id'],
        nim: map['nim'],
        name: map['name'],
        alamat: map['alamat'],
        email: map['email'],
        nomor: map['nomor'],
        fakultas: FakultasModel(
            id: map['fakultas_id'][0], name: map['fakultas_id'][1]),
        prodi: ProdiModel(
            id: map['prodi_id'][0],
            fakultas: FakultasModel(id: 0, name: "name"),
            name: map['prodi_id'][1]),
        status: map['status'],
        tahun: map['tahun']);
  }

  Map<String, dynamic> toMap() {
    return {
      "nim": nim,
      "name": name,
      "alamat": alamat,
      "email": email,
      "nomor": nomor,
      "fakultas_id": fakultas.id,
      "prodi_id": prodi.id,
      "status": status,
      "tahun": tahun,
    };
  }
}
