import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khela_hobe/ui/auth/login_screen.dart';
import 'package:khela_hobe/utils/utils.dart';
import 'package:khela_hobe/widgets/round_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignupScreen> {
  bool loading = false;
  final _fromKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() async {
    setState(() {
      loading:
      false;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString());
      if (userCredential.credential != null) {}
    } on FirebaseException catch (e) {
      Utils().toastMessege(e.message.toString());
      setState(() {
        loading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign up")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        // padding const EdgeInsets.symmetric(horizontal: .20),

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
                tittle: "Sign up",
                loading: loading,
                onTap: () {
                  if (_fromKey.currentState!.validate()) {
                    signUp();
                  }
                }),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already  have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Login"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
