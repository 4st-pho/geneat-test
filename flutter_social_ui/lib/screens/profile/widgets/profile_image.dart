import 'package:flutter/material.dart';
import 'package:flutter_social_ui/constant/app_colors.dart';
import 'package:flutter_social_ui/screens/utils/clipper/profile_background_clipper.dart';

class ProfileImage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String backgroundImageUrl;
  final String profileImageUrl;
  const ProfileImage({
    super.key,
    required this.scaffoldKey,
    required this.backgroundImageUrl,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildProfilebackgroundImage(),
        _buildAvatar(),
        _buildDrawerButton(scaffoldKey)
      ],
    );
  }

  ClipPath _buildProfilebackgroundImage() {
    return ClipPath(
      clipper: ProfileBackgroundClipper(),
      child: Image.asset(
        backgroundImageUrl,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAvatar() {
    return Positioned(
      bottom: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2),
              blurRadius: 6,
            )
          ],
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(profileImageUrl),
        ),
      ),
    );
  }

  Widget _buildDrawerButton(GlobalKey<ScaffoldState> scaffoldKey) {
    return Positioned(
      top: 20,
      left: 20,
      child: IconButton(
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
        icon: Icon(Icons.menu, color: AppColors.primary),
        iconSize: 30,
      ),
    );
  }
}
