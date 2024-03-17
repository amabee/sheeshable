import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class StringsEn {
  static const String signUp = 'Sign Up';
  static const String getHelp = 'Get help';
}

class StringsAr {
  static const String signUp = 'سجل';
  static const String getHelp = 'احصل على مساعدة';
}

class StringsIt {
  static const String signUp = 'Iscriviti';
  static const String getHelp = 'Ottenere assistenza';
}

class StringsFr {
  static const String signUp = 'S\'inscrire';
  static const String getHelp = 'Obtenir de l\'aide';
}

class _SignUpState extends State<SignUp> {
  String dropdownValue = 'English';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int buttonColor = 0xff26A9FF;

  bool inputTextNotNull = false;

  @override
  Widget build(BuildContext context) {
    double deviseWidth = MediaQuery.of(context).size.width;
    String signUpText = '';
    String getHelpText = '';

    switch (dropdownValue) {
      case 'English':
        signUpText = StringsEn.signUp;
        getHelpText = StringsEn.getHelp;
        break;
      case 'Arabic':
        signUpText = StringsAr.signUp;
        getHelpText = StringsAr.getHelp;
        break;
      case 'Italian':
        signUpText = StringsIt.signUp;
        getHelpText = StringsIt.getHelp;
        break;
      case 'French':
        signUpText = StringsFr.signUp;
        getHelpText = StringsFr.getHelp;
        break;
      default:
        signUpText = StringsEn.signUp;
        getHelpText = StringsEn.getHelp;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white70,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 10,
                    style: const TextStyle(color: Colors.black54),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      }
                    },
                    items: <String>['English', 'Arabic', 'Italian', 'French']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/name_logo.png',
                      height: deviseWidth * .30,
                    ),
                    SizedBox(
                      height: deviseWidth * .05,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: fullNameController,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Full Name',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: usernameController,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Username',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: emailController,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    inputTextNotNull
                        ? GestureDetector(
                            onLongPressStart: (s) {
                              setState(() {
                                buttonColor = 0xff78C9FF;
                              });
                            },
                            onLongPressEnd: (s) {
                              setState(() {
                                buttonColor = 0xff26A9FF;
                              });
                            },
                            onTap: () {
                              print('Sign Up');
                            },
                            child: Container(
                              width: deviseWidth * .90,
                              height: deviseWidth * .14,
                              decoration: BoxDecoration(
                                color: Color(buttonColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Center(
                                child: Text(
                                  signUpText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviseWidth * .040,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: deviseWidth * .90,
                            height: deviseWidth * .14,
                            decoration: const BoxDecoration(
                              color: Color(0xff78C9FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                              child: Text(
                                signUpText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviseWidth * .040,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: deviseWidth * .035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getHelpText,
                          style: TextStyle(
                            fontSize: deviseWidth * .045,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Get help');
                          },
                          child: Text(
                            ' Get help',
                            style: TextStyle(
                              fontSize: deviseWidth * .045,
                              color: const Color(0xff002588),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: deviseWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: deviseWidth,
                        height: 1,
                        color: const Color(0xffA2A2A2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: deviseWidth * .045,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                             Navigator.pop(context);
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: const Color(0xff00258B),
                                fontSize: deviseWidth * .045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
