import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/presentation/login/store/login_store.dart';
import 'package:sikka_wallet/presentation/registration/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserStore userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Profile",
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: Colors.black))),

      // backgroundColor: Color(0xFFF8F5FC),
      body: Column(
        children: [
          // Profile Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Observer(builder: (context) {
              userStore.currentUser;
              return Text(
                getInitials(userStore.currentUser?.fullName ?? ""),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          // Profile Info Card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(builder: (context) {
                    userStore.currentUser;
                    return ProfileInfoTile(
                      label: "Name",
                      value: userStore.currentUser?.fullName ?? "",
                      shouldShowDivider: true,
                    );
                  }),
                  Observer(builder: (context) {
                    userStore.currentUser;
                    return ProfileInfoTile(
                        label: "Email Address",
                        value: userStore.currentUser?.email ?? "",
                        shouldShowDivider: true);
                  }),
                  ProfileInfoTile(
                      label: "Password",
                      value: "****************",
                      shouldShowDivider: true),
                  Observer(builder: (context) {
                    return ProfileInfoTile(
                        label: "Country",
                        value: userStore.currentUser?.country ?? "",
                        shouldShowDivider: false);
                  }),
                ],
              ),
            ),
          ),
          Spacer(),
          // Logout Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  userStore.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) =>
                        false, // Removes all previous routes
                  );
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getInitials(String fullName) {
    List<String> names = fullName.split(" ");
    if (names.length < 2)
      return names.first
          .substring(0, 1)
          .toUpperCase(); // Handle single-word names
    return "${names.first[0].toUpperCase()}${names.last[0].toUpperCase()}";
  }
}

class ProfileInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final bool shouldShowDivider;

  ProfileInfoTile(
      {required this.shouldShowDivider,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          subtitle: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          trailing: Icon(Icons.edit, color: Colors.black54),
        ),
        shouldShowDivider
            ? Divider(
                color: Colors.black12,
                thickness: 1,
              )
            : SizedBox(),
      ],
    );
  }
}
