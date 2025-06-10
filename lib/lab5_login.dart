import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'data_repository.dart'; // Static class to store shared data

class Lab5LoginPage extends StatefulWidget {
  const Lab5LoginPage({super.key});

  @override
  State<Lab5LoginPage> createState() => _Lab5LoginPageState();
}

class _Lab5LoginPageState extends State<Lab5LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String imageSource = 'images/question-mark.png';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // Load saved credentials after the widget tree has been built
    Future.delayed(Duration.zero, _loadSavedCredentials);
  }

  // Read saved credentials from secure storage
  void _loadSavedCredentials() async {
    String? savedUsername = await _secureStorage.read(key: 'username');
    String? savedPassword = await _secureStorage.read(key: 'password');

    if (savedUsername != null && savedPassword != null) {
      setState(() {
        _usernameController.text = savedUsername;
        _passwordController.text = savedPassword;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loaded saved username and password.')),
      );
    }
  }

  // Show a dialog asking if the user wants to save credentials
  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Login Info?'),
          content: const Text('Do you want to save your username and password for next time?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _secureStorage.write(key: 'username', value: _usernameController.text);
                await _secureStorage.write(key: 'password', value: _passwordController.text);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () async {
                await _secureStorage.deleteAll();
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  // Validate the password and proceed based on result
  void _handleLogin() {
    String password = _passwordController.text;

    setState(() {
      if (password == 'QWERTY123') {
        imageSource = 'images/idea.png';

        // Save username to global repository
        DataRepository.loginName = _usernameController.text;

        // Navigate to the profile page
        Navigator.pushNamed(context, '/profile');

        // Show welcome message using Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome Back ${DataRepository.loginName}")),
        );

        // Ask user if they want to save credentials
        _showSaveDialog();
      } else {
        imageSource = 'images/stop.png';

        // Show error dialog for incorrect password
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Incorrect password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 5 Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Image.asset(imageSource, width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}
