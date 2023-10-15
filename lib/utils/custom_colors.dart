import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';

class CustomColors {
  CustomColors._();
  static const dividerLine = Color(0xffE4E4EE);
  static const cardColor = Color(0xffE9ECF1);
  static const textColorBlack = Color(0xff171717);
  static const firstGradientColor = Color(0xff408ADE);
  static const secondGradientColor = Color(0xff5286CD);
}


var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;


var authController = AuthController.instance;