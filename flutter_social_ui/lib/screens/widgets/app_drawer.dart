import 'package:flutter/material.dart';
import 'package:flutter_social_ui/constant/app_colors.dart';
import 'package:flutter_social_ui/constant/app_string.dart';
import 'package:flutter_social_ui/constant/app_text_style.dart';
import 'package:flutter_social_ui/data/data.dart';
import 'package:flutter_social_ui/screens/home/home_screen.dart';
import 'package:flutter_social_ui/screens/login/login_screen.dart';
import 'package:flutter_social_ui/screens/profile/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        _buildImageProfile(),
        Expanded(child: _buildListMenuOption(context)),
        _buildDrawerMenuItem(
          const Icon(Icons.directions_run),
          AppString.logout,
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          ),
        ),
      ]),
    );
  }

  Widget _buildListMenuOption(BuildContext context) {
    return ListView(
      children: [
        _buildDrawerMenuItem(
          const Icon(Icons.dashboard),
          AppString.home,
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
        ),
        _buildDrawerMenuItem(const Icon(Icons.chat), AppString.chat, () {}),
        _buildDrawerMenuItem(const Icon(Icons.map), AppString.map, () {}),
        _buildDrawerMenuItem(
          const Icon(Icons.account_circle),
          AppString.yourProfile,
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ProfileScreen(user: currentUser),
            ),
          ),
        ),
        _buildDrawerMenuItem(
          const Icon(Icons.settings),
          AppString.settings,
          () {},
        ),
      ],
    );
  }

  Widget _buildImageProfile() {
    return Stack(
      children: [
        _buildUserBackgroundImage(),
        _buildAvatar(),
      ],
    );
  }

  Widget _buildUserBackgroundImage() {
    return Image.asset(
      currentUser.backgroundImageUrl,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildAvatar() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: AppColors.primary,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(currentUser.profileImageUrl),
                ),
              ),
              Expanded(
                child: Text(
                  currentUser.name,
                  style: AppTextStyle.white25pxBoldLs2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerMenuItem(Icon icon, String title, VoidCallback? ontap) {
    return ListTile(
      leading: icon,
      title: Text(title, style: AppTextStyle.back20px),
      onTap: ontap,
    );
  }
}
