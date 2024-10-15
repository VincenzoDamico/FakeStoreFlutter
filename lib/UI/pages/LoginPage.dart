import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/UI/pages/RegPage.dart';

import '../../Provider/LogProvider.dart';
import '../../model/Model.dart';
import '../../model/SharedPreferenceManager.dart';
import '../../model/support/LogInResult.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginState();
}

class _LoginState extends State<Loginpage> {
/*  Future<bool> doLogin(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('Compila tutti i campi per effettuare il login.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
      return false;
    }

    Map<String, dynamic> reviewData = {
      'username': username,
      'password': password,
      'client_id': 'negozio',
      'grant_type': 'password'
    };
    String formData = reviewData.entries
        .map((e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
    Response response_login = await http.post(
      Uri.parse(
          'http://localhost:8080/realms/webApp/protocol/openid-connect/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: formData,
    );
    if (response_login.statusCode == 200) {
      String refresh_token = jsonDecode(response_login.body)['refresh_token'];
      SharedPreferences storage = SharedPreferenceManager.instance;
      storage.setString('refresh', refresh_token);
      return true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Errore'),
            content: Text('Username o password non corretta'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
    return false;
  }*/

  @override
  Widget build(BuildContext context) {
    final logprovider = LogProvider.of(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 800;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Column(
        children: [
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
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Colonna con il container bianco sporco e bordi arrotondati
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5), // Colore bianco sporco
                      borderRadius:
                          BorderRadius.circular(20), // Bordi arrotondati
                    ),
                    padding: EdgeInsets.all(20), // Aggiungi padding interno
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Welcome!!",
                              style: TextStyle(
                                color: Color(0xFF7941DA),
                                fontFamily: "Ubuntu",
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                // Grassetto
                                fontStyle: FontStyle.italic, // Corsivo
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              autocorrect: true,
                              style: const TextStyle(
                                  color: Color(0xFF7941DA),
                                  fontFamily: "Ubuntu"),
                              cursorColor: Color(0xFF7941DA),
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              controller: emailController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                labelText: "email",
                                labelStyle: TextStyle(
                                  color: Color(0xFF7941DA),
                                ),
                                fillColor: Color(0xFF7941DA),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF7941DA),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF7941DA), width: 10.0),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              autocorrect: true,
                              style: const TextStyle(
                                  color: Color(0xFF7941DA),
                                  fontFamily: "Ubuntu"),
                              cursorColor: Color(0xFF7941DA),
                              controller: passwordController,
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "password",
                                labelStyle: TextStyle(
                                  color: Color(0xFF7941DA),
                                ),
                                fillColor: Color(0xFF7941DA),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF7941DA),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF7941DA), width: 10.0),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                alignLabelWithHint: true,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (emailController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Errore'),
                                            content: Text(
                                                'Compila tutti i campi per effettuare il login.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  } else {
                                    LogInResult result =
                                        await Model.sharedInstance.logIn(
                                            emailController.text,
                                            passwordController.text);
                                    print(result);
                                    if (result == LogInResult.logged) {
                                      logprovider.LogIn();
                                      Navigator.pop(context);
                                    } else if (result ==
                                        LogInResult.error_wrong_credentials) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Errore'),
                                              content: Text(
                                                  'Username o password non corretta'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    } else if (result ==
                                        LogInResult.error_not_fully_setupped) {
                                    } else {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Errore'),
                                              content: Text(
                                                  'Errore sconosciuto non è stato possibile fare il login'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.deepPurple,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: BorderSide(
                                      color: Colors.deepPurple, width: 2),
                                ),
                                child: const Text("Login"),
                              ),
                              SizedBox(width: 40),
                              ElevatedButton(
                                onPressed: () {  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Regpage()));},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.deepPurple,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: BorderSide(
                                      color: Colors.deepPurple, width: 2),
                                ),
                                child: const Text("Sign up"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Immagine spostata accanto al container
              if (!isMobile) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
              ]
            ],
          ),
        ],
      ),
    );
  }
}
