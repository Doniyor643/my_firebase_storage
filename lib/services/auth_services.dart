import 'package:firebase_auth/firebase_auth.dart';

import '../posts/user.dart';

class AuthServices{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Users?> signInEmailPassword(String email, String password)async{
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return Users.fromFirebase(user!);
    }catch(e){
      print("Error type => $e");
      return null;
    }
  }

  Future<Users?> registerEmailPassword(String email, String password)async{
    try{
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return Users.fromFirebase(user!);
    }catch(e){
      print("Error type => $e");
      return null;
    }
  }

  Future logOut()async{
    await _firebaseAuth.signOut();
  }

  Stream<Users?> get currentUser{
    return _firebaseAuth.authStateChanges()
        .map((User? user) => user != null ? Users.fromFirebase(user) : null);
  }
}