 
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/pages/page_login.dart';


class AuthenticationController extends GetxController {
  Future<void> login(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          
            

          
      return Future.value();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error("User not found");
      } else if (e.code == 'wrong-password') {
        return Future.error("Wrong password");
      }
    }
  }

 void agregarUsuario(String nombre, String numero , String correo , String contra){
    CollectionReference collection = FirebaseFirestore.instance.collection('users');
     final Map<String , String> users = HashMap();
     users.addAll({'Contraseña':contra, 'Correo' : correo,'Nombre':nombre,'Numero':numero });
     // collection.doc('users').set(users);
     print(users);
    collection.add(users);

  }
 Future<void> signUp(email, password,numero,nombre, BuildContext context) async {

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
         
          
          
          agregarUsuario(nombre, numero, email, password);
         
        
      
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contraseña demasiado debil')));
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La cuenta ya.')));
        
        return Future.error('The account already exists for that email.');
      }
    }
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
