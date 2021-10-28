import 'package:braking_bad_todo/ui/screens/home/homePage.dart';
import 'package:braking_bad_todo/ui/smsVerfiy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(textTheme: GoogleFonts.comfortaaTextTheme()),
      home: InitializerWidgetState(),
    );
  }
}

class InitializerWidgetState extends StatefulWidget {
  const InitializerWidgetState({Key? key}) : super(key: key);

  @override
  _InitializerWidgetStateState createState() => _InitializerWidgetStateState();
}

class _InitializerWidgetStateState extends State<InitializerWidgetState> {
  FirebaseAuth? _auth;
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.brown.shade300,
              ),
            ),
          )
        : _user == null
            ? SmsVerifyPage()
            : const HomePage();
  }
}
