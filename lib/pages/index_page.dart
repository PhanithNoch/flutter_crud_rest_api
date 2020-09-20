import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learn_flutter_basic/pages/create.dart';
import '../pages/edit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  String url = "https://peopleinfoapi.herokuapp.com/api/";
  List people = [];
  bool isLoading = false;

  Future getPeople() async {
    setState(() {
      this.isLoading = false;
    });
    var response = await http.get(url + "people");

    if (response.statusCode == 200) {
      var items = json.decode(response.body)['data'];
      setState(() {
        people = items;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List People'),
        actions: [
          FlatButton(
            child: Icon(
              Icons.add_box,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatePeople()));
            },
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (this.people.length == 0) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: this.people.length,
        itemBuilder: (context, index) {
          return cardItem(this.people[index]);
        });
  }

  Widget cardItem(items) {
    var first_name = items['first_name'];
    var email = items['email'];
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Text(first_name),
            subtitle: Text(email),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () => EditPeopleAction(items),
          ),
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => showDeleteAlert(context, items)),
        ],
      ),
    );
  }

//   EditPeopleAction()
//   {
// Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPeople()));
//   }

  showDeleteAlert(BuildContext context, items) {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes", style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.pop(context);

        deletePeople(items['id']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Would you like to delete this user?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  EditPeopleAction(item) {
    var peopleId = item['id'].toString();
    var first_name = item['first_name'].toString();
    var email = item['email'].toString();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditPeople(
                personId: peopleId, email: email, first_name: first_name)));
  }

  deletePeople(peopleId) async {
    var url = "https://peopleinfoapi.herokuapp.com/api/person/$peopleId";
    var response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      this.getPeople();
    } else {
      print(response.statusCode);
    }
  }
}
