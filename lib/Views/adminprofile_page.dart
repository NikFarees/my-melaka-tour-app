import 'package:flutter/material.dart';
import 'package:mymelaka/Authentication/login_page.dart';
import 'package:mymelaka/JsonModel/models.dart';

class AdminProfilePage extends StatelessWidget {
  final Admin? admin;

  AdminProfilePage({required this.admin});

  @override
  Widget build(BuildContext context) {
    if (admin == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Please log in to view your profile.'),
              const SizedBox(height: 10),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(
                              onLogin: () {},
                            )),
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Admin Profile'),
          backgroundColor: Color.fromARGB(207, 241, 68, 0),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(207, 241, 68, 0),
                  child: Text(
                    admin!.username.isNotEmpty
                        ? admin!.username.substring(0, 1).toUpperCase()
                        : '?',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Admin Id: ${admin!.adminId}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Username: ${admin!.username}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Password: ${admin!.password}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Logout'),
                          content: Text('Do you want to logout?'),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Color.fromARGB(207, 241, 68, 0),
                              ),
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Color.fromARGB(207, 241, 68, 0),
                              ),
                              child: Text('Yes'),
                              onPressed: () {
                                // Pop the AlertDialog
                                Navigator.of(context).pop();
                                // Pop the AdminProfilePage
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // foreground
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
