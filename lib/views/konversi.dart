import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KonversiPage extends StatefulWidget {
  const KonversiPage({super.key});

  @override
  State<KonversiPage> createState() => _KonversiPageState();
}

class _KonversiPageState extends State<KonversiPage> {
  late String choose1;
  late String choose2;
  late String _result;
  late double temp;

  late String _jumlah;

  @override
  void initState() {
    super.initState();
    choose1 = 'IDR';
    choose2 = 'IDR';
    _result = '';
    _jumlah = '';
    temp = 0;
  }

  void _hasil() {
    if (choose1 == 'IDR' && choose2 == 'USD') {
      setState(() {
        temp = double.parse(_jumlah) / 14200;
        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "IDR" && choose2 == "EUR") {
      setState(() {
        temp = double.parse(_jumlah) / 17000;
        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "USD" && choose2 == "IDR") {
      setState(() {
        temp = double.parse(_jumlah) * 14200;
        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "USD" && choose2 == "EUR") {
      setState(() {
        temp = double.parse(_jumlah) * 0.85;
        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "EUR" && choose2 == "IDR") {
      setState(() {
        temp = double.parse(_jumlah) * 17000;
        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "EUR" && choose2 == "USD") {
      setState(() {
        temp = double.parse(_jumlah) * 1.17;

        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "EUR" && choose2 == "EUR") {
      setState(() {
        temp = double.parse(_jumlah);
        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "USD" && choose2 == "USD") {
      setState(() {
        temp = double.parse(_jumlah);
        _result = temp.toStringAsFixed(4);
      });
    } else if (choose1 == "IDR" && choose2 == "IDR") {
      setState(() {
        temp = double.parse(_jumlah);
        _result = temp.toStringAsFixed(4);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          TextField(
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            onChanged: (value) {
              setState(() {
                _jumlah = value;
              });
            },
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                labelText: "Input Jumlah Uang",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 0, 0)))),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                  dropdownColor: Color.fromARGB(255, 255, 255, 255),
                  value: choose1,
                  items: <String>['IDR', 'USD', 'EUR'].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      choose1 = value ?? 'IDR';
                    });
                  })),
              DropdownButton<String>(
                  dropdownColor: Color.fromARGB(255, 255, 255, 255),
                  value: choose2,
                  items: <String>['IDR', 'USD', 'EUR'].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      choose2 = value ?? 'IDR';
                    });
                  })),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 45, 98, 73),
                  padding: EdgeInsets.symmetric(horizontal: 100)),
              onPressed: () {
                print(choose1);
                print(choose2);
                print(_jumlah);
                _hasil();
              },
              child: Text("Convert")),
          SizedBox(
            height: 15,
          ),
          Text(
            _result,
            style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
          )
        ]),
      )),
    );
  }
}
