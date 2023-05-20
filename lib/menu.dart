import 'package:flutter/material.dart';
import 'package:grafimedia/views/home.dart';
import 'package:grafimedia/views/konversi.dart';
import 'package:grafimedia/views/login_page.dart';
import 'package:grafimedia/views/profile.dart';
import 'package:grafimedia/views/waktu.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Utama'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              width: 200,
              child: ElevatedButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ))
                      },
                  child: Text("Profile")),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              width: 200,
              child: ElevatedButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                title: "",
                              ),
                            ))
                      },
                  child: Text("Daftar Buku")),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              width: 200,
              child: ElevatedButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KonversiPage(),
                            ))
                      },
                  child: Text("Konversi Mata Uang")),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              width: 200,
              child: ElevatedButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Waktu(),
                            ))
                      },
                  child: Text("Waktu")),
            ),
          ],
        ),
      ),
    );
  }
}
