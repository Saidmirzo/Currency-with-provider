
import 'package:currency/utilits/provider.dart';
import 'package:currency/utilits/routes.dart';
import 'package:flutter/material.dart';
import './utilits/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'package:currency/utilits/provider.dart';

void main() async{
  await Hive.initFlutter();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<CurrProvider>(
      create: (_) => CurrProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => Routes.generateRoute(settings),
      ),
    );
  }
}
