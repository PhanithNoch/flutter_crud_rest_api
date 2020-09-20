import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPeople extends StatefulWidget {
  String personId;
  String email;
  String first_name;
  EditPeople({this.personId, this.email, this.first_name});
  @override
  _EditPeopleState createState() => _EditPeopleState();
}

class _EditPeopleState extends State<EditPeople> {
  String personId;
  String url = "https://peopleinfoapi.herokuapp.com/api/";
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.personId);
    _controllerFirstName.text = widget.first_name;
    _controllerEmail.text = widget.email;
    personId = widget.personId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Poeple'),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerFirstName,
          cursorColor: Colors.pink,
          decoration: InputDecoration(hintText: "First Name"),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _controllerEmail,
          cursorColor: Colors.pink,
          decoration: InputDecoration(hintText: "Email"),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton(
          color: Colors.blue,
          child: Text(
            'Done',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            editPerson();
          },
        ),
      ],
    );
  }

  editPerson() async {
    var url = "${this.url}person/${personId}";
    var email = _controllerFirstName.text;
    var first_name = _controllerEmail.text;
    var bodyData = json.encode({"first_name": first_name, "email": email});

    var response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: bodyData);
    if (response.statusCode == 200) {
      print("successfully");
    } else {
      print(response.statusCode);
    }
    print(url);
  }
}
