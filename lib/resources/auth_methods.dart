import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user.dart' as model;
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnapshot(snap);
  }

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        // Register user with Firebase Auth
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Create user object to store in Firestore
        model.User user = model.User(
          name: name,
          email: email,
        );

        // Store user data in Firestore
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        res = 'Success';
      } else {
        res = 'Please fill in all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'Success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Google Sign-In
  // Future<String> signInWithGoogle() async {
  //   String res = "Some error occurred";
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  //     if (googleUser != null && googleAuth != null) {
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       UserCredential userCredential = await _auth.signInWithCredential(credential);

  //       // Check if user exists in Firestore
  //       DocumentSnapshot snap = await _firestore.collection('users').doc(userCredential.user!.uid).get();

  //       if (!snap.exists) {
  //         // Create user object to store in Firestore
  //         model.User user = model.User(
  //           name: userCredential.user!.displayName!,
  //           email: userCredential.user!.email!,
  //         );

  //         // Store user data in Firestore
  //         await _firestore.collection('users').doc(userCredential.user!.uid).set(user.toJson());
  //       }

  //       res = 'Success';
  //     } else {
  //       res = 'Google Sign-In failed';
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }

  Future<String> signInWithGoogle() async {
  String res = "Some error occurred";
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Sign out any existing Google sessions
    await googleSignIn.signOut();

    // Start the sign-in process
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if (googleUser != null && googleAuth != null) {
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if user exists in Firestore
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();

      if (!snap.exists) {
        // Create user object to store in Firestore
        model.User user = model.User(
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        );

        // Store user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(user.toJson());
      }

      res = 'Success';
    } else {
      res = 'Google Sign-In failed';
    }
  } catch (err) {
    res = err.toString();
  }
  return res;
}


}
