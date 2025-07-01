import 'package:flutter/material.dart';
import 'package:mymelaka/DatabaseHelper/database_helper.dart';
import 'package:mymelaka/JsonModel/models.dart';
import 'package:mymelaka/Views/receipt.dart';

class FormPage extends StatefulWidget {
  final int? userId;

  const FormPage({Key? key, this.userId}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  DatabaseHelper helper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String? _selectedPackage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberOfPeopleController =
      TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }

    if (_startDateTime != null && _endDateTime != null) {
      if (_endDateTime!.isBefore(_startDateTime!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('End tour date cannot be before start tour date.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    _formKey.currentState?.save();

    double packagePrice = 0.0;
    switch (_selectedPackage) {
      case 'Super Enjoy Package':
        packagePrice = 300;
        break;
      case 'Enjoy Package':
        packagePrice = 250;
        break;
      case 'Medium Package':
        packagePrice = 200;
        break;
      case 'Good Package':
        packagePrice = 150;
        break;
      case 'Standard Package':
        packagePrice = 100;
        break;
      default:
        packagePrice = 0.0;
    }

    double discountPercentage = 0.0;
    String enteredDiscountCode = _discountController.text.trim();

    if (enteredDiscountCode == '1234567') {
      discountPercentage = 0.1;
    } else if (enteredDiscountCode == 'abcdefg') {
      discountPercentage = 0.15;
    } else if (enteredDiscountCode == 'abcd123') {
      discountPercentage = 0.2;
    } else {
      discountPercentage = 0.0;
    }

    int numberOfPeople = int.parse(_numberOfPeopleController.text);
    double totalPriceBeforeDiscount = packagePrice * numberOfPeople;
    double discountAmount = 0.0;
    if (discountPercentage > 0) {
      discountAmount = totalPriceBeforeDiscount * discountPercentage;
    }
    double totalPrice = totalPriceBeforeDiscount - discountAmount;
    String discountAmountText =
        '${discountAmount.toStringAsFixed(2)} (${(discountPercentage * 100).toStringAsFixed(0)}% off)';

    // TourBook object
    TourBook tourBook = TourBook(
      userId: widget.userId ?? 0,
      startTour: _startDateTime.toString(),
      endTour: _endDateTime.toString(),
      tourPackage: _selectedPackage ?? '',
      noPeople: numberOfPeople,
      packagePrice: totalPrice,
    );

    // Insert TourBook data to database
    int result = await helper.insertTourBook(tourBook);

    if (result > 0) {
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (context) => Receipt(userData: {
            'User ID': widget.userId.toString(),
            'Name': _nameController.text,
            'Address': _addressController.text,
            'Phone number': _phoneController.text,
            'E-Mail': _emailController.text,
            'Start Tour Date': _startDateTime != null
                ? "${_startDateTime!.day}/${_startDateTime!.month}/${_startDateTime!.year}"
                : "",
            'End Tour Date': _endDateTime != null
                ? "${_endDateTime!.day}/${_endDateTime!.month}/${_endDateTime!.year}"
                : "",
            'Package': _selectedPackage!,
            'Package Price': packagePrice.toStringAsFixed(2),
            'Number of People': numberOfPeople.toString(),
            'Price Amount': totalPriceBeforeDiscount.toStringAsFixed(2),
            'Discount Amount': discountAmountText,
            'Total Price': totalPrice.toStringAsFixed(2),
          }),
        ),
      )
          .then((result) {
        if (result != null) {
          Navigator.pop(context, result);
        }
      });
    } else {
      // Handle error
    }
  }

  Future<void> _selectStartDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _startDateTime = picked;
      });
    }
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _endDateTime = picked;
      });
    }
  }

  final List<String> packageOptions = [
    'Super Enjoy Package',
    'Enjoy Package',
    'Medium Package',
    'Standard Package',
    'Good Package'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(207, 241, 68, 0),
        title: const Text("Booking Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, widget.userId);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  keyboardType: TextInputType.text,
                  controller: _addressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone number'),
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    _selectStartDateTime(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Start Tour Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.datetime,
                      controller: TextEditingController(
                        text: _startDateTime != null
                            ? "${_startDateTime!.day}/${_startDateTime!.month}/${_startDateTime!.year}"
                            : null,
                      ),
                      validator: (value) {
                        if (_startDateTime == null) {
                          return 'Start Tour Date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    _selectEndDateTime(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'End Tour Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.datetime,
                      controller: TextEditingController(
                        text: _endDateTime != null
                            ? "${_endDateTime!.day}/${_endDateTime!.month}/${_endDateTime!.year}"
                            : null,
                      ),
                      validator: (value) {
                        if (_endDateTime == null) {
                          return 'End Tour Date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Number of people'),
                  keyboardType: TextInputType.number,
                  controller: _numberOfPeopleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Number of people is required';
                    }
                    if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
                      return 'Please enter a valid input (positive number)';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Discount Code'),
                  keyboardType: TextInputType.text,
                  controller: _discountController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Package'),
                  value: _selectedPackage,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPackage = newValue;
                    });
                  },
                  items: packageOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Package is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // foreground
                  ),
                  child: Text('Submit'),
                  onPressed: () => _submit(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
