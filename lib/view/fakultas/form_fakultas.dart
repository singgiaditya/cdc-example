import 'package:cdc_form/services/fakultas_service.dart';
import 'package:cdc_form/model/fakultas_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormFakultas extends StatefulWidget {
  const FormFakultas({super.key});

  @override
  State<FormFakultas> createState() => _FormFakultasState();
}

class _FormFakultasState extends State<FormFakultas> {
  TextEditingController tahunLulusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FakultasModel? data =
        ModalRoute.of(context)?.settings.arguments as FakultasModel?;

    if (data != null) {
      nameController.value = TextEditingValue(text: data.name);
    }

    void _submitForm() async {
      setState(() {
        isLoading = true;
      });
      if (data != null) {
        await FakultasService.updateFakultas(data.id, nameController.text);
      } else {
        await FakultasService.createFakultas(nameController.text);
      }
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Fakultas"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 34,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                        label: Text("Nama Fakultas"),
                        floatingLabelStyle: TextStyle(
                          color: Colors.green,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Spasi antara tombol Reset dan Save
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              _submitForm();
                            },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Save',
                            ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
