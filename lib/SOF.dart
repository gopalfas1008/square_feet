import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:squarefeet/main.dart';

import 'DecimalTextInputFormatter.dart';

/**
    Create By Himalay
    Create Date 10/4/2020*/

class SOF extends StatefulWidget {
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  Map<String, TextEditingController> nameTECs = Map();
  Map<String, TextEditingController> ageTECs = Map();
  Map<String, TextEditingController> qtyTECs = Map();
  Map<String, double> square = Map();
  var cards = <Card>[];

  Card getCard(int pos) {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var qtyController = TextEditingController();
    if (nameTECs[pos.toString()] == null) {
      qtyController.text="1";
      nameTECs[pos.toString()] = nameController;
      ageTECs[pos.toString()] = ageController;
      qtyTECs[pos.toString()] = qtyController;
    } else {
      nameController = nameTECs[pos.toString()];
      ageController = ageTECs[pos.toString()];
      qtyController = qtyTECs[pos.toString()];
    }
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 50,
            margin: EdgeInsets.fromLTRB(5,0,0,0),
            child: TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
//        keyboardType: TextInputType.numberWithOptions(decimal: true),

              onChanged: (value) {
                if (value.isEmpty) {
                  square[pos.toString()] = 0;
                } else {
                  square[pos.toString()] =
                      getFitWidth(double.parse(nameController.text).ceil()) *
                          getFitWidth(double.parse(ageController.text).ceil()) *
                          double.parse(qtyController.text) /
                          144;
                }
                calTotal();
                setState(() {});
              },
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(labelText: 'Qty'),
            ),
          ),
          Expanded(
            child: TextField(
                controller: nameController,
//                keyboardType: TextInputType.number,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 5)],
                onChanged: (value) {
                  if (value.isEmpty) {
                    square[pos.toString()] = 0;
                  } else {
                    square[pos.toString()] = getFitWidth(
                            double.parse(nameController.text).ceil()) *
                        getFitWidth(double.parse(ageController.text).ceil()) *
                        double.parse(qtyController.text) /
                        144;
                  }
                  calTotal();
                  setState(() {});
                },
//              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly
//              ],
                decoration: InputDecoration(labelText: 'Width')),
          ),
          Expanded(
            child: TextField(
                controller: ageController,
//                keyboardType: TextInputType.number,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 5)],

//             inputFormatters: <TextInputFormatter>[
//               WhitelistingTextInputFormatter.digitsOnly
//             ],
                onChanged: (value) {
                  if (value.isEmpty) {
                    square[pos.toString()] = 0;
                  } else {
                    square[pos.toString()] = getFitWidth(
                            double.parse(nameController.text).ceil()) *
                        getFitWidth(double.parse(ageController.text).ceil()) *
                        double.parse(qtyController.text) /
                        144;
                  }
                  calTotal();
                  setState(() {});
                },
                decoration: InputDecoration(labelText: 'Height')),
          ),
          Expanded(
            child: Text(square[pos.toString()].toString() ?? "0" + ""),
          ),
          InkWell(
            onTap: () {
              cards.removeAt(pos);
              square.remove(pos.toString());
              calTotal();
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(3),
              child: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }

  calSquare() {}

  @override
  void initState() {
    super.initState();
    cards.add(getCard(cards.length));
  }

  _onDone() {
    List<PersonEntry> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var name = nameTECs[i].text;
      var age = ageTECs[i].text;
      entries.add(PersonEntry(name, age));
    }
    Navigator.pop(context, entries);
  }

  @override
  Widget build(BuildContext context) {
//    cards.add(createCard());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return getCard(index);
              },
            ),
          ),

//          Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: RaisedButton(
//              child: Text('add new'),
//              onPressed: () => setState(() => cards.add(getCard(cards.length))),
//            ),
//          ),
          Container(
            color: Colors.black38,
            height: 30,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "Total :",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    totalSqft.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => setState(() => cards.add(getCard(cards.length)))),
    );
  }

  double totalSqft = 0;

  void calTotal() {
    totalSqft = 0;
    square.forEach((key, value) {
      totalSqft += value;
    });
  }

  getFitWidth(int oldvalue) {
    int val = (((oldvalue / 3).floor() + 1) * 3);
    return val;
  }
}
