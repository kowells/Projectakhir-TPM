import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Waktu extends StatefulWidget {
  @override
  _WaktuState createState() => _WaktuState();
}

class _WaktuState extends State<Waktu> {
  DateTime _selectedDate = DateTime.now();
  String _zone = 'WIB';
  String _timeString = '';

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 10), (Timer t) => _getTime());
  }

  void _getTime() {
    final DateTime now =
        DateTime.now().toUtc().add(Duration(hours: _getHourOffset()));
    setState(() {
      _timeString = '${DateFormat('HH:mm:ss').format(now)} $_zone';
    });
  }

  int _getHourOffset() {
    if (_zone == "WIB") {
      return 7;
    } else if (_zone == "WITA") {
      return 8;
    } else if (_zone == "WIT") {
      return 9;
    } else if (_zone == "UTC") {
      return 1;
    } else {
      return 0;
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waktu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateFormat.yMMMMEEEEd().format(_selectedDate),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () => _selectDate(context),
            //   child: Text('Tanggalan'),
            // ),
            SizedBox(height: 16),
            Text(
              _timeString,
              style: TextStyle(fontSize: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text('WIB'),
                  onPressed: () {
                    setState(() {
                      _zone = 'WIB';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // warna latar belakang button
                    onPrimary: Colors.white, // warna teks pada button
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  child: Text('WITA'),
                  onPressed: () {
                    setState(() {
                      _zone = 'WITA';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // warna latar belakang button
                    onPrimary: Colors.white, // warna teks pada button
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  child: Text('WIT'),
                  onPressed: () {
                    setState(() {
                      _zone = 'WIT';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // warna latar belakang button
                    onPrimary: Colors.white, // warna teks pada button
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  child: Text('UTC'),
                  onPressed: () {
                    setState(() {
                      _zone = 'UTC';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // warna latar belakang button
                    onPrimary: Colors.white, // warna teks pada button
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
