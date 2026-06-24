import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/p_model.dart';

void main() async {
  // 1. Establish bridge connections to the phone OS native background engine
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Map out directory routes for sandboxed data file systems
  await Hive.initFlutter();

  // 3. Register the binary translator blueprint for Product Model schemas
  Hive.registerAdapter(ProductModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text('Engine Pre-loaded & Connected Safely!')),
      ),
    );
  }
}