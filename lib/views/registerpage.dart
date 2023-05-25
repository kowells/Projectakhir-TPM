import 'package:flutter/material.dart';
import 'package:grafimedia/views/login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  var Username = TextEditingController();
  var Password = TextEditingController();
  var CPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: Username,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Masukkan Username",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.people_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username Wajib Diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: Password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: "Masukkan Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Wajib Diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: CPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: "Masukkan Confirm Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi Password Wajib Diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.deepPurple),
                  child: MaterialButton(
                    onPressed: () {
                      print(Username.text);
                      if (Username.text != "" &&
                          Password.text != "" &&
                          CPassword.text != "") {
                        if (Password.text != CPassword.text) {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                                "Password dan Konfirmasi Password harus sama !"),
                            backgroundColor: Colors.redAccent,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          _onRegister();
                        }
                      } else {
                        SnackBar snackBar = SnackBar(
                          content: Text("Tidak Boleh Ada Yang Kosong"),
                          backgroundColor: Colors.redAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text(
                      "DAFTAR",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // const Icon(Icons.fingerprint , size: 60, color: Colors.teal,),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 30,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }),
                      );
                    },
                    child: Text(
                      "Sudah punya akun? Login",
                      style: TextStyle(color: Colors.black54),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegister() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.6/login_books/users/register.php"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: {
          "uname": Username.text,
          "pass": Password.text
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    print(Username.text);
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else if (value == 0) {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // void _check() {
  //   final form = _formKey.currentState!;
  //   if (form.validate()) {
  //     form.save();
  //     _onRegister();
  //   }
  // }
}
