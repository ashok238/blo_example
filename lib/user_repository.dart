import 'dart:convert';

import 'package:bloc_example/photo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class UserRepository{

  Future<List<Photo>> getUsers() async{

   final res= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
   if(res.statusCode==200){
    var d= (jsonDecode(res.body) as List  ).cast<Map<String,dynamic>>() ;
    return parsePhotos(d);
   
   }
   throw Exception('');


}

  List<Photo> parsePhotos(List<Map<String,dynamic>> data){

 return data.map((e) => Photo.fromJson(e)).toList();
}

}