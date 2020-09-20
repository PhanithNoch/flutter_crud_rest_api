import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_flutter_basic/crud/models/people.dart';

class RestAPI{
  final String url = "https://peopleinfoapi.herokuapp.com";

  Future<List<People>> getPeople()async{
  final response = await http.get('$url/api/person');

  if(response.statusCode == 200){
    Map<String,dynamic> mapResponse = json.decode(response.body);
    final people = mapResponse['data'].cast<Map<String,dynamic>>();
    final listPeople = await people.map<People>((json){
      return People.fromJson(json);
    });
  }
  else{

    return null;
  }
  }
}