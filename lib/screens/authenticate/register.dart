import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register ({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Stack(
        children: [Loading()]
        ) : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Sign Up to Brew Crew'),
          actions: [
            TextButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Sign in'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.brown[900]),
            )
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) {
                      return val.isEmpty ? 'Enter an email' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) {
                      return val.length < 6 ? 'Enter a password 6+ chars long' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[400]),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      },
                      child: Text('Register',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                  ),
                  SizedBox(height: 20),
                  Text(error,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red
                  ),
                  )
                ],
                ))
        )
    );
  }
}
