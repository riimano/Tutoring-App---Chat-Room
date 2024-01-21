import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instance of auth to check if we are logged in or not
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//instance of firestor
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String passowrd) async {
    try {
      //sign it

      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: passowrd,
      );

      /* add a new document for the user in
      users collections of it doesnt exist */
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      return userCredential;
    }
    //   Future<void> saveUserInfoToFirebase(
    //     String userId, String userName, String email) async {
    //   try {
    //     await FirebaseFirestore.instance.collection('users').doc(userId).set(
    //       {
    //         'username': userName,
    //         'email': email,
    //         'userLocation': null,
    //       },
    //     );
    //   } catch (e) {
    //     throw AuthException(e.toString());
    //   }
    // }
    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // create a new user
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      /* after creating the user, 
      create a new document for the user in the
      users collections*/

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  // sign user out

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
