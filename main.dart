import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HEALTH SAVIOR'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset('assets/home1.jpg'),
                ),
              ),
              Divider(
                height: 90.0,
                color: Colors.grey[800],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your health is our priority ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'You forgot your medication, and you don\'t know how to keep your meal healthy? Our app is here to help you! ',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[800],
                      ),
                      child: Text('Start the app'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  radius: 80.0,
                ),
              ),
              Divider(
                height: 90.0,
                color: Colors.grey[800],
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Create(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[800],
                        minimumSize: Size(200, 50),
                      ),
                      child: Text('Create my account'),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Connect(),
                          ),
                        );
                      },
                      child: Text(
                        'I already have an account! Connect',
                        style: TextStyle(
                          color: Colors.grey[850],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Create extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController loginController = TextEditingController();

  Future<void> sendData(BuildContext context) async {
    var url = Uri.parse('http://localhost/flutter/create.php');

    try {
      var response = await http.post(url, body: {
        'password': passwordController.text,
        'disease': diseaseController.text,
        'login': loginController.text,
      });

      if (response.statusCode == 200) {
        print('Données envoyées avec succès');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Menu(
                login: loginController.text, password: passwordController.text),
          ),
        );
      } else {
        print('Erreur lors de l\'envoi des données : ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'envoi des données')),
        );
      }
    } catch (e) {
      print('Erreur lors de l\'envoi des données : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 50.0,
              ),
            ),
            Divider(
              height: 70.0,
              color: Colors.grey[800],
            ),
            Text(
              'Password',
              style: TextStyle(
                color: Colors.grey[850],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Disease',
              style: TextStyle(
                color: Colors.grey[850],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: diseaseController,
              decoration: InputDecoration(
                hintText: 'Enter your disease',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Login',
              style: TextStyle(
                color: Colors.grey[850],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: loginController,
              decoration: InputDecoration(
                hintText: 'Enter your login',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      sendData(context);
                      /*
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Menu(
                              login: loginController.text,
                              password: passwordController.text),
                        ),
                      );*/
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[800],
                      minimumSize: Size(200, 50),
                    ),
                    child: Text('Start my journey'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Connect extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();

  Future<void> checkCode(BuildContext context, String login) async {
    var url = Uri.parse('http://localhost/flutter/check_code.php');
    try {
      var response = await http.post(url, body: {
        'code': codeController.text,
        'login': loginController.text,
      });

      if (response.statusCode == 200) {
        String responseBody = response.body.trim();
        if (responseBody == 'exists') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Menu(
                  login: loginController.text, password: codeController.text),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Create your account please')),
          );
        }
      } else {
        print('Erreur lors de la vérification du code');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error checking code')),
        );
      }
    } catch (e) {
      print('Erreur lors de la vérification du code : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 60.0,
              ),
            ),
            Divider(
              height: 90.0,
              color: Colors.grey[800],
            ),
            Text(
              'Password',
              style: TextStyle(
                color: Colors.grey[850],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: codeController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Login',
              style: TextStyle(
                color: Colors.grey[850],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: loginController,
              decoration: InputDecoration(
                hintText: 'Enter your login',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      checkCode(context, loginController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[800],
                      minimumSize: Size(200, 50),
                    ),
                    child: Text('Start my journey'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final String login;
  final String password;
  Menu({required this.login, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          reverse: true, // Barre de défilement à gauche
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ButtonWithImageGroup(
                    imagePath: 'assets/téléchargement.png',
                    buttonText: 'My group',
                    login: login,
                    password: password,
                    onPressed: () {
                      // Action to perform when Button 1 is pressed
                    },
                  ),
                  SizedBox(height: 20.0),
                  ButtonWithImage(
                    imagePath: 'assets/reminder.jpg',
                    buttonText: 'Reminder',
                    login: login,
                    password: password,
                    onPressed: () {
                      // Action to perform when Button 1 is pressed
                    },
                  ),
                  SizedBox(height: 20.0),
                  ButtonWithImageScanner(
                    imagePath: 'assets/scanner.jpg',
                    buttonText: 'Scanner',
                    onPressed: () {
                      // Action à effectuer lorsque le bouton Scanner est appuyé
                    },
                  ),
                  /*
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Conversation(login: login, password: password),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[800],
                          minimumSize: Size(200, 50),
                        ),
                        child: Text('My Group'),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWithImageGroup extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;
  final String login;
  final String password;

  const ButtonWithImageGroup(
      {required this.imagePath,
      required this.buttonText,
      required this.onPressed,
      required this.login,
      required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Conversation(login: login, password: password),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey[800]!),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(4.0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class ButtonWithImage extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;
  final String login;
  final String password;

  const ButtonWithImage(
      {required this.imagePath,
      required this.buttonText,
      required this.onPressed,
      required this.login,
      required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PillReminderApp(login: login, password: password),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey[800]!),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(4.0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class ButtonWithImageScanner extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const ButtonWithImageScanner({
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey[800]!),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(4.0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class PillReminderApp extends StatelessWidget {
  final String login;
  final String password;
  PillReminderApp({required this.login, required this.password});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pill Reminder',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 37, 37,
            37), // Change background color to match the second page
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content vertically
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Pill Reminder!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Colors.black, // Change text color to match the first page
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Looks like you\'re new here. Click the button below to create your first pill schedule:',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              // Button for creating new pill schedule
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PillFormPage(
                              login: login,
                              password: password,
                            )),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[
                      800]!), // Change button color to match the first page
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Set text color to white
                ),
                child: Text('Create my reminder'),
              ),
              SizedBox(height: 20),
              Text(
                'Already have a pill schedule? Click the button below to update or add new pills:',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              // Button for updating existing or adding new pills
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PillFormPageUpdate(
                              login: login,
                              password: password,
                            )),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[
                      800]!), // Change button color to match the first page
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Set text color to white
                ),
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PillFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String login;
  final String password;
  PillFormPage({required this.login, required this.password});
  TextEditingController _medicineNameController = TextEditingController();
  TextEditingController _numberOfTimesController = TextEditingController();
  TextEditingController _beforeOrAfterController = TextEditingController();
  TextEditingController _time1Controller = TextEditingController();
  TextEditingController _time2Controller = TextEditingController();
  TextEditingController _time3Controller = TextEditingController();

  void submitForm(BuildContext context) async {
    var url = Uri.parse(
        'http://localhost/flutter/insertreminder.php'); // Update with the URL of your PHP script
    var response = await http.post(url, body: {
      'medicine_name': _medicineNameController.text,
      'number_of_times': _numberOfTimesController.text,
      'before_or_after': _beforeOrAfterController.text,
      'time_1': _time1Controller.text,
      'time_2': _time2Controller.text,
      'time_3': _time3Controller.text,
      'login': login,
      'password': password,
    });

    if (response.statusCode == 200) {
      // Data successfully saved
      print('Form data saved successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    } else {
      // Error occurred
      print('Error saving form data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pill Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset('assets/rem.jpg'),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _medicineNameController,
                      decoration: InputDecoration(
                        labelText: 'Medicine Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the medicine name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _numberOfTimesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of Times',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _beforeOrAfterController,
                      decoration: InputDecoration(
                        labelText: 'Before or After',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter before or after';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _time1Controller,
                      decoration: InputDecoration(
                        labelText: 'Time 1',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter time 1';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _time2Controller,
                      decoration: InputDecoration(
                        labelText: 'Time 2',
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _time3Controller,
                      decoration: InputDecoration(
                        labelText: 'Time 3',
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              submitForm(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              minimumSize: Size(200, 50),
                            ),
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PillFormPageUpdate extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String login;
  final String password;
  PillFormPageUpdate({required this.login, required this.password});
  TextEditingController _medicineNameController = TextEditingController();
  TextEditingController _numberOfTimesController = TextEditingController();
  TextEditingController _beforeOrAfterController = TextEditingController();
  TextEditingController _time1Controller = TextEditingController();
  TextEditingController _time2Controller = TextEditingController();
  TextEditingController _time3Controller = TextEditingController();

  void submitForm(BuildContext context) async {
    var url = Uri.parse(
        'http://localhost/flutter/updatereminder.php'); // Update with the URL of your PHP script
    var response = await http.post(url, body: {
      'medicine_name': _medicineNameController.text,
      'number_of_times': _numberOfTimesController.text,
      'before_or_after': _beforeOrAfterController.text,
      'time_1': _time1Controller.text,
      'time_2': _time2Controller.text,
      'time_3': _time3Controller.text,
      'login': login,
      'password': password,
    });

    if (response.statusCode == 200) {
      // Data successfully saved
      print('Form data saved successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SuccessPageUpdate()),
      );
    } else {
      // Error occurred
      print('Error saving form data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pill Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset('assets/rem.jpg'),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _medicineNameController,
                      decoration: InputDecoration(
                        labelText: 'Medicine Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the medicine name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _numberOfTimesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of Times',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _beforeOrAfterController,
                      decoration: InputDecoration(
                        labelText: 'Before or After',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter before or after';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _time1Controller,
                      decoration: InputDecoration(
                        labelText: 'Time 1',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter time 1';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _time2Controller,
                      decoration: InputDecoration(
                        labelText: 'Time 2',
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _time3Controller,
                      decoration: InputDecoration(
                        labelText: 'Time 3',
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              submitForm(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              minimumSize: Size(200, 50),
                            ),
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Success! Your information has been saved',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessPageUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Success! Your information has been updated',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Conversation extends StatefulWidget {
  final String login;
  final String password;
  Conversation({required this.login, required this.password});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final TextEditingController messageController = TextEditingController();
  List<Map<String, String>> messages = [];

  Future<void> _sendMessage(String message) async {
    setState(() {
      messages.add({"login": widget.login, "message": message});
      messageController.clear();
    });
    var url = Uri.parse('http://localhost/flutter/insert_message.php');

    try {
      // Envoi des données au script PHP
      var response = await http.post(url, body: {
        'login': widget.login,
        'message': message,
        'password': widget.password,
      });

      // Vérification de la réponse du serveur
      if (response.statusCode == 200) {
        print('Message inséré avec succès');
        // Rafraîchir la liste des messages après l'insertion
        _getMessages(); // Mettre à jour la liste des messages après l'envoi
      } else {
        print('Erreur lors de l\'insertion du message');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  Future<void> _getMessages() async {
    var url = Uri.parse('http://localhost/flutter/get_messages.php');

    try {
      // Récupération des données depuis le script PHP
      var response = await http.post(url, body: {
        'password': widget.password,
      });

      // Vérification de la réponse du serveur
      if (response.statusCode == 200) {
        // Convertir le corps de la réponse en une liste de cartes (Map) de chaînes (String)
        List<dynamic> responseBody = json.decode(response.body);

        setState(() {
          // Mise à jour de la liste des messages
          this.messages = responseBody
              .map<Map<String, String>>(
                  (item) => Map<String, String>.from(item))
              .toList();
        });
      } else {
        print('Erreur lors de la récupération des messages');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Au chargement de la page, récupérer les messages
    _getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation'),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isCurrentUserMessage =
                      messages[index]["login"] == widget.login;

                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          messages[index]["login"] ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            color: isCurrentUserMessage
                                ? Colors.blue
                                : Colors.black,
                            // Choisir la couleur en fonction de l'utilisateur
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isCurrentUserMessage
                                ? Colors.blue[100]
                                : Colors.grey[300],
                            // Choisir la couleur de fond en fonction de l'utilisateur
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(messages[index]["message"] ?? ""),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = messageController.text;
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  late final String apiUrl = 'http://localhost/flutter/gettimes.php';
  bool isAlarmRinging = false;

  @override
  void initState() {
    super.initState();
    // Appeler la fonction pour vérifier les alarmes périodiquement
    Timer.periodic(Duration(seconds: 30), (timer) {
      checkAlarms();
    });
  }

  Future<void> checkAlarms() async {
    try {
      // Faire une requête HTTP vers le script PHP pour vérifier les alarmes
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Si la réponse est réussie, déclencher l'alarme
        setState(() {
          isAlarmRinging = true;
        });
        // Ici vous pouvez afficher une notification ou déclencher une alarme dans l'application Flutter
      } else {
        // En cas d'erreur, afficher un message d'erreur
        print('Erreur lors de la vérification des alarmes');
      }
    } catch (error) {
      // En cas d'erreur, afficher un message d'erreur
      print('Erreur lors de la vérification des alarmes : $error');
    }
  }

  void stopAlarm() {
    // Arrêter l'alarme
    setState(() {
      isAlarmRinging = false;
    });
    // Ici vous pouvez arrêter la sonnette ou la notification
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isAlarmRinging)
              ElevatedButton(
                onPressed: stopAlarm,
                child: Text('Arrêter le son'),
              ),
            SizedBox(height: 20),
            Text(
              'Reminder Page',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
