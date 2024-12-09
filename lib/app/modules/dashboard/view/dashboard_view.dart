import 'dart:convert';
import 'package:bdcalling_task/app/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../storage/storage_helper.dart';
import '../../login/controllers/login_controller.dart';
import '../../tasks/view/task_view.dart';

class DashboardView extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color:Colors.white),),
        centerTitle: true, 
        backgroundColor: AppColors.primary,
         iconTheme: IconThemeData(color: Colors.white), // Set the hamburger icon color to white
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await controller.logout(); // Call logout
            },
          ),
        ],
      ),
      drawer: Drawer(
backgroundColor: AppColors.primary,
        child: FutureBuilder<Map<String, dynamic>?>(
          future: StorageHelper.getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final userInfo = snapshot.data;
            final userName = userInfo?['firstName'] ?? 'User';
            final userEmail = userInfo?['email'] ?? 'user@example.com';

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/user_avatar.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Welcome, $userName!',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                // Navigation Items
                ListTile(
                  leading: Icon(Icons.task,color: Colors.white,),
                  title: Text('Tasks',  style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.to(() => TaskListView());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person,color: Colors.white,),
                  title: Text('My Profile',  style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.toNamed(Routes.profile);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person,color: Colors.white,),
                  title: Text('Edit Profile',  style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.toNamed(Routes.editProfile);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout,color: Colors.white,),
                  title: Text('Logout',  style: TextStyle(color: Colors.white)),
                  onTap: () {
                    controller.logout();
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}
