import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafimedia/views/detailbuku.dart';
import 'package:hive/hive.dart';
import 'package:grafimedia/controller/book_data_store.dart';
import 'package:grafimedia/models/books.dart';
import 'package:grafimedia/models/book_lib.dart';

import '../boxes.dart';
import 'library_view.dart';

class BooksCatalog extends StatefulWidget {
  final String text;

  const BooksCatalog({Key? key, required this.text}) : super(key: key);

  @override
  _BooksCatalogState createState() => _BooksCatalogState();
}

class _BooksCatalogState extends State<BooksCatalog> {
  late String title;
  late String authors;
  late String imageLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books Catalog"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.local_library,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LibraryView(),
                  ));
            },
          ),
        ],
      ),
      body: Container(
        // FutureBuilder() membentuk hasil Future dari request API
        child: FutureBuilder(
          future: BookDataSource.instance.loadBooks(widget.text),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError || widget.text.isEmpty) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Book book = Book.fromJson(snapshot.data);
              return _buildSuccessSection(book);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  // Jika API sedang dipanggil
  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSection() {
    if (widget.text.isEmpty) {
      return const Text("Search bar cannot be Empty");
    } else {
      return const Text("Error");
    }
  }

  // Jika data ada
  Widget _buildSuccessSection(Book data) {
    return ListView.builder(
      itemCount: data.items?.length,
      itemBuilder: (BuildContext context, int index) {
        final book = data.items![index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(bookId: book.id!),
              ),
            );
          },
          leading: Image(
            image: NetworkImage(book.volumeInfo!.imageLinks!.smallThumbnail!),
          ),
          title: Text("${book.volumeInfo!.title}"),
          subtitle: Text(
            "${book.volumeInfo!.authors!.join(", ")}",
            style: TextStyle(fontSize: 11.0),
          ),
          isThreeLine: true,
          trailing: ElevatedButton.icon(
            onPressed: () {
              imageLink = "${book.volumeInfo!.imageLinks!.smallThumbnail}";
              title = "${book.volumeInfo!.title}";
              authors = "${book.volumeInfo!.authors!.join("")}";
              _onFormSubmit();
            },
            icon: const Icon(
              Icons.add,
              size: 16.0,
            ),
            label: Text('Add to Cart'),
          ),
        );
      },
    );
  }

  void _onFormSubmit() {
    Box<Lib> libBox = Hive.box<Lib>(HiveBoxes.lib);
    libBox.add(Lib(imageLink: imageLink, title: title, authors: authors));
    print(libBox);
  }
}
