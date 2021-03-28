import 'package:brew_crew/modules/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  DatabaseService({ this.uid });

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.data());
      return Brew(
          name: doc.data()['name'] ?? '',
          strength: doc.data()['strength'] ?? 0,
          sugar: doc.data()['sugar'] ?? '0'
      );
    }).toList();

  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

}