import 'package:flutter/material.dart';
import 'package:mymelaka/BottomNavigation/BottomNavigationPage.dart';
import 'package:mymelaka/Views/admin_page.dart';
import 'package:mymelaka/Authentication/login_page.dart';
import 'package:mymelaka/Authentication/register_page.dart';
import 'package:mymelaka/Views/formpage.dart';
import 'package:mymelaka/Views/ratingspage.dart';
import 'package:mymelaka/Views/receipt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melaka Tour App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ValueListenableBuilder<bool>(
              valueListenable: isLoggedIn,
              builder: (context, isLoggedIn, child) {
                if (isLoggedIn) {
                  return BottomNavigationPage(); // Show bottom navigation bar after login
                } else {
                  return BottomNavigationPage();
                }
              },
            ),
        '/login_page': (context) => LoginPage(
              onLogin: () {},
            ),
        '/register_page': (context) => RegisterPage(),
        '/admin_page': (context) => AdminPage(),
        '/form': (context) => FormPage(),
        '/receipt': (context) => Receipt(
              userData: {},
            ),
        '/ratings': (context) => RatingsPage(),
      },
    );
  }
}
