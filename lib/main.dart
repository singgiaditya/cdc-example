import 'package:cdc_form/view/alumni/alumni_form.dart';
import 'package:cdc_form/view/fakultas/form_fakultas.dart';
import 'package:cdc_form/view/home.dart';
import 'package:cdc_form/view/prodi/form_prodi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

final client = OdooClient('http://172.22.96.1:10017/');
void main() async {
  try {
    await client.authenticate("test", "admin", "admin");
    final res = await client.callRPC('/web/session/modules', 'call', {});
    print('Installed modules: \n' + res.toString());
  } on OdooException catch (e) {
    print(e);
    client.close();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracer Alumni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/fakultas-form': (context) => FormFakultas(),
        '/prodi-form': (context) => FormProdi(),
        '/alumni-form': (context) => AlumniForm(),
      },
    );
  }
}
