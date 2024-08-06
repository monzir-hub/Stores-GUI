import 'package:sqlite_flutter_crud/database.dart';
import 'package:sqlite_flutter_crud/login.dart';
import 'package:sqlite_flutter_crud/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class signUp extends StatelessWidget {
  var name = TextEditingController();
  var Age = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool found = false;
  bool obText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan), // Changed to red
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return " name is small";
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              label: Text("name"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: Age,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Age very small";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Age"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                    TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!value.contains('@') || !value.contains('.com')) {
                          return "Invalid email format";
                        }
                        return null; // Return null if validation succeeds
                      },
                    keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: obText,
                          controller: password,
                          validator: (value) {
                            if (value!.length < 8) {
                              return " password very Small ";
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              label: Text("password"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.cyan)), // Changed to red
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit_App
                                      .get(context)
                                      .signUp_data
                                      .forEach((element) {
                                    if (email.text == element["email"] &&
                                        password.text == element["password"]) {
                                      found = true;
                                    }
                                  });
                                  if (found == false) {
                                    cubit_App.get(context).insert_data_SignUp(
                                        name: name.text,
                                        email: email.text,
                                        password: password.text,
                                        Age: Age.text);
                                    cubit_App.get(context).get_data_signUp();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Signup successful"),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("User already exists"),
                                    ));
                                  }
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                        Row(
                          children: [
                            Text("Already Have Email"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          login(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.cyan), // Changed to red
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}