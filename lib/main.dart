import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spoonacular_demo/search_recipe_page.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'db/favourites.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  //  final dir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(DataModelAdapter());
  await Hive.openBox('hive_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spoonacular',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SearchRecipe(),
    );
  }
}
