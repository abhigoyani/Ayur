import 'package:ayur/provider/scheduleprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import './provider/authprovider.dart';
import './screens/signinscreen.dart';
import './screens/otpscreen.dart';
import './screens/navbarscreen.dart';
import './screens/schedulescreen.dart';
import './screens/symptomsscreen.dart';

void main() async{
  
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProvider.value(value: Scheduleprovider()),
        ],
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) => MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.amber,
                fontFamily: 'Rubik',
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline5: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik'),
                      bodyText1: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Rubik',
                        color: Colors.black,
                      ),
                    )),
            home: FutureBuilder(
              future: auth.tryLogin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SignInScreen();
                }
                if (snapshot.data == false) {
                  return SignInScreen();
                } else {
                  return NavbarScreen();
                }
              },
            ),
            routes: {
              SignInScreen.routeName: (context) => SignInScreen(),
              OTPscreen.routeName: (context) => OTPscreen(),
              ScheduleScreen.routeName: (context) => ScheduleScreen(),
              SymptomsScreen.routeName: (context) => SymptomsScreen(),
            },
          ),
        ));
  }
}
