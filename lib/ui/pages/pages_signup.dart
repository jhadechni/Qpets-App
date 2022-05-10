import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/page_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../controllers/authentication_controller.dart';
import '../../domain/authentication.dart';


class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

  @override


  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
    void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
        // TODO: implement initState
    super.initState();
  }
  @override
  // ignore: non_constant_identifier_names


  
  String _Correo = '', _clave = '', _nombre='', _numero='',_confirmarclave='';
  Widget build(BuildContext context) {
    Authentication controller  = Get.find();
    AuthenticationController authentication = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () => Get.to(const LoginPage()),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Icon(Icons.arrow_back, size: 40),
                    )),
                const Text(
                  "Regístrate",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      _formField("Nombre", "",3),
                      _formField("Correo", "",1),
                      _formField("Número teléfonico", "1234567890",4),
                      _formField("Contraseña", "",2),
                      _formField("Confirmar contraseña", "",5),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MaterialButton(
                    
                    onPressed: () =>   comprueba(_nombre, _numero, _Correo, _clave, _confirmarclave,authentication,controller),
                    color: const Color(0xFF7F77C6),
                    minWidth: 280,
                    height: 60,
                    child: const Text(
                      "Regístrate",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formField(String placeholder, String hint, int op) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: placeholder,
        ),
        onChanged: (value) => setState(() {
         switch(op){
           case 1:
            _Correo = value;
            break;
            case 2:
            _clave = value;
            break;
            case 3:
            _nombre = value;
            break;
            case 4:
            _numero = value;
            break;
            case 5:
            _confirmarclave =value;
         }
        }),
      ),
    );
  }



 


  void comprueba(String nombre, String numero , String correo , String contra, String contra2,AuthenticationController authetication,Authentication controller){
    if(nombre!=''){
      if(isNumeric(numero)==true){
        if(contra==contra2){
          authetication.signUp(correo, contra,_numero,_nombre, context); 
          controller.signup(nombre, contra, numero, correo); 
         
          
          

        }else  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contraseñas no coinciden')));  

      }else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingrese numero nuevamente')));   
    }else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingrese usuario nuevamente')));  
  }
  
 bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}

}
