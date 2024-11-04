import 'package:cdc_form/model/fakultas_model.dart';
import 'package:cdc_form/model/prodi_model.dart';
import 'package:cdc_form/services/fakultas_service.dart';
import 'package:cdc_form/services/prodi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormProdi extends StatefulWidget {
  const FormProdi({super.key});

  @override
  State<FormProdi> createState() => _FormProdiState();
}

class _FormProdiState extends State<FormProdi> with TickerProviderStateMixin {
  TextEditingController tahunLulusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  List<FakultasModel> fakultasData = [];
  int? selectedFakultas;
  bool isUpdateState = true;

  Future<void> fetchFakultas(int? id) async {
    try {
      fakultasData = [];
      final response = await FakultasService.fetchFakultas();
      fakultasData = response;
      selectedFakultas = id != null ? id : fakultasData.first.id;
      setState(() {});
    } catch (e) {
      throw e;
    }
  }

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
    final ProdiModel? data =
        ModalRoute.of(context)?.settings.arguments as ProdiModel?;

    if (isUpdateState && data != null) {
      nameController.value = TextEditingValue(text: data.name);
      selectedFakultas = data.fakultas.id;
      isUpdateState = false;
      fetchFakultas(selectedFakultas);
    }

    if (isUpdateState && data == null) {
      isUpdateState = false;
      fetchFakultas(null);
    }

    void _submitForm() async {
      setState(() {
        isLoading = true;
      });
      if (data != null) {
        await ProdiService.updateProdi(
            data.id, nameController.text, selectedFakultas!);
      } else {
        await ProdiService.createProdi(nameController.text, selectedFakultas!);
      }
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data Prodi"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        fakultasData.isNotEmpty
                            ? DropdownButtonFormField(
                                decoration: customInputDecoration("Fakultas"),
                                focusColor: Colors.green[600],
                                dropdownColor: Colors.green[50],
                                value: selectedFakultas,
                                items: fakultasData
                                    .map(
                                      (fakultas) => DropdownMenuItem(
                                        child: Text(fakultas.name),
                                        value: fakultas.id,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  selectedFakultas = value;
                                },
                              )
                            : Container(),
                        SizedBox(height: 24),
                        TextField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                            label: Text("Nama Prodi"),
                            floatingLabelStyle: TextStyle(
                              color: Colors.green,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Save',
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      border: OutlineInputBorder(),
      alignLabelWithHint: true,
      hintText: hintText,
      floatingLabelStyle: TextStyle(
        color: Colors.green,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
    );
  }
}
