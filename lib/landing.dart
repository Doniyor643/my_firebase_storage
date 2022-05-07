
import 'package:flutter/material.dart';
import 'package:my_firebase_storage/auth.dart';
import 'package:my_firebase_storage/posts/posts_list.dart';
import 'package:my_firebase_storage/posts/user.dart';
import 'package:provider/provider.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Users? users = Provider.of<Users?>(context);
    bool isLoggedIn = users != null;
    return isLoggedIn ? const PostsList() : const AuthorisationPage();
  }
}

//isLoggedIn ? const HomePage() : const AuthorisationPage();
