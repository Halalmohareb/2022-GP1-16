import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:Dhyaa/globalWidgets/appbars/appbar1.dart';
import 'package:Dhyaa/globalWidgets/common_functions/common_function.dart';
import 'package:Dhyaa/globalWidgets/sizedBoxWidget/sized_box_widget.dart';
import 'package:Dhyaa/globalWidgets/textWidget/text_widget.dart';
import 'package:Dhyaa/provider/auth_provider.dart';
import 'package:Dhyaa/responsiveBloc/size_config.dart';
import 'package:Dhyaa/screens/homeScreen/home_screen.dart';
import 'package:Dhyaa/screens/signinMethodScreen/createAccount/create_account.dart';
import 'package:Dhyaa/theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final tutorEmail = TextEditingController();
  final tutorPassword = TextEditingController();
  String tutorErrorTextEmail = '';
  bool tutorEmailValid = false;
  String tutorErrorTextPassword = '';
  bool tutorPasswordValid = false;
  bool tutorAllFieldsValid = false;

  final studentEmail = TextEditingController();
  final studentPassword = TextEditingController();
  String studentErrorTextEmail = '';
  bool studentEmailValid = false;
  String studentErrorTextPassword = '';
  bool studentPasswordValid = false;
  bool studentAllFieldsValid = false;

  final adminEmail = TextEditingController();
  final adminPassword = TextEditingController();
  String adminErrorTextEmail = '';
  bool adminEmailValid = false;
  String adminErrorTextPassword = '';
  bool adminPasswordValid = false;
  bool adminAllFieldsValid = false;

  bool tutorSelected = true;
  bool studentSelected = false;
  bool adminSelected = false;
  bool showTutorPassword = false;
  bool showStudentPassword = false;
  bool showAdminPassword = false;

  void dispose() {
    tutorEmail.dispose();
    tutorPassword.dispose();
    studentEmail.dispose();
    studentPassword.dispose();
    adminEmail.dispose();
    adminPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = SizeConfig.widthMultiplier;
    final authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.appBackgroundColor,
        appBar: appBar1('????????????', screenWidth, context),
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 8).copyWith(top: 0, bottom: 0),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/DhyaaLogo.png',
                        height: screenWidth * 30,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: screenWidth * 9,
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: screenWidth * 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.mainColor),
                            borderRadius: BorderRadius.circular(screenWidth),
                          ),
                          child: Row(children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tutorSelected = true;
                                  studentSelected = false;
                                  adminSelected = false;
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  color: tutorSelected
                                      ? theme.blueColor
                                      : theme.whiteColor,
                                  child: text(
                                      '????????',
                                      screenWidth * 3.2,
                                      tutorSelected
                                          ? theme.whiteColor
                                          : theme.blueColor)),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tutorSelected = false;
                                  studentSelected = true;
                                  adminSelected = false;
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  color: studentSelected
                                      ? theme.blueColor
                                      : theme.whiteColor,
                                  child: text(
                                      '????????',
                                      screenWidth * 3.2,
                                      studentSelected
                                          ? theme.whiteColor
                                          : theme.blueColor)),
                            )),
                            /*Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tutorSelected = false;
                                  studentSelected = false;
                                  adminSelected = true;
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  color: adminSelected
                                      ? theme.blueColor
                                      : theme.whiteColor,
                                  child: text(
                                      '??????????',
                                      screenWidth * 3.2,
                                      adminSelected
                                          ? theme.whiteColor
                                          : theme.blueColor)),
                            ))*/
                          ])),
                      tutorSelected
                          ? tutorEmailPassword(screenWidth)
                          : studentSelected
                              ? studentEmailPassword(screenWidth)
                              : adminSelected
                                  ? adminEmailPassword(screenWidth)
                                  : SizedBox(),
                      sizedBox(height: screenWidth * 4),
                      authProvider.isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      theme.mainColor)),
                            )
                          : GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                if (tutorSelected) {
                                  if (tutorAllFieldsValid) {
                                    await authProvider.handleSignInEmail(
                                        context,
                                        tutorEmail.text,
                                        tutorPassword.text,
                                        "Tutor");

                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => HomeScreen(
                                    //           title: '???????????? Tutor',
                                    //         )));
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "???????? ???? ?????????? ???????????? ???????????????????? ?????????? ???????? ???????? ????????",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: theme.appBackgroundColor,
                                      textColor: theme.darkTextColor,
                                      fontSize: screenWidth * 3,
                                    );
                                  }
                                } else if (studentSelected) {
                                  if (studentAllFieldsValid) {
                                    await authProvider.handleSignInEmail(
                                        context,
                                        studentEmail.text,
                                        studentPassword.text,
                                        "Student");

                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => HomeScreen(
                                    //           title: '???????????? Student',
                                    //         )));
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "???????? ???? ?????????? ???????????? ???????????????????? ?????????? ???????? ???????? ????????",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: theme.appBackgroundColor,
                                      textColor: theme.darkTextColor,
                                      fontSize: screenWidth * 3,
                                    );
                                  }
                                } else if (adminSelected) {
                                  if (adminAllFieldsValid) {
                                    await authProvider.handleSignInEmail(
                                        context,
                                        adminEmail.text,
                                        adminPassword.text,
                                        "Admin");
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => HomeScreen(
                                    //           title: '???????????? Admin',
                                    //         )));
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "???????? ???? ?????????? ???????????? ???????????????????? ?????????? ???????? ???????? ????????",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: theme.appBackgroundColor,
                                      textColor: theme.darkTextColor,
                                      fontSize: screenWidth * 3,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                          vertical: screenWidth * 2)
                                      .copyWith(bottom: screenWidth),
                                  padding: EdgeInsets.all(screenWidth * 4.3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 50),
                                      color: theme.blueColor),
                                  child: text('?????????? ????????????', screenWidth * 3.4,
                                      theme.whiteColor)),
                            ),
                      sizedBox(height: screenWidth * 40),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: screenWidth * 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text('?????? ???? ?????? ???????? ???????? ???? ??????  ',
                                  screenWidth * 3.1, theme.lightTextColor),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CreateAccountScreen()));
                                },
                                child: text('?????????? ????????', screenWidth * 3.2,
                                    theme.mainColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
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

  Widget tutorEmailPassword(screenWidth) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        sizedBox(height: screenWidth * 4),
        Row(
          children: [
            text('???????????? ????????????????????', screenWidth * 3, theme.lightTextColor,
                fontWeight: FontWeight.w500),
          ],
        ),
        SizedBox(height: screenWidth * 3),
        SizedBox(
          height: screenWidth * 12.5,
          width: double.infinity,
          child: TextFormField(
            controller: tutorEmail,
            onChanged: (value) {
              setState(() {
                if (tutorEmail.text.length > 0 &&
                    // (tutorEmail.text.contains('@gmail.com') ||
                    //     tutorEmail.text.contains('@hotmail.com') ||
                    //     tutorEmail.text.contains('@yahoo.com'))
                    isEmail(value) &&
                    !tutorEmail.text.contains(' ')) {
                  tutorEmailValid = true;
                  tutorErrorTextEmail = '';
                  if (tutorPasswordValid && tutorEmailValid) {
                    tutorAllFieldsValid = true;
                  }
                } else {
                  tutorErrorTextEmail = '???????????? ???????????????????? ???????????? ?????? ????????';
                  if (tutorEmail.text.contains(' ')) {
                    tutorErrorTextEmail =
                        '?????? ???? ?????????????? ???????????? ???????????????????? ?????? ????????????';
                  }
                  tutorEmailValid = false;
                  tutorAllFieldsValid = false;
                }
              });
            },
            style: textStyle(screenWidth * 3.7, theme.mainColor),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 4, vertical: screenWidth * 4),
              hintText: 'abc@domain.com',
              hintStyle: textStyle(screenWidth * 3.3, theme.lightTextColor),
              filled: true,
              fillColor: Colors.white24,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide:
                      BorderSide(width: .3, color: theme.lightTextColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide: BorderSide(
                      width: .6,
                      color: !tutorEmailValid
                          ? theme.redColor
                          : theme.yellowColor)),
            ),
          ),
        ),
        tutorEmail.text.length == 0 || tutorEmailValid
            ? sizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 1, top: screenWidth * 1),
                child: Row(
                  children: [
                    text(
                        tutorErrorTextEmail, screenWidth * 2.7, theme.redColor),
                  ],
                ),
              ),
        sizedBox(height: screenWidth * 4),
        Row(
          children: [
            text('???????? ????????????', screenWidth * 3, theme.lightTextColor,
                fontWeight: FontWeight.w500),
          ],
        ),
        sizedBox(height: screenWidth * 3),
        SizedBox(
          height: screenWidth * 12.5,
          width: double.infinity,
          child: TextFormField(
            controller: tutorPassword,
            onSaved: (value) {
              if (tutorPassword.text.length < 7) {
                tutorErrorTextPassword = '';
                // if (tutorPassword.text.contains(' ')) {
                //   tutorErrorTextPassword =
                //       'Password should not contain blank spaces';
                // }
                // tutorPasswordValid = false;
                // tutorAllFieldsValid = false;
              }
            },
            onChanged: (value) {
              setState(() {
                if (tutorPassword.text.length > 7 &&
                    !tutorPassword.text.contains(' ')) {
                  tutorPasswordValid = true;
                  tutorErrorTextPassword = '';
                  if (tutorPasswordValid && tutorEmailValid) {
                    tutorAllFieldsValid = true;
                  }
                }
                // else  if(tutorPassword.text.length < 7){
                //   tutorErrorTextPassword =
                //       'Password must be atleast 8 characters long';
                // if (tutorPassword.text.contains(' ')) {
                //   tutorErrorTextPassword =
                //       'Password should not contain blank spaces';
                // }
                // tutorPasswordValid = false;
                // tutorAllFieldsValid = false;
                // }
              });
            },
            obscureText: showTutorPassword ? false : true,
            style: textStyle(screenWidth * 3.7, theme.mainColor),
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showTutorPassword = !showTutorPassword;
                  });
                },
                child: Icon(
                  showTutorPassword ? Icons.visibility : Icons.visibility_off,
                  color: theme.lightTextColor,
                  size: screenWidth * 5,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 4, vertical: screenWidth * 4),
              hintText: '********',
              hintStyle: textStyle(screenWidth * 3.3, theme.lightTextColor),
              filled: true,
              fillColor: Colors.white24,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide:
                      BorderSide(width: .3, color: theme.lightTextColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide: BorderSide(
                      width: .6,
                      color: !tutorPasswordValid
                          ? theme.redColor
                          : theme.yellowColor)),
            ),
          ),
        ),
        tutorPassword.text.length == 0 || tutorPasswordValid
            ? sizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 1, top: screenWidth * 1),
                child: Row(
                  children: [
                    text(tutorErrorTextPassword, screenWidth * 2.7,
                        theme.redColor),
                  ],
                ),
              ),
        sizedBox(height: screenWidth * 4),
      ]),
    );
  }

  Widget studentEmailPassword(screenWidth) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        sizedBox(height: screenWidth * 4),
        Row(
          children: [
            text('???????????? ????????????????????', screenWidth * 3, theme.lightTextColor,
                fontWeight: FontWeight.w500),
          ],
        ),
        SizedBox(height: screenWidth * 3),
        SizedBox(
          height: screenWidth * 12.5,
          width: double.infinity,
          child: TextFormField(
            controller: studentEmail,
            onChanged: (value) {
              setState(() {
                if (studentEmail.text.length > 0 &&
                    isEmail(value)
                    // (studentEmail.text.contains('@gmail.com') ||
                    //     studentEmail.text.contains('@hotmail.com') ||
                    //     studentEmail.text.contains('@yahoo.com'))
                    &&
                    !studentEmail.text.contains(' ')) {
                  studentEmailValid = true;
                  studentErrorTextEmail = '';
                  if (studentPasswordValid && studentEmailValid) {
                    studentAllFieldsValid = true;
                  }
                } else {
                  studentErrorTextEmail = '???????????? ???????????????????? ???????????? ?????? ????????';
                  if (studentEmail.text.contains(' ')) {
                    studentErrorTextEmail =
                        '?????? ???? ???? ?????????? ???????????? ???????????????????? ???????????? ?????? ????????????';
                  }
                  studentEmailValid = false;
                  studentAllFieldsValid = false;
                }
              });
            },
            style: textStyle(screenWidth * 3.7, theme.mainColor),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 4, vertical: screenWidth * 4),
              hintText: 'abc@domain.com',
              hintStyle: textStyle(screenWidth * 3.3, theme.lightTextColor),
              filled: true,
              fillColor: Colors.white24,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide:
                      BorderSide(width: .3, color: theme.lightTextColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide: BorderSide(
                      width: .6,
                      color: !studentEmailValid
                          ? theme.redColor
                          : theme.yellowColor)),
            ),
          ),
        ),
        studentEmail.text.length == 0 || studentEmailValid
            ? sizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 1, top: screenWidth * 1),
                child: Row(
                  children: [
                    text(studentErrorTextEmail, screenWidth * 2.7,
                        theme.redColor),
                  ],
                ),
              ),
        sizedBox(height: screenWidth * 4),
        Row(
          children: [
            text('???????? ????????????', screenWidth * 3, theme.lightTextColor,
                fontWeight: FontWeight.w500),
          ],
        ),
        sizedBox(height: screenWidth * 3),
        SizedBox(
          height: screenWidth * 12.5,
          width: double.infinity,
          child: TextFormField(
            controller: studentPassword,
            onSaved: (value) {
              if (studentPassword.text.length < 7) {
                studentErrorTextPassword =
                    '?????? ???? ?????????? ???????? ???????????? ?????? 8 ?????????? ???? ????????';
                // if (tutorPassword.text.contains(' ')) {
                //   tutorErrorTextPassword =
                //       'Password should not contain blank spaces';
                // }
                // tutorPasswordValid = false;
                // tutorAllFieldsValid = false;
              }
            },
            onChanged: (value) {
              setState(() {
                if (studentPassword.text.length > 7 &&
                    !studentPassword.text.contains(' ')) {
                  studentPasswordValid = true;
                  studentErrorTextPassword = '';
                  if (studentPasswordValid && studentEmailValid) {
                    studentAllFieldsValid = true;
                  }
                }
                // else {
                //   studentErrorTextPassword =
                //       'Password must be atleast 8 characters long';
                //   if (studentPassword.text.contains(' ')) {
                //     studentErrorTextPassword =
                //         'Password should not contain blank spaces';
                //   }
                //   studentPasswordValid = false;
                //   studentAllFieldsValid = false;
                // }
              });
            },
            obscureText: showStudentPassword ? false : true,
            style: textStyle(screenWidth * 3.7, theme.mainColor),
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showStudentPassword = !showStudentPassword;
                  });
                },
                child: Icon(
                  showStudentPassword ? Icons.visibility : Icons.visibility_off,
                  color: theme.lightTextColor,
                  size: screenWidth * 5,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 4, vertical: screenWidth * 4),
              hintText: '********',
              hintStyle: textStyle(screenWidth * 3.3, theme.lightTextColor),
              filled: true,
              fillColor: Colors.white24,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide:
                      BorderSide(width: .3, color: theme.lightTextColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide: BorderSide(
                      width: .6,
                      color: !studentPasswordValid
                          ? theme.redColor
                          : theme.yellowColor)),
            ),
          ),
        ),
        studentPassword.text.length == 0 || studentPasswordValid
            ? sizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 1, top: screenWidth * 1),
                child: Row(
                  children: [
                    text(studentErrorTextPassword, screenWidth * 2.7,
                        theme.redColor),
                  ],
                ),
              ),
        sizedBox(height: screenWidth * 4),
      ]),
    );
  }

  Widget adminEmailPassword(screenWidth) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        sizedBox(height: screenWidth * 4),
        Row(
          children: [
            text('???????????? ????????????????????', screenWidth * 3, theme.lightTextColor,
                fontWeight: FontWeight.w500),
          ],
        ),
        SizedBox(height: screenWidth * 3),
        SizedBox(
          height: screenWidth * 12.5,
          width: double.infinity,
          child: TextFormField(
            controller: adminEmail,
            onChanged: (value) {
              setState(() {
                if (adminEmail.text.length > 0 &&
                    isEmail(value)
                    // (adminEmail.text.contains('@gmail.com') ||
                    //     adminEmail.text.contains('@hotmail.com') ||
                    //     adminEmail.text.contains('@yahoo.com'))
                    &&
                    !adminEmail.text.contains(' ')) {
                  adminEmailValid = true;
                  adminErrorTextEmail = '';
                  if (adminPasswordValid && adminEmailValid) {
                    adminAllFieldsValid = true;
                  }
                } else {
                  adminErrorTextEmail = '???????????? ???????????????????? ???????????? ?????? ????????';
                  if (adminEmail.text.contains(' ')) {
                    adminErrorTextEmail =
                        '?????? ???? ?????????????? ???????????? ???????????????????? ?????? ????????????';
                  }
                  adminEmailValid = false;
                  adminAllFieldsValid = false;
                }
              });
            },
            style: textStyle(screenWidth * 3.7, theme.mainColor),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 4, vertical: screenWidth * 4),
              hintText: 'abc@domain.com',
              hintStyle: textStyle(screenWidth * 3.3, theme.lightTextColor),
              filled: true,
              fillColor: Colors.white24,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide:
                      BorderSide(width: .3, color: theme.lightTextColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide: BorderSide(
                      width: .6,
                      color: !adminEmailValid
                          ? theme.redColor
                          : theme.yellowColor)),
            ),
          ),
        ),
        adminEmail.text.length == 0 || adminEmailValid
            ? sizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 1, top: screenWidth * 1),
                child: Row(
                  children: [
                    text(
                        adminErrorTextEmail, screenWidth * 2.7, theme.redColor),
                  ],
                ),
              ),
        sizedBox(height: screenWidth * 4),
        Row(
          children: [
            text('???????? ????????????', screenWidth * 3, theme.lightTextColor,
                fontWeight: FontWeight.w500),
          ],
        ),
        sizedBox(height: screenWidth * 3),
        SizedBox(
          height: screenWidth * 12.5,
          width: double.infinity,
          child: TextFormField(
            controller: adminPassword,
            onSaved: (value) {
              if (adminPassword.text.length < 7) {
                adminErrorTextPassword =
                    ' ?????? ???? ?????????? ???????? ???????????? ?????? 8 ??????????';
                // if (tutorPassword.text.contains(' ')) {
                //   tutorErrorTextPassword =
                //       'Password should not contain blank spaces';
                // }
                // tutorPasswordValid = false;
                // tutorAllFieldsValid = false;
              }
            },
            onChanged: (value) {
              setState(() {
                if (adminPassword.text.length > 7 &&
                    !adminPassword.text.contains(' ')) {
                  adminPasswordValid = true;
                  adminErrorTextPassword = '';
                  if (adminPasswordValid && adminEmailValid) {
                    adminAllFieldsValid = true;
                  }
                }
                // else {
                //   adminErrorTextPassword =
                //       'Password must be atleast 8 characters long';
                //   if (adminPassword.text.contains(' ')) {
                //     adminErrorTextPassword =
                //         'Password should not contain blank spaces';
                //   }
                //   adminPasswordValid = false;
                //   adminAllFieldsValid = false;
                // }
              });
            },
            obscureText: showAdminPassword ? false : true,
            style: textStyle(screenWidth * 3.7, theme.mainColor),
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showAdminPassword = !showAdminPassword;
                  });
                },
                child: Icon(
                  showAdminPassword ? Icons.visibility : Icons.visibility_off,
                  color: theme.lightTextColor,
                  size: screenWidth * 5,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 4, vertical: screenWidth * 4),
              hintText: '********',
              hintStyle: textStyle(screenWidth * 3.3, theme.lightTextColor),
              filled: true,
              fillColor: Colors.white24,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide:
                      BorderSide(width: .3, color: theme.lightTextColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 200),
                  borderSide: BorderSide(
                      width: .6,
                      color: !adminPasswordValid
                          ? theme.redColor
                          : theme.yellowColor)),
            ),
          ),
        ),
        adminPassword.text.length == 0 || adminPasswordValid
            ? sizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 1, top: screenWidth * 1),
                child: Row(
                  children: [
                    text(adminErrorTextPassword, screenWidth * 2.7,
                        theme.redColor),
                  ],
                ),
              ),
        sizedBox(height: screenWidth * 4),
      ]),
    );
  }
}
