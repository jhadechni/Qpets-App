import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qpets_app/utils/ourPurple.dart';
import '../shared/bottom_navbar.dart';
import '../ui/pages/page_login.dart';

class AuthenticationController extends GetxController {
  Future<void> login(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => const BottomNavBar());

      return Future.value();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Information", "User not found!",
            icon: Icon(FontAwesomeIcons.paw),
            backgroundColor: Palette.ourPurple);
        return Future.error("User not found");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Information", "Wrong password!",
            icon: Icon(FontAwesomeIcons.paw),
            backgroundColor: Palette.ourPurple);
        return Future.error("Wrong password");
      } else {
        Get.snackbar("Information", "Not valid email!",
            icon: Icon(FontAwesomeIcons.paw),
            backgroundColor: Palette.ourPurple);
      }
    }
  }

  Future<void> agregarUsuario(String nombre, String numero, String correo,
      String contra, String address, String sexo) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    final Map<String, String> users = HashMap();
    users.addAll({
      'Contraseña': contra,
      'Correo': correo,
      'Nombre': nombre,
      'Numero': numero,
      "Direccion": address,
      "Sexo": sexo
    });
    await collection.doc(getUid()).set(users);
  }

  Future<bool> signUp(String email, String password, String numero,
      String nombre, String address, String sexo, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Get.to(() => const LoginPage());

      await agregarUsuario(nombre, numero, email, password, address, sexo);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Information", "The password provided is too weak.",
            icon: Icon(FontAwesomeIcons.paw),
            backgroundColor: Palette.ourPurple);
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Information", "User already exist!",
            icon: Icon(FontAwesomeIcons.paw),
            backgroundColor: Palette.ourPurple);
        return Future.error('The account already exists for that email.');
      }
    }
    return true;
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error("Logout error");
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return email;
  }

  String getUid() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }
}
