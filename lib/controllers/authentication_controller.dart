import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/bottom_navbar.dart';
import '../ui/pages/page_login.dart';

class AuthenticationController extends GetxController {
  Future<void> login(email, password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => const BottomNavBar());

      return Future.value();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not found.')));
        return Future.error("User not found");
        
      } else if (e.code == 'wrong-password') {
         ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('wrong-password.')));
        return Future.error("Wrong password");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email is not valid')));
        return Future.error('Email is not valid');
      }
    }
  }

  Future<void> agregarUsuario(
      String nombre, String numero, String correo, String contra,address,gender) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    final Map<String, String> users = HashMap();
    users.addAll({
      'Contraseña': contra,
      'Correo': correo,
      'Nombre': nombre,
      'Numero': numero,
      'Dirreción':address,
      'Sexo':gender
    });
    await collection.doc(getUid()).set(users);
  }

  Future<bool> signUp(
      email, password, numero, nombre,address,gender, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Get.to(() => const LoginPage());

      await agregarUsuario(nombre, numero, email, password,address,gender,);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password to weak.')));
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User already exist.')));

        return Future.error('The account already exists for that email.');
      }
    }
    return true;
  }

   Future<void> UpdateUsuario(
      String nombre, String numero, String Dirrecion, String Sexo) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    final Map<String, String> users = HashMap();
    users.addAll({
      'Sexo': Sexo,
      'Dirreción': Dirrecion,
      'Nombre': nombre,
      'Numero': numero
    });
    await collection.doc(getUid()).update(users);
    Get.to(const BottomNavBar());
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
