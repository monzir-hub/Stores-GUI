import 'package:sqlite_flutter_crud/database.dart';
import 'package:sqlite_flutter_crud/home_screen.dart';
import 'package:sqlite_flutter_crud/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_flutter_crud/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scafoldKey = GlobalKey<ScaffoldState>();
  bool obstext = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scafoldKey,
            body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  label: Text("Email"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25)))),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              obscureText: obstext,
                              controller: password,
                              validator: (value) {
                                if (value!.length < 8) {
                                  return " password very small ";
                                }
                                return null; // Added to ensure validator returns null when valid
                              },
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        obstext = !obstext;
                                        // To update the state when changing obText
                                        (context as Element).markNeedsBuild();
                                      },
                                      icon: const Icon(Icons.remove_red_eye)),
                                  label: const Text("Password"),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25)))),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                                width: 200,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        // Bypass the login validation and proceed directly
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => const home_screen(),
                                          ),
                                        );
                                        Fluttertoast.showToast(
                                            msg: "Login Successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.cyan,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                    child: const Text("Login", style: TextStyle(color: Colors.black)))),
                            Row(
                              children: [
                                const Text("Don't have an email?"),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) => signUp(),
                                        ),
                                      );
                                    },
                                    child: const Text("Sign Up", style: TextStyle(color: Colors.cyan))),
                              ],
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        });
  }
}
