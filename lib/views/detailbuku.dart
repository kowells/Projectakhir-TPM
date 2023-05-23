import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String bookId;

  DetailPage({required this.bookId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Map<String, dynamic>> bookDetails;

  @override
  void initState() {
    super.initState();
    bookDetails = fetchBookDetails();
  }

  Future<Map<String, dynamic>> fetchBookDetails() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes/${widget.bookId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load book details');
    }
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: bookDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final book = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (book['volumeInfo']['imageLinks']?['thumbnail'] != null)
                      Image.network(
                        book['volumeInfo']['imageLinks']['thumbnail'],
                        height: 200,
                      ),
                    SizedBox(height: 16),
                    Text(
                      book['volumeInfo']?['title'] ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Authors: ${book['volumeInfo']?['authors']?.join(', ') ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Description: ' +
                          removeAllHtmlTags(
                              book['volumeInfo']?['description'] ?? ''),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Publisher: ${book['volumeInfo']['publisher']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Published Date: ${book['volumeInfo']['publishedDate']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load book details'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
