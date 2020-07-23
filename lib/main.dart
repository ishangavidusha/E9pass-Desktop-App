import 'package:e9pass_desktop/repository/fileApiRepository.dart';
import 'package:e9pass_desktop/splashScreen.dart';
import 'package:e9pass_desktop/state/fileReadWriteStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E9pass Certificate Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          Provider<FileReadWriteStore>(create: (context) => FileReadWriteStore(FileApiRepository()),),
        ],
        child: SplashScreen()),
    );
  }
}
