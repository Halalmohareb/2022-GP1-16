import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Dhyaa/models/UserData.dart';
import 'package:Dhyaa/provider/firestore.dart';
import 'package:Dhyaa/screens/signinMethodScreen/signin_method_screen.dart';
import 'package:Dhyaa/screens/student/studentProfile_screen.dart';
import 'package:Dhyaa/screens/tutor/tutorProfile_screen.dart';
import 'package:Dhyaa/screens/update_profile.dart';
import 'package:Dhyaa/theme/theme.dart';

class Menu extends StatefulWidget {
  final UserData userData;
  const Menu({Key? key, required this.userData}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // Variables
  UserData userData = emptyUserData;

  // Functions
  @override
  void initState() {
    userData = widget.userData;
    getUserData();

    super.initState();
  }

  getUserData() {
    FirestoreHelper.getMyUserData().then((value) {
      userData = value;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/DhyaaLogo.png',
                  height: 120,
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  userData.username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(userData.email),
              ),
              SizedBox(height: 50),
              ListTile(
                shape: Border(),
                title: Text('?????????????? ?????????? ??????????????'),
                leading: Icon(Icons.person),
                onTap: () {
                  if (userData.type == "Student") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            StudentProfileScreen(),
                      ),
                    );
                  } else if (userData.type == "Tutor") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => TutorProfileScreen(),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                shape: Border(),
                title: Text('?????????? ??????????????'),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          UpdateProfile(userData: userData),
                    ),
                  ).then((value) {
                    if (value != null) {
                      userData = value;
                      if (mounted) setState(() {});
                    }
                  });
                },
              ),
              ListTile(
                shape: Border(),
                title: Text('?????????? ??????????'),
                leading: Icon(Icons.payment),
                onTap: () {},
              ),
              ListTile(
                shape: Border(),
                title: Text('?????????? ????????'),
                leading: Icon(Icons.call),
                onTap: () {},
              ),
              SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => new SignInMethod(),
                        ),
                      );
                    });
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red.shade300,
                    ),
                    child: Center(
                      child: Text(
                        '?????????? ????????????',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF2F2F2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
