import 'package:brew_crew/modules/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/services/auth.dart';
import 'package:brew_crew/screens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed_data/typed_buffers.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 60
              ),
              child: Text('Bottom sheet'),

            );
          }
          );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Log out'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.brown[900])
                ),
            ),
            TextButton.icon(
                onPressed: () => _showSettingsPanel,
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.brown[900])
                ),
            ),

          ]
        ),
        body: BrewList(),
      ),
    );
  }
}
