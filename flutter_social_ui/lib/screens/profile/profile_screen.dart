import 'package:flutter/material.dart';
import 'package:flutter_social_ui/constant/app_string.dart';
import 'package:flutter_social_ui/constant/app_text_style.dart';
import 'package:flutter_social_ui/models/user_model.dart';
import 'package:flutter_social_ui/screens/profile/widgets/profile_image.dart';
import 'package:flutter_social_ui/screens/widgets/app_drawer.dart';
import 'package:flutter_social_ui/screens/widgets/post_carousel.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          ProfileImage(
            scaffoldKey: scaffoldKey,
            backgroundImageUrl: widget.user.backgroundImageUrl,
            profileImageUrl: widget.user.profileImageUrl,
          ),
          _buildUsername(),
          _buildFolowQuantity(),
          const SizedBox(height: 10),
          _buildPostCarousel()
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        widget.user.name,
        style: AppTextStyle.black25pxBoldLs15,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFolowQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text(AppString.following, style: AppTextStyle.black54fs22px),
            const SizedBox(height: 2),
            Text(
              widget.user.following.toString(),
              style: AppTextStyle.black20pxW600,
            )
          ],
        ),
        Column(
          children: [
            const Text(AppString.followers, style: AppTextStyle.black54fs22px),
            const SizedBox(height: 2),
            Text(
              widget.user.followers.toString(),
              style: AppTextStyle.black20pxW600,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPostCarousel() {
    return PostCarousel(
      pageController: _pageController,
      title: AppString.yourPosts,
      posts: widget.user.posts,
    );
  }
}
