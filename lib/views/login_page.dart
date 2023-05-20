import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafimedia/data/shared_pref.dart';
import 'package:grafimedia/views/book_search_view.dart';
import 'package:grafimedia/views/home.dart';
import 'package:grafimedia/menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

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
                builder: (context) => MyHomePage(
                      title: 'Anda Sudah Login',
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
              _formSection(username_controller, 'Username'),
              SizedBox(height: 16),
              _formSection(password_controller, 'Password'),
              SizedBox(height: 24),
              _buttonSubmit(),
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

  Widget _formSection(dynamic text_controller, String label) {
    return TextFormField(
      controller: text_controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }

  Widget _formSectionPass(dynamic text_controller, String label) {
    return TextField(
      controller: text_controller,
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

  void _loginProcess() {
    String username = username_controller.text;
    String password = password_controller.text;
    if (username.isNotEmpty || password.isNotEmpty) {
      SharedPref().setLogin(username);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(
                    title: ' ',
                  )));
    }
  }
}
