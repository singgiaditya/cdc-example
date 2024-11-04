import 'package:cdc_form/model/fakultas_model.dart';
import 'package:cdc_form/main.dart';

class FakultasService {
  static Future<List<FakultasModel>> fetchFakultas() async {
    final List<dynamic> response = await client.callKw({
      'model': 'traceralumni.fakultas',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ["id", "name"],
        // 'limit': 80,
      },
    });
    List<FakultasModel> result =
        response.map((fakultas) => FakultasModel.fromMap(fakultas)).toList();
    return result;
  }

  static Future<dynamic> deleteFakultas(int id) {
    return client.callKw({
      'model': 'traceralumni.fakultas',
      'method': 'unlink',
      'args': [id],
      'kwargs': {},
    });
  }

  static Future<dynamic> createFakultas(String name) {
    return client.callKw({
      'model': 'traceralumni.fakultas',
      'method': 'create',
      'args': [
        {
          'name': name,
        },
      ],
      'kwargs': {},
    });
  }

  static Future<dynamic> updateFakultas(int id, String name) {
    return client.callKw({
      'model': 'traceralumni.fakultas',
      'method': 'write',
      'args': [
        id,
        {
          'name': name,
        },
      ],
      'kwargs': {},
    });
  }
}
