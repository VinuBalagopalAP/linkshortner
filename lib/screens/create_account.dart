import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkshortner/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _authUser = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  String _userName = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: TextField(
                onChanged: (value) => _userName = value,
                decoration: InputDecoration(
                  labelText: "Username",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: TextField(
                onChanged: (value) => _email = value,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Email",
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: TextField(
                onChanged: (value) => _password = value,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Password",
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Container(
                      child: Center(
                        child: Text("Sign Up"),
                      ),
                      width: double.infinity,
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      UserCredential? user =
                          await _authUser.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                      _database
                          .collection('/users')
                          .doc(user.user?.uid)
                          .set({'username': _userName});
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(uid: user.user?.uid)));
                      // print("working");
                      // Future.delayed(
                      //   Duration(seconds: 1),
                      //   () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => HomeScreen(),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
