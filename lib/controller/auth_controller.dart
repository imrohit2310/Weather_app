import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:weatherapp/screens/login_screen.dart';

import '../screens/home_screen.dart';
import '../utils/custom_colors.dart';
import 'package:weatherapp/model/user.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
        );

        await firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
      } else {
        Get.snackbar("Error Creating Account", 'Please enter all tha fields',
            backgroundColor: CustomColors.firstGradientColor);
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error Creating Account",
        backgroundColor: CustomColors.firstGradientColor,
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('login successful');
      }
    } catch (e) {
      Get.snackbar("Failed to login", e.toString(),
          backgroundColor: CustomColors.firstGradientColor);
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
