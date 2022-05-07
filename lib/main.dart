
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:my_firebase_storage/landing.dart';
import 'package:my_firebase_storage/posts/posts_list.dart';

import 'package:my_firebase_storage/posts/user.dart';
import 'package:my_firebase_storage/services/add_services.dart';
import 'package:my_firebase_storage/services/auth_services.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      initialData: null,
      value: AuthServices().currentUser,
      child: MaterialApp(
        title: "Firebase & Database",
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(50, 65, 85, 1),
          textTheme: const TextTheme(subtitle1: TextStyle(color: Colors.white))
        ),
        home: const LandingPage(),
        routes: {
          PostsList.id: (context) => const PostsList(),
          AddServices.id: (context) => const AddServices(),
        },
      ),
    );
  }
}