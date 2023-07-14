import 'package:flutter/material.dart';
import 'package:flutter_social_ui/constant/app_colors.dart';
import 'package:flutter_social_ui/constant/app_string.dart';
import 'package:flutter_social_ui/constant/app_text_style.dart';
import 'package:flutter_social_ui/data/data.dart';
import 'package:flutter_social_ui/screens/widgets/app_drawer.dart';
import 'package:flutter_social_ui/screens/widgets/post_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            child: Text(
              AppString.following,
              style: AppTextStyle.black24pxBoldLs2,
            ),
          ),
          _buildFollowingPersons(),
          PostCarousel(
            pageController: _pageController,
            title: AppString.posts,
            posts: posts,
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        AppString.frenzy,
        style: AppTextStyle.primaryBoldLt10,
      ),
      bottom: TabBar(
        controller: _tabController,
        indicatorWeight: 3,
        labelColor: AppColors.primary,
        labelStyle: AppTextStyle.fs18pxW600,
        unselectedLabelStyle: AppTextStyle.fs18px,
        tabs: const [
          Tab(text: AppString.trending),
          Tab(text: AppString.latest),
        ],
      ),
    );
  }

  Widget _buildFollowingPersons() {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(width: 1, color: AppColors.primary),
              image: DecorationImage(
                image: AssetImage(user.profileImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
