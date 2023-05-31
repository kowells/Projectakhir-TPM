import 'package:flutter/material.dart';
import '../data/shared_pref.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              SharedPref().setLogout();
              final snackbar = SnackBar(
                content: Text('Berhasil Logout'),
                backgroundColor: Colors.redAccent,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Page',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/ridwan.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Ridwan Darmawan',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '123200090',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Profiledetail()),
            //     );
            //   },
            //   child: Text('Detail'),
            // ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/hanif.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              'Muhammad Ikhwan Hanif',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '123200096',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// class Profiledetail extends StatelessWidget {
//   const Profiledetail({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Profile Page',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             SizedBox(height: 20),
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('images/ridwan.jpg'),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 103, 58, 183),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Text(
//                 'Ridwan Darmawan',
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 103, 58, 183),
//                   borderRadius: BorderRadius.circular(10)),
//               width: 320,
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     child: Text(
//                       'Sleman, 04 November 2***',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     child: Text(
//                       '123200090',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     child: Text(
//                       'Teknologi Pemrograman Mobile IF - E',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 103, 58, 183),
//                   borderRadius: BorderRadius.circular(10)),
//               width: 320,
//               child: Column(
//                 children: [
//                   Text(
//                     'Kesan Pesan',
//                     style: TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Asyik sekali belajar tpm mantab',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//}
