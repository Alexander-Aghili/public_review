
import 'package:cloud_firestore/cloud_firestore.dart';

//Used after they are fully initialized
class User {
  final String id;
  final String username;
  final String profilepic;
  final String email;
  final String bio;
  final String politicalParty;

  User({
    required this.id, 
    required this.username, 
    required this.email, 
    required this.profilepic,
    required this.bio,
    required this.politicalParty,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc['email'],
      username: doc['username'],
      profilepic: doc['url'],
      bio: doc['bio'],
      politicalParty: doc['politicalParty'],
    );
  }
  
}
