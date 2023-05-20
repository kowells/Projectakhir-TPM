import 'package:flutter/material.dart';
import 'package:grafimedia/views/checkout_form_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grafimedia/boxes.dart';
import 'package:grafimedia/models/book_lib.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  _LibraryViewState createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  late int totalBook;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Lib>(HiveBoxes.lib).listenable(),
        builder: (context, Box<Lib> box, _) {
          totalBook = box.values.length;
          if (box.values.isEmpty) {
            return Center(
              child: Text('Keranjang kosong'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Lib? res = box.getAt(index);
              return Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  res!.delete();
                },
                child: ListTile(
                  leading: Image(
                    image: NetworkImage(res!.imageLink),
                  ),
                  title: Text(res.title),
                  subtitle: Text(res.authors),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Borrow',
        child: Icon(Icons.book),
        onPressed: () => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckoutForm(
                        totalBook: totalBook,
                      ))),
        },
      ),
    );
  }
}
