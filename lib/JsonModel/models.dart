class Users {
  final int? userId;
  final String name;
  final String email;
  final int? phone;
  final String username;
  final String password;

  Users({
    this.userId,
    required this.name,
    required this.email,
    this.phone,
    required this.username,
    required this.password,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "username": username,
        "password": password,
      };
}

class Admin {
  final int? adminId;
  final String username;
  final String password;

  Admin({
    this.adminId,
    required this.username,
    required this.password,
  });

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        adminId: json["adminId"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "adminId": adminId,
        "username": username,
        "password": password,
      };
}

class TourBook {
  final int? bookId;
  final int userId;
  final String startTour;
  final String endTour;
  final String tourPackage;
  final int noPeople;
  final double packagePrice;

  TourBook({
    this.bookId,
    required this.userId,
    required this.startTour,
    required this.endTour,
    required this.tourPackage,
    required this.noPeople,
    required this.packagePrice,
  });

  factory TourBook.fromMap(Map<String, dynamic> json) => TourBook(
        bookId: json["bookId"] ?? 0,
        userId: json["userId"] ?? 0,
        startTour: json["startTour"] ?? '',
        endTour: json["endTour"] ?? '',
        tourPackage: json["tourPackage"] ?? '',
        noPeople: json["noPeople"] ?? 0,
        packagePrice: json["packagePrice"] ?? 0.0,
      );

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'userId': userId,
      'startTour': startTour,
      'endTour': endTour,
      'tourPackage': tourPackage,
      'noPeople': noPeople,
      'packagePrice': packagePrice,
    };
  }
}
