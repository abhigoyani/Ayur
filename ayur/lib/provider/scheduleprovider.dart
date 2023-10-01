
import 'package:ayur/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Scheduleprovider with ChangeNotifier {

  Future<void> scheduleMed() async{
    try{
    final response = http.post(Uri.parse(Utility.URL),body: {
      "medicinename":"as",
      "medicineDes" : "headache",
    });
    }
    catch(e){

    }
    return await Future.delayed(Duration(seconds: 3));
  }
}
