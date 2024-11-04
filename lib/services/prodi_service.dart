import 'package:cdc_form/main.dart';
import 'package:cdc_form/model/prodi_model.dart';

class ProdiService {
  static Future<List<ProdiModel>> fetchProdi() async {
    final List<dynamic> response = await client.callKw({
      'model': 'traceralumni.prodi',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [],
        // 'limit': 80,
      },
    });
    List<ProdiModel> result = response.map((prodi) {
      return ProdiModel.fromMap(prodi);
    }).toList();
    return result;
  }

  static Future<dynamic> deleteProdi(int id) {
    return client.callKw({
      'model': 'traceralumni.prodi',
      'method': 'unlink',
      'args': [id],
      'kwargs': {},
    });
  }

  static Future<dynamic> createProdi(String name, int fakultasId) {
    return client.callKw({
      'model': 'traceralumni.prodi',
      'method': 'create',
      'args': [
        {'name': name, 'fakultas_id': fakultasId},
      ],
      'kwargs': {},
    });
  }

  static Future<dynamic> updateProdi(int id, String name, int fakultasId) {
    return client.callKw({
      'model': 'traceralumni.prodi',
      'method': 'write',
      'args': [
        id,
        {'name': name, 'fakultas_id': fakultasId},
      ],
      'kwargs': {},
    });
  }
}
