import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LoginUI());
}

class LoginUI extends StatelessWidget {

  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login UI',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final blueColor = const Color(0XFF5e92f3);
  final yellowColor = const Color(0XFFfdd835);

  late TapGestureRecognizer _tapGestureRecognizer;
  late bool _showSignIn;

  @override
  void initState() {
    super.initState();
    _showSignIn = true;
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _showSignIn = !_showSignIn;
          print("Hello");
        });
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            buildBackgroundTopCircle(),
            buildBackgroundBottomCircle(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
                  child: Column(
                    children: [
                      Text(
                        _showSignIn ? "SIGN IN" : "CREATE ACCOUNT",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      buildAvatarContainer(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutBack,
                        height: _showSignIn ? 240 : 400,
                        margin: EdgeInsets.only(top: _showSignIn ? 40 : 30),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: const Offset(0, 1),
                              )
                            ]),
                        child: SingleChildScrollView(
                          child: _showSignIn
                              ? buildSignInTextFieldSection()
                              : buildSignUpTextFieldSection(),
                        ),
                      ),
                      _showSignIn
                          ? buildSingInBottomSection()
                          : buildSingUpBottomSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Container buildSingInBottomSection() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print("Forget Password");
            },
            child: Text(
              "Forget Password ?",
              style: TextStyle(
                color: blueColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            // color: blueColor,
            // elevation: 10,
            // padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_right,
                  color: yellowColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          RichText(
            text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Create an Account",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
          )
        ],
      ),
    );
  }

  Container buildSingUpBottomSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ElevatedButton(
            // color: yellowColor,
            // elevation: 10,
            // padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "SUBMIT",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          RichText(
            text: TextSpan(
                text: "Already have an account? ",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Sing in",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
          )
        ],
      ),
    );
  }

  Column buildSignInTextFieldSection() {
    return Column(
      children: [
        buildTextField("EMAIL ADDRESS", "test123@gmail.com", false),
        const SizedBox(
          height: 30,
        ),
        buildTextField("PASSWORD", "*******", true),
      ],
    );
  }

  Column buildSignUpTextFieldSection() {
    return Column(
      children: [
        buildTextField("USERNAME", "test123", false),
        const SizedBox(
          height: 20,
        ),
        buildTextField("EMAIL ADDRESS", "test123", false),
        const SizedBox(
          height: 20,
        ),
        buildTextField("MOBILE NUMBER", "test123", false),
        const SizedBox(
          height: 20,
        ),
        buildTextField("PASSWORD", "*******", true),
      ],
    );
  }

  Container buildTextField(
      String labelText, String placeholder, bool isPassword) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(color: blueColor, fontSize: 12),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: placeholder,
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ))
        ],
      ),
    );
  }

  Container buildAvatarContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: 130,
      height: 130,
      decoration: BoxDecoration(
          color: _showSignIn ? yellowColor : Colors.grey[800],
          borderRadius: BorderRadius.circular(65),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 20,
            ),
          ]),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              left: 1.0,
              top: 3.0,
              child: Icon(
                Icons.person_outline,
                size: 60,
                color: Colors.black.withOpacity(.1),
              ),
            ),
            const Icon(
              Icons.person_outline,
              size: 60,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildBackgroundBottomCircle() {
    return Positioned(
      top: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.width,
      right: MediaQuery.of(context).size.width / 2,
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: blueColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width,
            )),
      ),
    );
  }

  Positioned buildBackgroundTopCircle() {
    return Positioned(
      top: 0,
      child: Transform.translate(
        offset: Offset(0.0, -MediaQuery.of(context).size.width / 1.3),
        child: Transform.scale(
          scale: 1.35,
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: _showSignIn ? Colors.grey[800] : blueColor,
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width,
                )),
          ),
        ),
      ),
    );
  }
}
