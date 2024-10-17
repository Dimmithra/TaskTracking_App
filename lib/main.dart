import 'package:flutter/material.dart';
import 'package:tasktrack/pages/splash_screen/splash_screen.dart';
import 'package:tasktrack/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:tasktrack/providers/task_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade900,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
