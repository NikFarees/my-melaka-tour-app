import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RatingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings and Reviews'),
        backgroundColor: Color.fromARGB(207, 241, 68, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildPackage(
              [
                'lib/assets/AFAMOSA.png',
                'lib/assets/BABA NYONYA.png',
                'lib/assets/CHEN HONG TENG TEMPLE.png',
                'lib/assets/DUTCH SQUARE.png',
                'lib/assets/MELAKA RIVER CRUISE.png',
                'lib/assets/MENARA TAMING SARI.png'
              ],
              'SUPER ENJOY PACK',
              1,
              context,
            ),
            buildPackage(
              [
                'lib/assets/BABA NYONYA.png',
                'lib/assets/CHEN HONG TENG TEMPLE.png',
                'lib/assets/DUTCH SQUARE.png',
                'lib/assets/MELAKA RIVER CRUISE.png',
                'lib/assets/PAULS CHURCH.png'
              ],
              'ENJOY PACK',
              1,
              context,
            ),
            buildPackage(
              [
                'lib/assets/AFAMOSA.png',
                'lib/assets/CHEN HONG TENG TEMPLE.png',
                'lib/assets/DUTCH SQUARE.png',
                'lib/assets/JONKER STREET.png'
              ],
              'MEDIUM PACK',
              1,
              context,
            ),
            buildPackage(
              [
                'lib/assets/MELAKA RIVER CRUISE.png',
                'lib/assets/JONKER STREET.png',
                'lib/assets/BABA NYONYA.png'
              ],
              'GOOD PACK',
              1,
              context,
            ),
            buildPackage(
              ['lib/assets/DUTCH SQUARE.png', 'lib/assets/JONKER STREET.png'],
              'STANDARD PACK',
              1,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackage(List<String> images, String title, double initialRating,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(images, title)),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enableInfiniteScroll: true,
                autoPlay: true,
                viewportFraction: 1.0, // Set to 1.0 to show one item per slide
              ),
              items: images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 15.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final List<String> images;
  final String title;

  DetailPage(this.images, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color.fromARGB(207, 241, 68, 0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  viewportFraction:
                      1.0, // Set to 1.0 to show one item per slide
                ),
                items: images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 300, // Set the desired height
                padding: EdgeInsets.all(10.0), // Adjust padding as needed
                color: Colors.grey[200], // Adjust background color as needed
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildComment('User 1', 'This is a great package!'),
                      _buildComment('User 2', 'I enjoyed my visit here.'),
                      _buildComment('User 3', 'Highly recommended.'),
                      _buildComment('User 4', 'Amazing experience!'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Rate this package:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Icon(Icons.star),
                  half: Icon(Icons.star_half),
                  empty: Icon(Icons.star_border),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: 20),
              ReviewForm(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(207, 241, 68, 0),
                ),
                child: Text(
                  'Submit Review',
                  style: TextStyle(
                      color: Colors.black), // Change text color to black here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to submit this review?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 206, 0, 0)), // Change text color to black here
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Navigate back to main page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(207, 241, 68, 0),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                    color: Colors.black), // Change text color to black here
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComment(String username, String comment) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(comment),
        subtitle: Text('- $username'),
      ),
    );
  }
}

class ReviewForm extends StatefulWidget {
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(207, 112, 112, 112),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          TextField(
            controller: _reviewController,
            decoration: InputDecoration(
              labelText: 'Enter your review',
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RatingsPage(),
  ));
}
