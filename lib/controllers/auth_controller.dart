import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/service/services.dart';
import '../routes.dart';
import '../view/widgets/public/snackbar.dart';

class AuthController extends GetxController {
  bool visible = true;
  bool check = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var displayUserName = ''.obs;
  var displayUserEmail = ''.obs;
  var displayUserPhoto = ''.obs;
  bool isLoggedIn = false;
  var isLoading = false.obs;
  final MyService myservice = Get.find();
  final key = 'isLoggedIn';
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController name;
  late TextEditingController chat;
  var isShown = false.obs;
  User? get userProfile => auth.currentUser;
  List messages = [].obs;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    chat = TextEditingController();
    if (userProfile != null) {
      displayUserName.value = userProfile!.displayName!;
      displayUserEmail.value = userProfile!.email!;
    }
    // getMessages();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    chat.dispose();
    super.dispose();
  }

  // getMessages() async {
  //   await for (var snapShot in firestore.collection('messages').snapshots()) {
  //     for (var message in snapShot.docs) {
  //       // print(message.data());
  //     }
  //   }
  // }

  showPassword() {
    isShown.value = !isShown.value;
    update();
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        displayUserName.value = name;
        displayUserEmail.value = email;
        auth.currentUser!.updateDisplayName(displayUserName.value);
      });
      update();
      MySnackBar.snack('', 'User created successfully');
      Get.offNamed(AppRoutes.chatScreen);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        MySnackBar.snack(
          error.code,
          'The password provided is too weak.',
        );
      } else if (error.code == 'email-already-in-use') {
        MySnackBar.snack(
          error.code,
          'The account already exists for that email.',
        );
      }
    } catch (error) {
      MySnackBar.snack('', 'Check your internet');
    }
    isLoading(false);
  }

  logInWithEmailAndPassword({
    required String password,
    required String email,
  }) async {
    isLoading(true);
    update();
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => {
              if (auth.currentUser == null)
                {displayUserName.value = auth.currentUser!.displayName!}
            },
          );
      update();
      MySnackBar.snack('', 'Logged in successfully $displayUserName');
      Get.offNamed(AppRoutes.chatScreen);
      displayUserEmail.value = email;
      isLoggedIn = true;
      myservice.sharedPreferences.setBool(key, isLoggedIn = true);
      isLoading(false);
      update();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        MySnackBar.snack(error.code, 'No user found for that email.');
      } else if (error.code == 'wrong-password') {
        MySnackBar.snack(error.code, 'Wrong password provided for that user.');
      } else {
        MySnackBar.snack('', 'user not found');
      }
    }
    isLoading(false);
    update();
  }

  Future<void> forgetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      update();
      MySnackBar.snack(
        '',
        'check your email',
      );
      Get.back();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        MySnackBar.snack(error.code, 'No user found for that email.');
      } else if (error.code == 'wrong-password') {
        MySnackBar.snack(error.code, 'Wrong password provided for that user.');
      } else {
        MySnackBar.snack('', 'user not found');
      }
    }
  }

  Future<void> logOut() async {
    try {
      await auth.signOut();

      displayUserName.value = '';
      displayUserPhoto.value = '';
      displayUserEmail.value = '';
      update();
      MySnackBar.snack('', 'Logged Out $displayUserName');
      isLoggedIn = false;
      Get.offNamed(AppRoutes.loginScreen);
      myservice.sharedPreferences.clear();
    } catch (error) {
      MySnackBar.snack('', 'Check your internet');
    }
  }

  // Future<void> signUpWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     displayUserName.value = googleUser!.displayName!;
  //     displayUserPhoto.value = googleUser.photoUrl!;
  //     displayUserEmail.value = googleUser.email;
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken);
  //     await auth.signInWithCredential(credential);
  //     update();
  //     isLoggedIn = true;
  //     Get.offNamed(AppAppRoutes.chatScreen);
  //     myservice.write(key, isLoggedIn = true);
  //   } catch (error) {
  //     MySnackBar.snack('', 'Check your internet');
  //   }
  // }

  // Future<void> signUpWithFaceBook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   if (loginResult.status == LoginStatus.success) {
  //     final data = await FacebookAuth.instance.getUserData();
  //     facebookModel = FacebookModel.fromJson(data);
  //     MySnackBar.snack('', 'Hello $facebookModel?.name');
  //     isLoggedIn = true;
  //     myservice.write(key, isLoggedIn = true);
  //   }
  // }
}
