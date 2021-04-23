import 'package:flutter/material.dart';
import 'package:public_review/EssentialWidgets/Header.dart';
import 'package:public_review/Misc/OpenFile.dart';

class CompleteSignUpOfCustomUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CompleteSignUpOfCustomUser();
}

class _CompleteSignUpOfCustomUser extends State<CompleteSignUpOfCustomUser> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  String politicalParty = "Democratic Party";
  String state = "Alabama";

  Widget createIconForRow(Icon icon) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 75,
      width: 35,
      alignment: Alignment.center,
      child: icon,
    );
  }

  Widget createAreaForInputInRow(Widget child) {
    return Container(
        padding: EdgeInsets.all(8.0),
        height: 75,
        width: 350,
        alignment: Alignment.center,
        child: child);
  }

  Widget textFormRow(
      {required Icon icon,
      required TextEditingController controller,
      required String labelText,
      required Function validator}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        createIconForRow(icon),
        createAreaForInputInRow(
            textFormInput(controller, labelText, validator)),
      ],
    );
  }

  Widget dropdownRow(
      {required Icon icon,
      required String dropdownValue,
      required List<String> items,
      required String hint}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        createIconForRow(icon),
        createAreaForInputInRow(dropDownInput(hint, dropdownValue, items)),
      ],
    );
  }

  Widget textFormInput(
      TextEditingController controller, String labelText, Function validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: (value) => validator(value),
    );
  }

  Widget dropDownInput(String hint, String dropdownValue, List<String> items) {
    return DropdownButton<String>(
      hint: Text(hint),
      isExpanded: true,
      elevation: 5,
      iconEnabledColor: Colors.green,
      style: TextStyle(fontFamily: "Dosis", fontSize: 20, color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget infoForm() {
    return Form(
      key: registerFormKey,
      child: Column(
        children: <Widget>[
          dropdownRow(
            icon: Icon(Icons.access_alarm),
            dropdownValue: politicalParty,
            items: <String>[
              'Democratic Party',
              'Republican Party',
              'Independent Party'
            ],
            hint: "Political Party",
          ),
          dropdownRow(
            icon: Icon(Icons.satellite),
            dropdownValue: state,
            items: GetData().getStates(),
            hint: "Registered State",
          )
        ],
      ),
    );
  }

  Widget almostDoneLabel() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Almost Done",
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Dosis",
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        alignment: Alignment.center,
        child: ListView(
          physics: const ScrollPhysics(),
          shrinkWrap: false,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                almostDoneLabel(),
                infoForm(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GetData {
  List<String> getStates() {
    return <String>[
      "Alabama",
      "Alaska",
      "Arizona",
      "Arkansas",
      "California",
      "Colorado",
      "Connecticut",
      "Delaware",
      "Florida",
      "Georgia",
      "Hawaii",
      "Idaho",
      "Illinois",
      "Indiana",
      "Iowa",
      "Kansas",
      "Kentucky",
      "Louisiana",
      "Maine",
      "Maryland",
      "Massachusetts",
      "Michigan",
      "Minnesota",
      "Mississippi",
      "Missouri",
      "Montana",
      "Nebraska",
      "Nevada",
      "New Hampshire",
      "New Jersey",
      "New Mexico",
      "New York",
      "North Carolina",
      "North Dakota",
      "Ohio",
      "Oklahoma",
      "Oregon",
      "Pennsylvania",
      "Rhode Island",
      "South Carolina",
      "South Dakota",
      "Tennessee",
      "Texas",
      "Utah",
      "Vermont",
      "Virginia",
      "Washington",
      "West Virginia",
      "Wisconsin",
      "Wyoming",
    ];
  }
}
