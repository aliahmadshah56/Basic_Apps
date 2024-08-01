import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'I/O',
  home: Home(),
));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _enterDataField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read/Write"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.all(13),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TextField(
              controller: _enterDataField,
              decoration: InputDecoration(labelText: 'Write Something'),
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                writeCounter(_enterDataField.text);
              },
              child: Icon(Icons.save),
            ),
            SizedBox(height: 20),
            FutureBuilder(
                future: readCounter(),
                builder: (BuildContext context, AsyncSnapshot<String> data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (data.hasError) {
                    return Text('Error: ${data.error}');
                  } else {
                    return Text(
                      data.data.toString(),
                      style: TextStyle(color: Colors.black26, fontSize: 16),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(String message) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$message');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;
      // Read the file
      String data = await file.readAsString();
      return data;
    } catch (e) {
      // If encountering an error, return a default String
      return 'Nothing saved yet!';
    }
  }
}
