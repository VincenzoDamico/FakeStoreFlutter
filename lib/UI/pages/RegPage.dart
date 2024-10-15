import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/Model.dart';
import '../../model/SharedPreferenceManager.dart';
import '../../model/object/User.dart';
import '../../model/support/LogInResult.dart';

class Regpage extends StatefulWidget {
  const Regpage({Key? key}) : super(key: key);

  @override
  State<Regpage> createState() => _RegState();
}

class _RegState extends State<Regpage> {
  // Definisco i controller dei campi di testo
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController capController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 800;

    // Definisco gli array di etichette, controller e icone
    List<String> labels = [
      "name",
      "surname",
      "phone",
      "email",
      "address",
      "city",
      "cap",
      "password"
    ];

    List<TextEditingController> controllers = [
      nameController,
      surnameController,
      phoneController,
      emailController,
      addressController,
      cityController,
      capController,
      passwordController
    ];

    List<IconData> icons = [
      Icons.person,
      Icons.person,
      Icons.phone,
      Icons.alternate_email,
      Icons.cabin,
      Icons.location_city,
      Icons.local_post_office,
      Icons.lock
    ];

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Column(
        children: [
          // Header con il logo e il pulsante di chiusura
          if (isMobile) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "assets/images/Logo.png",
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 40,
                      )),
                )
              ],
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 40,
                      )),
                )
              ],
            ),
          ],
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Container per la parte dei form di registrazione
                Expanded(
                  flex: isMobile ? 1 : 2,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Registration",
                            style: TextStyle(
                              color: Color(0xFF7941DA),
                              fontFamily: "Ubuntu",
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Ciclo for per creare i TextField dinamicamente
                          for (int i = 0; i < labels.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  autocorrect: true,
                                  style: const TextStyle(
                                    color: Color(0xFF7941DA),
                                    fontFamily: "Ubuntu",
                                  ),
                                  cursorColor: const Color(0xFF7941DA),
                                  controller: controllers[i],
                                  autofocus: false,
                                  minLines: 1,
                                  maxLines: 1,
                                  textAlignVertical: TextAlignVertical.center,
                                  obscureText: labels[i] == "password",
                                  decoration: InputDecoration(
                                    labelText: labels[i],
                                    labelStyle: const TextStyle(
                                      color: Color(0xFF7941DA),
                                    ),
                                    prefixIcon: Icon(
                                      icons[i],
                                      color: const Color(0xFF7941DA),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF7941DA),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(15),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          // Pulsante di invio
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (emailController.text.isEmpty ||
                                    nameController.text.isEmpty ||
                                    surnameController.text.isEmpty ||
                                    phoneController.text.isEmpty ||
                                    addressController.text.isEmpty ||
                                    cityController.text.isEmpty ||
                                    capController.text.isEmpty ||
                                    passwordController.text.isEmpty) {
                                  _mess('Compila tutti i campi per effettuare la registrazione.');
                                }if(_campiERR(phoneController.text,emailController.text,capController.text)){
                                  _mess("Errore nell'inserimento dell'email, del telofono o del cap");
                                }else{
                                  User? s=await Model.sharedInstance.addUser(new User(name: nameController.text.trim(), surname: surnameController.text.trim(), email: emailController.text.trim(), phone: phoneController.text.trim(), address: addressController.text.trim(), city: cityController.text.trim(), cap: capController.text.trim()), passwordController.text);
                                  if (s != null){
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.deepPurple,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                side: const BorderSide(
                                    color: Colors.deepPurple, width: 2),
                              ),
                              child: const Text("Sign up"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Immagine accanto al container nei dispositivi desktop
                if (!isMobile)
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            "assets/images/Logo.png",
                            width: MediaQuery.of(context).size.height / 2,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _campiERR(String p, String m, String c) {
    const regexEmail = r"^[-A-Za-z0-9._%&$+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$";
    const regexCell = r"^([\+][0-9][0-9])?[0-9][0-9][0-9][-\s\.]?[0-9][-\s\.]?[0-9][0-9][-\s\.]?[0-9][-\s\.]?[0-9][0-9][0-9]$";
    const regexCap = r"^\d{5}$";
      RegExp cellRegex = RegExp(regexCell);
      RegExp emailRegex = RegExp(regexEmail);
      RegExp capRegex = RegExp(regexCap);

      return !cellRegex.hasMatch(p.trim()) &&
          !emailRegex.hasMatch(m.trim()) &&
        !capRegex.hasMatch(c.trim());
    }

  void _mess(String mess) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: Text(mess),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}

