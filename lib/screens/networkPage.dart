import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practic/models/offices.dart';

class NetworkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NetworkPageState();
  }
}

class NetworkPageState extends State<NetworkPage> {

  late Future<OfficesList> officesList;
  //String app;

  @override
  void initState() {

    officesList = getOfficesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Работа с сетью"),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.offices?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${snapshot.data?.offices?[index].name}'),
                          subtitle:
                          Text('${snapshot.data?.offices?[index].address}'),
                          leading: Image.network(
                              'https://mirplaneta.ru/images/5/920.jpg'),
                          isThreeLine: true,
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Text('Ошибка...');
              }
              return const Center(child: CircularProgressIndicator());

        },
      ),
    );
  }
}


Future<http.Response> fetchData() async {
  Uri url = Uri.parse('https://about.google/static/data/locations.json');
  var response = await http.get(url);
  return response;
}

Future<OfficesList> getOfficesList() async {
  Uri url = Uri.parse('https://about.google/static/data/locations.json');
  var response = await http.get(url);

  if(response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Ошибка: ${response.reasonPhrase}');
  }
}

void loadData() {

  fetchData().then((response) {
    if(response.statusCode == 200) {
      print(response.body.length);
    } else {
      print(response.statusCode);
    }
  }).catchError((error) {
    debugPrint(error.toString());
  });

}

