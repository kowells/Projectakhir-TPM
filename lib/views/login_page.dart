import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafimedia/data/shared_pref.dart';
import 'package:grafimedia/views/book_search_view.dart';
import 'package:grafimedia/views/home.dart';
import 'package:grafimedia/menu.dart';
import 'package:grafimedia/views/registerpage.dart';
import 'package:http/http.dart' as http;
import 'package:grafimedia/menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var Username_controller = TextEditingController();
  var Password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    SharedPref().getLoginStatus().then((status) {
      if (status) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      title: '',
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              _createImage(),
              SizedBox(height: 32),
              _formSection(Username_controller, 'Username'),
              SizedBox(height: 16),
              _formSection(Password_controller, 'Password'),
              SizedBox(height: 24),
              _buttonSubmit(),
              SizedBox(height: 30),
              _buttonRegister()
            ],
          ),
        ),
      ),
    );
  }

  Widget _createImage() {
    return Container(
      child: Image.asset('assets/images/logo-TPM.png'),
    );
  }

  Widget _formSection(dynamic textController, String label) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }

  Widget _formSectionPass(dynamic textController, String label) {
    return TextField(
      controller: textController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        labelText: label,
      ),
    );
  }

  Widget _buttonSubmit() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: _loginProcess,
        child: Text("Login"),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: Text("Register"),
      ),
    );
  }

  void _loginProcess() {
    String username = Username_controller.text;
    String password = Password_controller.text;
    if (Username_controller.text != "" && Password_controller.text != "") {
      SharedPref().setLogin(username);
      _onLogin();
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("Tidak Boleh Ada Yang Kosong"),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _onLogin() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.21/login_books/users/login.php"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: {
          "uname": Username_controller.text,
          "pass": Password_controller.text
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String uname = data['uname'];
    String pass = data['pass'];
    print(Username_controller.text);

    if (value == 1) {
      setState(() {
        _checkLoginStatus();
      });
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.greenAccent,
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
}
