import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:price_predict_app/dynamic/models/auth_model.dart';

class AuthRepository {
  //INITIALIZATIONS
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // METHODS
  Future<User> getCurrentFirebaseUser() async {
    User currentUser;
    currentUser = _auth.currentUser;
    return currentUser;
  }

  // CHECK IF USER IS PRESENT OR NOT
  AuthModel _userFromFirebaseUser(User user) {
    if (user != null) {
      return AuthModel(uid: user.uid, email: user.email);
    } else {
      return null;
    }
  }

  // STATE MANAGEMENT THROUGH STREAM-PROVIDER
  Stream<AuthModel> get getUserForState {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //SIGN IN WITH GOOGLE
  Future<User> signInWithGoogle() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _signInAuthentication.accessToken,
        idToken: _signInAuthentication.idToken);

    User user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  //SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
  }

  //TO CONVERT CURRENT FIREBASE USER INTO AUTH MODEL
  Future<AuthModel> firebaseUserToAuthModel(User user) async {
    return AuthModel(uid: user.uid, email: user.email);
  }
}
