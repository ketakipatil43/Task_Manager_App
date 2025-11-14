import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(
    'G5OkNOMHiGsT5EajhQPO1jGIL6Ncp4CCrigW8et4',
    'https://parseapi.back4app.com',
    clientKey: 'WAggVMliNScU2YlqIjOxm77GyoWRojXyEctWIO8O',
    autoSendSessionId: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => LoginScreen(),
      },
    );
  }
}
