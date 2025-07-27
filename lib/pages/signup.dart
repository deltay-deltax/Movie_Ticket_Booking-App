import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/bottomnav.dart';
import 'package:movie_booking_app/pages/home.dart';
import 'package:movie_booking_app/pages/login.dart';
import 'package:movie_booking_app/service/database.dart';
import 'package:random_string/random_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  registration() async {
    try {
      if (password.isNotEmpty &&
          namecontroller.text.isNotEmpty &&
          mailcontroller.text.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String uid = userCredential.user!.uid;
        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Id": uid,
        };
        await DatabaseMethods().addUserDetails(userInfoMap, uid); // ✅ use UID

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Registered Successfully !!',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password is too weak'),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email already in use'),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      }
    } catch (e) {
      debugPrint("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 40),
            // margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("Assets/images/signin.png"),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  // padding: EdgeInsets.all(8.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign up",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 38.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 60),
                        Text(
                          "Name",
                          style: TextStyle(
                            color: const Color.fromARGB(171, 255, 255, 255),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                  return null;
                                },
                                controller: namecontroller,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  label: Text('Enter Name'),
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Email",
                          style: TextStyle(
                            color: const Color.fromARGB(171, 255, 255, 255),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  // ✅ Regex for validating email format
                                  // ✅ Only allow Gmail addresses
                                  final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  );
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Incorrect email type';
                                  }

                                  return null;
                                },
                                controller: mailcontroller,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  label: Text('Enter Email'),
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Password",
                          style: TextStyle(
                            color: const Color.fromARGB(171, 255, 255, 255),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter a Password';
                                  }
                                  return null;
                                },
                                controller: passwordcontroller,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  label: Text('Enter a Password'),
                                  suffixIcon: Icon(
                                    Icons.password_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 130,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6b63ff),
                                ),
                                onPressed: () {
                                  try {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = mailcontroller.text;
                                        name = namecontroller.text;
                                        password = passwordcontroller.text;
                                      });
                                      registration();
                                    }
                                  } catch (e, stacktrace) {
                                    debugPrint("🔥 Crash: $e");
                                    debugPrint("📌 Stacktrace: $stacktrace");
                                  }
                                },

                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                color: Color.fromARGB(206, 255, 255, 255),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'LogIn ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
