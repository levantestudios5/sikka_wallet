import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
            child: Text(
              "SD",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
                  ProfileInfoTile(
                    label: "Name",
                    value: "Sheikh Daniyal",
                    shouldShowDivider: true,
                  ),
                  ProfileInfoTile(
                      label: "Email Address",
                      value: "example@email.com",
                      shouldShowDivider: true),
                  ProfileInfoTile(
                      label: "Password",
                      value: "****************",
                      shouldShowDivider: true),
                  ProfileInfoTile(
                      label: "Country",
                      value: "Pakistan",
                      shouldShowDivider: false),
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
                  // Handle logout
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
