import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main()
{
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php";
  List data;

  Future<String> getData() async {
    var res = await http.get(Uri.parse(url), headers: { 'x-rapidapi-host': "coronavirus-monitor.p.rapidapi.com",
    'x-rapidapi-key': "b5217cba71msh457a5ec22c1baf4p1c5249jsnd3bd57b00064","Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["countries_stat"];
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("corona - Data Update"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text("Country Name :" +data[index]["country_name"],
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black87)),
                            new Text("Cases   :"+data[index]['cases']),
                            new Text("Deaths   :"+data[index]['deaths']),
                            new Text("Total Recovered   :"+data[index]['total_recovered']),
                            new Text("New Deaths   :"+data[index]['new_deaths']),
                            new Text("New Cases   :"+data[index]['new_cases']),
                            new Text("Serious Critical   :"+data[index]['serious_critical']),
                            new Text("Active Cases  :"+data[index]['active_cases']),
                          //  new Text("Total Cases Per 1m Population   :"+data[index]['total_cases_per_1m_population']),
                          //  new Text("Deaths Per 1m Population  :"+data[index]['deaths_per_1m_population']),
                          //  new Text("Total Tests :"+data[index]['total_tests']),
                          //  new Text("Tests Per 1m Population  :"+data[index]['tests_per_1m_population']),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
}