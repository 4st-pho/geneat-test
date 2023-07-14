import 'package:flutter/material.dart';
import 'package:flutter_social_ui/constant/app_text_style.dart';
import 'package:flutter_social_ui/models/post_model.dart';

class PostCarousel extends StatelessWidget {
  final PageController pageController;
  final String title;
  final List<Post> posts;
  const PostCarousel({
    super.key,
    required this.pageController,
    required this.title,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(title, style: AppTextStyle.black24pxBoldLs2),
        ),
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: pageController,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return _buildCarouselPostItem(post, index);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselPostItem(Post post, int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
          value = (1 - value.abs() * 0.15).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeIn.transform(value) * 400,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [_buildPostImage(post), _buildPostInfo(post)],
        ),
      ),
    );
  }

  Widget _buildPostImage(Post post) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          post.imageUrl,
          height: 400,
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPostInfo(Post post) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              post.title,
              style: AppTextStyle.black24pxBold,
              overflow: TextOverflow.ellipsis,
            ),
            Text(post.location, style: AppTextStyle.black18pxW600),
            Row(
              children: [
                const Icon(Icons.favorite, color: Colors.red),
                const SizedBox(width: 6),
                Text(post.likes.toString(), style: AppTextStyle.fs18px),
                const Spacer(),
                const Icon(Icons.comment, color: Colors.blue),
                const SizedBox(width: 6),
                Text(post.comments.toString(), style: AppTextStyle.fs18px),
              ],
            )
          ],
        ),
      ),
    );
  }
}
