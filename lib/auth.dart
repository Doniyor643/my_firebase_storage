import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_firebase_storage/posts/user.dart';
import 'package:my_firebase_storage/services/auth_services.dart';

class AuthorisationPage extends StatefulWidget {
  const AuthorisationPage({Key? key}) : super(key: key);

  @override
  State<AuthorisationPage> createState() => _AuthorisationPageState();
}

class _AuthorisationPageState extends State<AuthorisationPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String _email;
  late String _password;
  bool showLogin = true;

  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 100,),
          const Center(child: Text('Home Work',
            style: TextStyle(
                fontSize: 50,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold),
            )),
          const SizedBox(height: 50,),
          _inputText(
            icon: Icons.email_outlined,
            name: 'Email',
            controller: emailController,
            obscure: false
          ),
          _inputText(
              icon: Icons.key_rounded,
              name: 'Password',
              controller: passwordController,
              obscure: true
          ),
          const SizedBox(height: 30,),
          Container(
             height: 50,
             width: double.infinity,
             margin: const EdgeInsets.all(20),
             child: ElevatedButton(
               onPressed: (){
                 showLogin
                    ?
                 _doLogin()
                    :
                 _doRegister();
               },
                 child:showLogin
                     ?
                 const Text("Login")
                     :
                 const Text("Register")),
              ),
          TextButton(
             onPressed: (){
               setState(() {
                 showLogin = !showLogin;
               });

             },
             child: showLogin
                 ?
             const Text("Not registered yet? Register")
          :
             const Text("Already registered? Login!")
          )
        ],),
      ),
    );
  }

  Widget _inputText({icon, name, controller, obscure}){
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: Colors.cyanAccent,),
          labelText: name,
          labelStyle: const TextStyle(color: Colors.cyanAccent),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.cyan),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.cyanAccent, width: 3.0),
          ),
        ),
      ),
    );
  }

  _doLogin()async{
    _email = emailController.text.trim();
    _password = passwordController.text.trim();

    if(_email.isEmpty || _password.isEmpty) return;

    Users? users = await _authServices.signInEmailPassword(_email, _password);

    if(users == null){
      Fluttertoast.showToast(
          msg: "Can't SignIn you! Please chek your email and password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      emailController.clear();
      passwordController.clear();
    }


  }

  _doRegister()async{
    _email = emailController.text.trim();
    _password = passwordController.text.trim();

    if(_email.isEmpty || _password.isEmpty) return;

    Users? users = await _authServices.registerEmailPassword(_email, _password);

    if(users == null){
      Fluttertoast.showToast(
          msg: "Can't Register you! Please chek your email and password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      emailController.clear();
      passwordController.clear();
    }


  }

}
