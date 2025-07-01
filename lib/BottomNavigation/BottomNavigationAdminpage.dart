import 'package:flutter/material.dart';
import 'package:mymelaka/JsonModel/models.dart';
import 'package:mymelaka/Views/admin_page.dart';
import 'package:mymelaka/Views/adminprofile_page.dart';

class BottomNavigationAdminPage extends StatefulWidget {
  final Admin admin;

  BottomNavigationAdminPage({required this.admin});

  @override
  _BottomNavigationAdminPageState createState() =>
      _BottomNavigationAdminPageState();
}

class _BottomNavigationAdminPageState extends State<BottomNavigationAdminPage> {
  late PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
        children: [
          AdminPage(),
          AdminProfilePage(admin: widget.admin),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        selectedItemColor: Color.fromARGB(207, 241, 68, 0),
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
