import 'package:cdc_form/model/alumni_model.dart';
import 'package:cdc_form/model/fakultas_model.dart';
import 'package:cdc_form/model/prodi_model.dart';
import 'package:cdc_form/services/alumni_service.dart';
import 'package:cdc_form/services/fakultas_service.dart';
import 'package:cdc_form/services/prodi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlumniForm extends StatefulWidget {
  const AlumniForm({super.key});

  @override
  State<AlumniForm> createState() => _AlumniFormState();
}

class _AlumniFormState extends State<AlumniForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tahunLulusController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  bool isLoading = false;
  List<FakultasModel> fakultasData = [];
  List<ProdiModel> prodiData = [];
  int? selectedFakultas;
  int? selectedProdi;
  String selectedStatus = "Sedang Bekerja";
  DateTime? tahun;
  bool isUpdateState = true;

  Future<void> fetchFakultas(int? id) async {
    try {
      fakultasData = [];
      final response = await FakultasService.fetchFakultas();
      fakultasData = response;
      selectedFakultas = id ?? fakultasData.first.id;
      setState(() {});
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchProdi(int? id) async {
    try {
      prodiData = [];
      final response = await ProdiService.fetchProdi();
      prodiData = response;
      selectedProdi = id ?? prodiData.first.id;
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
    final AlumniModel? data =
        ModalRoute.of(context)?.settings.arguments as AlumniModel?;

    if (isUpdateState && data != null) {
      nimController.value = TextEditingValue(text: data.nim);
      nameController.value = TextEditingValue(text: data.name);
      nomorController.value = TextEditingValue(text: data.nomor);
      emailController.value = TextEditingValue(text: data.email);
      alamatController.value = TextEditingValue(text: data.alamat);
      tahunLulusController.value = TextEditingValue(text: data.tahun);
      tahun = DateTime.parse(data.tahun);
      selectedFakultas = data.fakultas.id;
      selectedProdi = data.prodi.id;
      selectedStatus = data.status;
      isUpdateState = false;
      fetchFakultas(selectedFakultas);
      fetchProdi(selectedProdi);
    }

    if (isUpdateState && data == null) {
      isUpdateState = false;
      fetchFakultas(null);
      fetchProdi(null);
    }

    void _submitForm() async {
      setState(() {
        isLoading = true;
      });
      if (data != null) {
        print("update su");
        final AlumniModel dataModel = AlumniModel(
            id: -1,
            nim: nimController.text,
            name: nameController.text,
            alamat: alamatController.text,
            email: emailController.text,
            nomor: nomorController.text,
            fakultas: FakultasModel(id: selectedFakultas!, name: "name"),
            prodi: ProdiModel(
                id: selectedProdi!,
                fakultas: FakultasModel(id: 0, name: "name"),
                name: "name"),
            status: selectedStatus,
            tahun: tahun!.toString());
        await AlumniService.updateAlumni(data.id, dataModel);
      } else {
        final AlumniModel data = AlumniModel(
            id: -1,
            nim: nimController.text,
            name: nameController.text,
            alamat: alamatController.text,
            email: emailController.text,
            nomor: nomorController.text,
            fakultas: FakultasModel(id: selectedFakultas!, name: "name"),
            prodi: ProdiModel(
                id: selectedProdi!,
                fakultas: FakultasModel(id: 0, name: "name"),
                name: "name"),
            status: selectedStatus,
            tahun: tahun!.toString());
        await AlumniService.createAlumni(data);
      }
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data Alumni"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextField(
                          controller: nimController,
                          keyboardType: TextInputType.number,
                          decoration: customInputDecoration('Nim Alumni'),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: customInputDecoration('Nama Alumni'),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: alamatController,
                          keyboardType: TextInputType.text,
                          decoration: customInputDecoration('Alamat'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: tahunLulusController,
                          canRequestFocus: false,
                          keyboardType: TextInputType.datetime,
                          decoration: customInputDecoration('Tahun Lulus'),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1995),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              tahun = date;
                              tahunLulusController.text =
                                  "${date.day}/${date.month}/${date.year}";
                            }
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: customInputDecoration('email'),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: nomorController,
                          keyboardType: TextInputType.phone,
                          decoration: customInputDecoration('no telepon'),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        fakultasData.isNotEmpty
                            ? DropdownButtonFormField(
                                decoration: customInputDecoration("Fakultas"),
                                value: selectedFakultas,
                                items: fakultasData
                                    .map((fakultas) => DropdownMenuItem(
                                          child: Text(fakultas.name),
                                          value: fakultas.id,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  selectedFakultas = value;
                                  selectedProdi = prodiData
                                      .where(
                                        (prodi) =>
                                            prodi.fakultas.id ==
                                            selectedFakultas,
                                      )
                                      .first
                                      .id;
                                  setState(() {});
                                },
                              )
                            : Container(),
                        SizedBox(
                          height: 24,
                        ),
                        prodiData.isNotEmpty
                            ? DropdownButtonFormField(
                                decoration: customInputDecoration("Prodi"),
                                value: selectedProdi,
                                items: prodiData
                                    .where(
                                      (prodi) =>
                                          prodi.fakultas.id == selectedFakultas,
                                    )
                                    .map((prodi) => DropdownMenuItem(
                                          child: Text(prodi.name),
                                          value: prodi.id,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  selectedProdi = value;
                                  setState(() {});
                                },
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          decoration: customInputDecoration("Status"),
                          value: selectedStatus,
                          items: [
                            DropdownMenuItem(
                              child: Text("Sedang Bekerja"),
                              value: "Sedang Bekerja",
                            ),
                            DropdownMenuItem(
                              child: Text("Melanjutkan Studi"),
                              value: "Melanjutkan Studi",
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              selectedStatus = value;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
            ),
            SizedBox(
              height: 20,
            )
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
