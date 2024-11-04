import 'package:cdc_form/main.dart';
import 'package:cdc_form/model/alumni_model.dart';

class AlumniService {
  static Future<List<AlumniModel>> fetchAlumni() async {
    final List<dynamic> response = await client.callKw({
      'model': 'traceralumni.traceralumni',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [],
        // 'limit': 80,
      },
    });
    print(response);
    List<AlumniModel> result =
        response.map((alumni) => AlumniModel.fromMap(alumni)).toList();
    return result;
  }

  static Future<dynamic> deleteAlumni(int id) {
    return client.callKw({
      'model': 'traceralumni.traceralumni',
      'method': 'unlink',
      'args': [id],
      'kwargs': {},
    });
  }

  static Future<dynamic> createAlumni(AlumniModel data) {
    return client.callKw({
      'model': 'traceralumni.traceralumni',
      'method': 'create',
      'args': [data.toMap()],
      'kwargs': {},
    });
  }

  static Future<dynamic> updateAlumni(int id, AlumniModel data) async {
    print("update anjay");
    print(data.toMap());
    print(id);
    final response = await client.callKw({
      'model': 'traceralumni.traceralumni',
      'method': 'write',
      'args': [id, data.toMap()],
      'kwargs': {},
    });
    print(response);
    return response;
  }
}
