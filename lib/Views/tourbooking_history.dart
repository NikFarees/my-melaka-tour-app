import 'package:flutter/material.dart';
import 'package:mymelaka/DatabaseHelper/database_helper.dart';
import 'package:mymelaka/JsonModel/models.dart';
import 'package:intl/intl.dart';

class TourBookingHistoryPage extends StatefulWidget {
  final int userId;

  TourBookingHistoryPage({Key? key, required this.userId}) : super(key: key);

  @override
  _TourBookingHistoryPageState createState() => _TourBookingHistoryPageState();
}

class _TourBookingHistoryPageState extends State<TourBookingHistoryPage> {
  late Future<List<TourBook>> tourBookings;

  @override
  void initState() {
    super.initState();
    tourBookings = DatabaseHelper().getTourBookingsByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour Booking History'),
        backgroundColor: Color.fromARGB(207, 241, 68, 0),
      ),
      body: FutureBuilder<List<TourBook>>(
        future: tourBookings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("No tour bookings found."));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TourBook booking = snapshot.data![index];
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('User ID: ${booking.userId}'),
                        Text('Start Tour: $formattedStartTourDate'),
                        Text('End Tour: $formattedEndTourDate'),
                        Text('Tour Package: ${booking.tourPackage}'),
                        Text('Number of People: ${booking.noPeople}'),
                        Text('Package Price: RM $formattedPackagePrice'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
