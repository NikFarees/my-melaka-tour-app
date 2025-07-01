import 'package:flutter/material.dart';
import 'package:mymelaka/DatabaseHelper/database_helper.dart';
import 'package:mymelaka/JsonModel/models.dart';

class UpdateProfilePage extends StatefulWidget {
  final Users? user;

  UpdateProfilePage({Key? key, this.user}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name);
    _emailController = TextEditingController(text: widget.user?.email);
    _phoneController =
        TextEditingController(text: widget.user?.phone?.toString());
    _passwordController = TextEditingController(text: widget.user?.password);
    _usernameController = TextEditingController(text: widget.user?.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        backgroundColor: Color.fromARGB(207, 241, 68, 0),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextField(_nameController, 'Name', Icons.person),
                  _buildTextField(
                      _usernameController, 'Username', Icons.account_circle),
                  _buildTextField(_emailController, 'Email', Icons.email),
                  _buildTextField(_phoneController, 'Phone', Icons.phone),
                  _buildPasswordField(),
                  const SizedBox(height: 10),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(207, 241, 68, 0),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (widget.user?.userId == null) {
                            print('Error: User ID is null');
                            return;
                          }
                          Users updatedUser = Users(
                            userId: widget.user?.userId,
                            name: _nameController.text,
                            username: _usernameController.text,
                            email: _emailController.text,
                            phone: int.tryParse(_phoneController.text),
                            password: _passwordController.text,
                          );
                          await DatabaseHelper().updateUser(updatedUser);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "UPDATE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(207, 241, 68, 0).withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: TextStyle(fontSize: 16)),
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return "$labelText is required";
              } else if (labelText == 'Email' &&
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}")
                      .hasMatch(value)) {
                return "Please enter a valid email";
              }
              return null;
            },
            decoration: InputDecoration(
              icon: Icon(icon),
              border: InputBorder.none,
              hintText: labelText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(207, 241, 68, 0).withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password', style: TextStyle(fontSize: 16)),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password is required";
              }
              return null;
            },
            obscureText: !isVisible,
            decoration: InputDecoration(
              icon: const Icon(Icons.lock),
              border: InputBorder.none,
              hintText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
