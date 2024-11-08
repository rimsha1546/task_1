import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Main widget to start the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// Home page where the form will be displayed
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

// State class for the form
class _HomePageState extends State<HomePage> {
  // GlobalKey to manage form state
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage input values for each TextField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Name validation: must not be empty and only contain letters
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Name should only contain letters';
    }
    return null;
  }

  // Email validation: basic email format check
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // CNIC validation: exactly 13 digits required
  String? _validateCNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your CNIC';
    }
    if (value.length != 13 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'CNIC must be 13 digits long';
    }
    return null;
  }

  // Phone validation: must be between 10-12 digits
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10 ||
        value.length > 12 ||
        !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number should be between 10-12 digits';
    }
    return null;
  }

  // Address validation: must not be empty
  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  // Password validation: must be at least 8 characters long and contain letters, numbers, and symbols
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
        !RegExp(r'[0-9]').hasMatch(value) ||
        !RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password must contain letters, numbers, and symbols';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of TextFields with Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Linking form to the key to manage its state
          child: ListView(
            children: [
              // Text field for name input
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: _validateName,
              ),

              // Text field for email input
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),

              // Text field for CNIC input (only numbers allowed)
              TextFormField(
                controller: _cnicController,
                decoration: const InputDecoration(labelText: 'CNIC'),
                keyboardType: TextInputType.number,
                validator: _validateCNIC,
              ),

              // Text field for phone number input
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),

              // Text field for address input
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: _validateAddress,
              ),

              // Text field for password input (hidden input)
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true, // Hides the text for security
                validator: _validatePassword,
              ),

              const SizedBox(height: 20),

              // Submit button to trigger validation
              ElevatedButton(
                onPressed: () {
                  // Check if the form is valid when the button is pressed
                  if (_formKey.currentState!.validate()) {
                    // If valid, show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('All inputs are valid!')));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
