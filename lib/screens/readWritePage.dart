import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class ReadWriteFilePage extends StatefulWidget {
  @override
  ReadWriteFilePageState createState() => ReadWriteFilePageState();
}

class ReadWriteFilePageState extends State<ReadWriteFilePage> {

  final TextEditingController textController = TextEditingController();

  static const String kLocalFileName = 'demo_localfile.txt';

  String localFileContent = '';
  String localFilePath = kLocalFileName;

  @override
  void initState() {
    super.initState();
    readTextFromLocalFile();
    getFile.then((file) => setState(() => localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Чтение/запись'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Text('Записать в локальный файл:', style: TextStyle(fontSize: 20)),
          TextField(
              focusNode: textFieldFocusNode,
              controller: textController,
              maxLines: null,
              style: TextStyle(fontSize: 20)
          ),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                child: Text('Загрузить', style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  readTextFromLocalFile();
                  textController.text = localFileContent;
                  FocusScope.of(context).requestFocus(textFieldFocusNode);
                  log('String successfuly laoded from local file');
                },
              ),
              MaterialButton(
                child: Text('Сохранить', style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  await this.writeTextToLocalFile(textController.text);
                  textController.clear();
                  await this.readTextFromLocalFile();
                  log('String successfuly written to local file');
                },
              ),
            ],
          ),
          Divider(height: 20.0),
          Text('Путь файла:', style: Theme.of(context).textTheme.headline6),
          Text(this.localFilePath, style: Theme.of(context).textTheme.subtitle1),
          Divider(height: 20.0),
          Text('Содержимоея файла:', style: Theme.of(context).textTheme.headline6),
          Text(this.localFileContent, style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }

  Future<String> get getPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get getFile async {
    final path = await getPath;
    return File('$path/$kLocalFileName');
  }

  Future<File> writeTextToLocalFile(String text) async {
    final file = await getFile;
    return file.writeAsString(text);
  }

  Future readTextFromLocalFile() async {
    String content;
    try {
      final file = await getFile;
      content = await file.readAsString();
    } catch(e) {
      content = 'Error loading local file: $e';
    }
    setState(() {
      localFileContent = content;
      print(localFileContent);
    });
  }
}