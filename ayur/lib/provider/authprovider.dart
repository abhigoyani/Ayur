import '../models/authmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../util/utility.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static AuthModel authUser = AuthModel();

  Future<dynamic> authenticate(String mobile) async {
    final response = await http.post(Uri.parse('${Utility.URL}/sendotp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobile_number": mobile}));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> extracteddata = json.decode(response.body);
      if (extracteddata['message'] == "pending") {
        authUser.setMobileNo = mobile;
        return Future(() => "Success");
      }
      return Future(() => "Fail");
    } else {
      return Future(() => "Fail");
    }
  }

  Future<String> verifyOTP(String otp) async {
    final response = await http.post(Uri.parse('${Utility.URL}/verifyotp'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "mobile_number": authUser.getMobileNo,
          "otp": otp,
        }));

    if (response.statusCode != 200) {
      return "Fail";
    }
    Map<String, dynamic> extracteddata = json.decode(response.body);
    if (!extracteddata.containsKey('token')) {
      return "Fail";
    }
    if (extracteddata['mobile_number'].toString().trim() == authUser.mobileNo) {
      // print(prefMap);
      print(extracteddata);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user", json.encode(extracteddata));
      authUser.setMobileNo = extracteddata['mobile_number'].toString();
      authUser.setToken = extracteddata['token'];
      // print(authUser.getMobileNo + authUser.getname);
      // print("USERID" + authUser.getuserID);
      return "Success";
    }
    return "Fail";
  }

  Future<bool> tryLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs.containsKey("user"));
      if (!prefs.containsKey("user")) {
        return false;
      }
      var userData = jsonDecode(prefs.getString("user") as String);
      authUser.setMobileNo = userData['mobile_number'].toString();
      authUser.setToken = userData['token'];
      // authUser.setname = userData['username'];
      // authUser.setuserid = userData['user_id'];
      // authUser.setprofilePIC = userData['profile_pic'];
      // // print(
      //     "Number"+authUser.getMobileNo + authUser.getname + authUser.getuserID);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> Logout() async {
    final r = await http.post(Uri.parse('${Utility.URL}/auth/logout'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"token": authUser.gettoken}));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print(r.body);
  }
}
