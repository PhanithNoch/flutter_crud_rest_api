import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_flutter_basic/utils/util.dart';
class CreatePeople extends StatefulWidget {
  @override
  _CreatePeopleState createState() => _CreatePeopleState();
}

class _CreatePeopleState extends State<CreatePeople> {
  String url = "https://peopleinfoapi.herokuapp.com/api/";
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerEamil = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Poeple'),
      ),

      body: getBody(),
    );
  }

 Widget getBody() {
return ListView(
  padding: EdgeInsets.all(30),

  children: [
    SizedBox(height: 30,),
    TextField(
      controller:_controllerFirstName,
      cursorColor: Colors.pink,
      decoration: InputDecoration(
        hintText: "First Name"
      ),
    ),
    SizedBox(height: 10,),
    TextField(
      controller:_controllerEamil,
      cursorColor: Colors.pink,
      decoration: InputDecoration(
        hintText: "First Name"
      ),
    ),
SizedBox(height: 10,),
    FlatButton(
      color: Colors.blue,
      child: Text('Done',style: TextStyle(color: Colors.white),),
      onPressed: (){
        createPeople();
      },
    ),
  ],
);
 }
 createPeople() async
 {
   var first_name = _controllerFirstName.text;
   var email = _controllerEamil.text;
   if(first_name.isNotEmpty && email.isNotEmpty){
     var createUrl = "https://peopleinfoapi.herokuapp.com/api/people";
     var data = json.encode(
         {
           "first_name":first_name,
           "email":email,
           "last_name":"gamer",
           "phone":"011 50 44 63",
           "city":"pp"
         }

         );
   var response = await  http.post(createUrl,headers: {
     "Content-Type":"application/json",
       "Accept":"application/json"
     },body: data);
   if(response.statusCode == 201){
     showMessage(context,"people created !");
   }
   }
 }
}
