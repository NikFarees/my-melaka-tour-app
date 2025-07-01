import 'package:flutter/material.dart';
import 'package:mymelaka/DatabaseHelper/database_helper.dart';
import 'package:mymelaka/JsonModel/models.dart';
import 'package:intl/intl.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late List<Users> _users = [];
  late List<TourBook> _tourBookings;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    // Fetch users data
    _users = await dbHelper.getAllUsers();

    // Fetch tour bookings data
    _tourBookings = await dbHelper.getAllTourBookings();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Color.fromARGB(207, 241, 68, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'User Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _buildUsersList(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Tour Bookings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _buildTourBookingsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersList() {
    if (_users.isEmpty) {
      return Center(
        child: Text('No users found.'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        Users user = _users[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(user.name),
            subtitle: Text(
                'User ID: ${user.userId}\nEmail: ${user.email}\nPhone: ${user.phone ?? '-'}\nUsername: ${user.username}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete User'),
                      content:
                          Text('Are you sure you want to delete this user?'),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(207, 241, 68, 0),
                          ),
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(207, 241, 68, 0),
                          ),
                          child: Text('Delete'),
                          onPressed: () async {
                            if (user.userId != null) {
                              DatabaseHelper dbHelper = DatabaseHelper();
                              await dbHelper.deleteUser(user.userId!);
                              await dbHelper
                                  .deleteTourBookingsByUserId(user.userId!);
                              _fetchData();
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTourBookingsList() {
    return FutureBuilder<List<TourBook>>(
      future: DatabaseHelper().getAllTourBookings(),
      builder: (BuildContext context, AsyncSnapshot<List<TourBook>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No tour bookings found.'));
        } else {
          _tourBookings = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _tourBookings.length,
            itemBuilder: (context, index) {
              TourBook booking = _tourBookings[index];
              DateTime startTourDate = DateTime.parse(booking.startTour);
              DateTime endTourDate = DateTime.parse(booking.endTour);
              String formattedStartTourDate =
                  DateFormat('yyyy-MM-dd').format(startTourDate);
              String formattedEndTourDate =
                  DateFormat('yyyy-MM-dd').format(endTourDate);
              String formattedPackagePrice =
                  booking.packagePrice.toStringAsFixed(2);
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(booking.bookId != null
                      ? 'Booking ID: ${booking.bookId}'
                      : 'Booking ID: -'),
                  subtitle: Text(
                    'User ID: ${booking.userId}\nStart Tour: $formattedStartTourDate\nEnd Tour: $formattedEndTourDate\nTour Package: ${booking.tourPackage}\nNumber of People: ${booking.noPeople}\nPackage Price: RM $formattedPackagePrice',
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
