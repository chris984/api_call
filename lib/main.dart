import 'dart:async';
import 'dart:convert';
import 'package:api_call/models/photos.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Photos> getPhotos() async {
  final response =
      await http.get(Uri.parse("http://192.168.1.4:8000/api/user/5"));

  if (response.statusCode == 200) {
    return Photos.fromJson(jsonDecode(response.body)[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Photos> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder<Photos>(
              future: futurePhotos,
              builder: (context, photo) {
                if (photo.hasData) {
                  return Column(
                    children: [
                      Text(
                        photo.data!.firstName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24.0),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        photo.data!.middleName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24.0),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        photo.data!.lastName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24.0),
                      ),
                      // Image.network(
                      //   '${photo.data!.thumbnailUrl}',
                      //   width: 300,
                      //   height: 300,
                      // ),
                    ],
                  );
                } else if (photo.hasError) {
                  return Text('${photo.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
