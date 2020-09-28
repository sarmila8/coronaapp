import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Thuloapp(),
    ));

class Thuloapp extends StatefulWidget {
  @override
  _ThuloappState createState() => _ThuloappState();
}

class _ThuloappState extends State<Thuloapp> {
  bool loading = true;
  List lstcountry;

// ignore: missing_return
  Future<String> _getWordData() async {
    var response = await http.get("https://brp.com.np/covid/country.php");

    var getdata = json.decode(response.body);
    if (this.mounted) {
      setState(() {
        loading = false;
        lstcountry = [getdata];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("corona app"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getWordData();
              }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lstcountry == null
                      ? 0
                      : lstcountry[0]["countries_stat"].length,
                  itemBuilder: (context, i) {
                    return listitem(i);
                  }),
        ],
      ),
    );
  }

  Widget listitem(int i) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            lstcountry[0]["countries_stat"][i]["country_name"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstcountry[0]["countries_stat"][i]["active_cases"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text("active cases"),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstcountry[0]["countries_stat"][i]["deaths"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text("deaths"),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstcountry[0]["countries_stat"][i]["total_recovered"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text("total recover"),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(10)),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstcountry[0]["countries_stat"][i]["cases"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text("total cases"),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstcountry[0]["countries_stat"][i]["new_deaths"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text(" new deaths"),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      lstcountry[0]["countries_stat"][i]["new_cases"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text("new cases"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
