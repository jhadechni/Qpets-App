import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/page_login.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  @override
  Widget build(BuildContext context) {
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
                      _formField("Nombre", ""),
                      _formField("Correo", ""),
                      _formField("Número teléfonico", "1234567890"),
                      _formField("Contraseña", ""),
                      _formField("Confirmar contraseña", ""),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MaterialButton(
                    onPressed: () => Get.to(const LoginPage()),
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

  Widget _formField(String placeholder, String hint) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: placeholder,
        ),
      ),
    );
  }
}