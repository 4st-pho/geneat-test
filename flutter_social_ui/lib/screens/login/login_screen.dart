import 'package:flutter/material.dart';
import 'package:flutter_social_ui/constant/app_colors.dart';
import 'package:flutter_social_ui/constant/app_images.dart';
import 'package:flutter_social_ui/constant/app_string.dart';
import 'package:flutter_social_ui/constant/app_text_style.dart';
import 'package:flutter_social_ui/screens/home/home_screen.dart';
import 'package:flutter_social_ui/screens/login/widgets/login_text_field.dart';
import 'package:flutter_social_ui/screens/utils/clipper/curve_clipper.dart';
import 'package:flutter_social_ui/screens/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _buildTopImage(context),
              _buildForm(),
              const SizedBox(height: 40),
              _buildLoginButton(context),
              const Spacer(),
              _buildSignUpButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            AppString.frenzy,
            style: AppTextStyle.primary34pxBoldLs10,
          ),
          _buildUsernameTextfield(),
          _buildPasswordTextField(),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return const LoginTextField(
      prefixIcon: Icon(Icons.lock, size: 30),
      hintText: AppString.password,
      obscureText: true,
    );
  }

  Widget _buildUsernameTextfield() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: LoginTextField(
        prefixIcon: Icon(Icons.account_box, size: 30),
        hintText: AppString.username,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      },
      child: const Text(
        AppString.login,
        style: AppTextStyle.white22pxW600Ls15,
      ),
    );
  }

  Widget _buildTopImage(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Image.asset(
        AppImages.loginBackground,
        height: MediaQuery.of(context).size.height / 2.5,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 80,
        width: double.infinity,
        color: AppColors.primary,
        alignment: Alignment.center,
        child: const Text(
          AppString.dontHaveAnAccount,
          style: AppTextStyle.white20pxW500,
        ),
      ),
    );
  }
}
