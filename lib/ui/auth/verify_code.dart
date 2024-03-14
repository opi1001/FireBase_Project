import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khela_hobe/utils/utils.dart';
import 'package:khela_hobe/widgets/round_button.dart';

class VerifyCodeSCreen extends StatefulWidget {
  final verificationid;
  const VerifyCodeSCreen({super.key, required this.verificationid});

  @override
  State<VerifyCodeSCreen> createState() => _VerifyCodeSCreenState();
}

class _VerifyCodeSCreenState extends State<VerifyCodeSCreen> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: " 6 digit code",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          RoundButton(tittle: "Verify", loading: loading, onTap: () {}),
        ],
      ),
    );
  }
}
