import 'package:canteen/features/profile/presentation/pages/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:canteen/features/profile/presentation/pages/my_account_page.dart';
import 'package:canteen/features/profile/presentation/pages/saved_page.dart';
import 'package:canteen/features/profile/presentation/pages/widgets/profile_header.dart';
import 'package:canteen/features/profile/presentation/pages/widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const GreenHeader(
            title: 'Profile',
            padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 80),
          ),
          const ProfileInfo(
            imagePath: 'assets/images/profile_picture.png',
            name: 'Peter Andrew',
            email: 'peterandrew@gmail.com',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: 'My Account',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MyAccountPage()),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.bookmark_outline,
                  title: 'Saved',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SavedPage()),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  badgeCount: 1,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificationsPage()),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Log Out',
                  isLogout: true,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => const LogoutDialog(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



