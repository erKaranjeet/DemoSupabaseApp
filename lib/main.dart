import 'package:demo_supabase_app/auth/auth_gateway.dart';
import 'package:demo_supabase_app/home_screen.dart';
import 'package:demo_supabase_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://sxruhxohqvgnctncrfjh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4cnVoeG9ocXZnbmN0bmNyZmpoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MTY0MzksImV4cCI6MjA1MTk5MjQzOX0.dOO36oAXUirGMRtbXYtDVoeKTcSd7DQIiCe8ddMSKb0',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthGateway(),
    );
  }
}