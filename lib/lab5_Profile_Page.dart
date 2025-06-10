import 'package:flutter/material.dart';
import 'data_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class Lab5ProfilePage extends StatefulWidget {
  const Lab5ProfilePage({super.key});

  @override
  State<Lab5ProfilePage> createState() => _Lab5ProfilePageState();
}

class _Lab5ProfilePageState extends State<Lab5ProfilePage> {
  late TextEditingController _firstNameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController(text: DataRepository.firstName);
    _lastNameCtrl = TextEditingController(text: DataRepository.lastName);
    _phoneCtrl = TextEditingController(text: DataRepository.phone);
    _emailCtrl = TextEditingController(text: DataRepository.email);

    _firstNameCtrl.addListener(() {
      DataRepository.firstName = _firstNameCtrl.text;
      DataRepository.saveData();
    });
    _lastNameCtrl.addListener(() {
      DataRepository.lastName = _lastNameCtrl.text;
      DataRepository.saveData();
    });
    _phoneCtrl.addListener(() {
      DataRepository.phone = _phoneCtrl.text;
      DataRepository.saveData();
    });
    _emailCtrl.addListener(() {
      DataRepository.email = _emailCtrl.text;
      DataRepository.saveData();
    });
  }

  Future<void> _launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Unsupported"),
          content: Text("This device does not support $url"),
        ),
      );
    }
  }

  Widget _buildPhoneRow() {
    return Row(children: [
      Flexible(child: TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: "Phone"))),
      IconButton(icon: const Icon(Icons.phone), onPressed: () => _launch("tel:${_phoneCtrl.text}")),
      IconButton(icon: const Icon(Icons.sms), onPressed: () => _launch("sms:${_phoneCtrl.text}")),
    ]);
  }

  Widget _buildEmailRow() {
    return Row(children: [
      Flexible(child: TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: "Email"))),
      IconButton(icon: const Icon(Icons.mail), onPressed: () => _launch("mailto:${_emailCtrl.text}")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text("Welcome Back ${DataRepository.loginName}", style: const TextStyle(fontSize: 20)),
          TextField(controller: _firstNameCtrl, decoration: const InputDecoration(labelText: "First Name")),
          TextField(controller: _lastNameCtrl, decoration: const InputDecoration(labelText: "Last Name")),
          _buildPhoneRow(),
          _buildEmailRow(),
        ]),
      ),
    );
  }
}
