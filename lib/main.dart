import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:squarefeet/SOF.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Add entries'),
          onPressed: () async {
            List<PersonEntry> persons = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SOF(),
              ),
            );
            if (persons != null) persons.forEach(print);
          },
        ),
      ),
    );
  }
}

class PersonEntry {
  final String name;
  final String age;

  PersonEntry(this.name, this.age);

  @override
  String toString() {
    return 'Person: name= $name, age= $age';
  }
}
