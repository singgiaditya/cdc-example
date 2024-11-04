import 'package:cdc_form/services/alumni_service.dart';
import 'package:cdc_form/services/fakultas_service.dart';
import 'package:cdc_form/services/prodi_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Builder(builder: (context) {
            return _buildDrawer(context);
          }),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                  ));
            }),
            title: Text(
              "Tracer Alumni",
            ),
            bottom: TabBar(tabs: [
              Tab(
                text: "Fakutas",
              ),
              Tab(
                text: "Prodi",
              ),
              Tab(
                text: "Alumni",
              ),
            ]),
          ),
          body: TabBarView(
              children: [_buildFakultas(), _buildProdi(), _buildAlumni()]),
        ));
  }

  Widget _buildFakultas() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            "Data Fakultas",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 14,
          ),
          FutureBuilder(
            future: FakultasService.fetchFakultas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${snapshot.data![index].name}"),
                    trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      onTap: () async {
                                        await Navigator.pushNamed(
                                            context, "/fakultas-form",
                                            arguments: snapshot.data![index]);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text("Edit"),
                                    ),
                                    ListTile(
                                      onTap: () async {
                                        await FakultasService.deleteFakultas(
                                            snapshot.data![index].id);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text("Delete"),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.more_horiz)),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildProdi() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            "Data Prodi",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 14,
          ),
          FutureBuilder(
            future: ProdiService.fetchProdi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${snapshot.data![index].name}"),
                    subtitle: Text("${snapshot.data![index].fakultas.name}"),
                    trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      onTap: () async {
                                        await Navigator.pushNamed(
                                            context, "/prodi-form",
                                            arguments: snapshot.data![index]);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text("Edit"),
                                    ),
                                    ListTile(
                                      onTap: () async {
                                        await ProdiService.deleteProdi(
                                            snapshot.data![index].id);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text("Delete"),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.more_horiz)),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildAlumni() {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              "Data Alumni",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 14,
            ),
            FutureBuilder(
              future: AlumniService.fetchAlumni(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(),
                      title: Text("${snapshot.data![index].name}"),
                      subtitle: Text("${snapshot.data![index].nim}"),
                      trailing: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        onTap: () async {
                                          await Navigator.pushNamed(
                                              context, "/alumni-form",
                                              arguments: snapshot.data![index]);
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text("Edit"),
                                      ),
                                      ListTile(
                                        onTap: () async {
                                          await AlumniService.deleteAlumni(
                                              snapshot.data![index].id);
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text("Delete"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.more_horiz)),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    ));
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () async {
                  Scaffold.of(context).closeDrawer();
                  await Navigator.pushNamed(context, "/alumni-form");
                  setState(() {});
                },
                child: Text(
                  "Tambah Data Alumni",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
            Divider(),
            TextButton(
                onPressed: () async {
                  Scaffold.of(context).closeDrawer();
                  await Navigator.pushNamed(context, "/fakultas-form");
                  setState(() {});
                },
                child: Text(
                  "Tambah Data Fakultas",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
            Divider(),
            TextButton(
                onPressed: () async {
                  Scaffold.of(context).closeDrawer();
                  await Navigator.pushNamed(context, "/prodi-form");
                  setState(() {});
                },
                child: Text(
                  "Tambah Data Prodi",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
            Divider()
          ],
        ),
      ),
    );
  }
}
