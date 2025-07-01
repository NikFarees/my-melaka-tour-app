import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mymelaka/JsonModel/models.dart';
import 'package:mymelaka/Views/formpage.dart';

class PackagesPage extends StatelessWidget {
  final Users? user; // Define user parameter

  PackagesPage({Key? key, this.user})
      : super(key: key); // Add user to constructor

  bool isLoggedIn() {
    // Check if user is available
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isLoggedIn()
                        ? 'Welcome ${user?.name}!'
                        : 'Currently as guest',
                    style: TextStyle(
                      fontWeight:
                          isLoggedIn() ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isLoggedIn()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormPage(
                                userId: user
                                    ?.userId), // Access user ID from user object
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Login Required'),
                              content:
                                  Text('Please log in to book a tour package.'),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(207, 241, 68, 0),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(207, 241, 68, 0),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                    Navigator.pushNamed(context,
                                        '/login_page'); // Navigate to login page
                                  },
                                  child: Text('Go to Login Page'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Book Now",
                      style: TextStyle(
                        color: Color.fromARGB(207, 241, 68, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...buildPackages(context),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text('Our Packages'),
        ],
      ),
      backgroundColor: Color.fromARGB(207, 241, 68, 0),
    );
  }

  List<Widget> buildPackages(BuildContext context) {
    return [
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
        4,
        '''
Package Price: RM 300 per pax

Destinations:
- A Famosa
- Baba Nyonya Heritage Museum
- Cheng Hoon Teng Temple
- Dutch Square
- Melaka River Cruise
- Menara Taming Sari
''',
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
        3.5,
        '''
Package Price: RM 250 per pax

Destinations:
- Baba Nyonya Heritage Museum
- Cheng Hoon Teng Temple
- Dutch Square
- Melaka River Cruise
- St. Paul's Church
''',
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
          4.5,
          '''
Package Price: RM 200 per pax

Destinations:
- A Famosa
- Cheng Hoon Teng Temple
- Dutch Square
- Jonker Street
''',
          context),
      buildPackage(
          [
            'lib/assets/MELAKA RIVER CRUISE.png',
            'lib/assets/JONKER STREET.png',
            'lib/assets/BABA NYONYA.png'
          ],
          'GOOD PACK',
          5,
          '''
Package Price: RM 150 per pax

Destinations:
- Melaka River Cruise
- Jonker Street
- Baba Nyonya Heritage Museum
''',
          context),
      buildPackage(
          ['lib/assets/DUTCH SQUARE.png', 'lib/assets/JONKER STREET.png'],
          'STANDARD PACK',
          3,
          '''
Package Price: RM 100 per pax

Destinations:
- Dutch Square
- Jonker Street
''',
          context),
    ];
  }

  Widget buildPackage(List<String> images, String title, double initialRating,
      String packageDetails, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PackageDetail(images, title, initialRating, packageDetails))),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            buildCarousel(images),
            SizedBox(height: 15.0),
            Text(title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

CarouselSlider buildCarousel(List<String> images) {
  return CarouselSlider(
    options: CarouselOptions(
        height: 200,
        enableInfiniteScroll: true,
        autoPlay: true,
        viewportFraction: 1.0),
    items: images
        .map((image) => Builder(
            builder: (BuildContext context) =>
                buildImageContainer(context, image)))
        .toList(),
  );
}

Container buildImageContainer(BuildContext context, String image) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(color: Colors.amber),
    child: Image.asset(image, fit: BoxFit.cover),
  );
}

class PackageDetail extends StatelessWidget {
  final List<String> images;
  final String title;
  final double initialRating;
  final String packageDetails;

  PackageDetail(
      this.images, this.title, this.initialRating, this.packageDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title), backgroundColor: Color.fromARGB(207, 241, 68, 0)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildPackageDetails(context),
          ),
        ),
      ),
    );
  }

  List<Widget> buildPackageDetails(BuildContext context) {
    return [
      buildCarousel(images),
      SizedBox(height: 20),
      Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(height: 15),
      SizedBox(height: 20),
      Text('RATING',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      buildRatingBar(),
      SizedBox(height: 20),
      buildPackageDetailsContainer(),
    ];
  }

  RatingBar buildRatingBar() {
    return RatingBar.builder(
      initialRating: initialRating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) => print(rating),
      ignoreGestures: true,
    );
  }

  Container buildPackageDetailsContainer() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Package Details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
                text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    children: parsePackageDetails(packageDetails))),
          ),
        ],
      ),
    );
  }

  List<TextSpan> parsePackageDetails(String text) {
    final RegExp boldTag = RegExp(r'<b>(.*?)</b>');
    final List<TextSpan> children = [];
    text.splitMapJoin(
      boldTag,
      onMatch: (Match match) {
        children.add(TextSpan(
            text: match.group(1),
            style: TextStyle(fontWeight: FontWeight.bold)));
        return '';
      },
      onNonMatch: (String text) {
        if (text.isNotEmpty) {
          children.add(TextSpan(text: text));
        }
        return '';
      },
    );
    return children;
  }
}
