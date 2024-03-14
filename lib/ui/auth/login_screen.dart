import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khela_hobe/ui/auth/login_with_phone_number.dart';
import 'package:khela_hobe/ui/auth/signup_screen.dart';
import 'package:khela_hobe/ui/posts/post_screen.dart';
import 'package:khela_hobe/utils/utils.dart';
import 'package:khela_hobe/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessege(value.user!.email.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessege((error.toString()));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text("Login App",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          // padding: const EdgeInsets.symmetric(horizontal: .20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            helperText: 'enter email e.g mylaptop@gmail.com',
                            prefixIcon: Icon(Icons.alternate_email)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          helperText: 'enter password e.g 1620@xyz',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                tittle: "Login",
                onTap: () {
                  if (_fromKey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text("Sign up"),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text("Do you login your phone number?"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
