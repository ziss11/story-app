import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/presentation/pages/sign_in_page.dart';
import 'package:story_app/presentation/widgets/app_button.dart';
import 'package:story_app/presentation/widgets/app_textfield.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class SignUpPage extends StatefulWidget {
  static const path = '/sign-up';
  static const routeName = 'sign-up';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  bool isObsecureText = true;
  bool isPasswordNotEmpty = false;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();

    passController.addListener(() {
      setState(() {
        isPasswordNotEmpty = passController.text.isNotEmpty;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.signUpTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.signUpSubtitle,
              style: const TextStyle(
                color: AppColors.greyColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 70, 16, 30),
          child: Column(
            children: [
              AppTextField(
                controller: nameController,
                label: AppLocalizations.of(context)!.nameLabel,
                hint: AppLocalizations.of(context)!.nameHint,
                prefixIcon: const Icon(Icons.person_rounded),
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: emailController,
                label: AppLocalizations.of(context)!.emailLabel,
                hint: AppLocalizations.of(context)!.emailHint,
                prefixIcon: const Icon(Icons.email_rounded),
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: passController,
                obscureText: isObsecureText,
                label: AppLocalizations.of(context)!.passwordLabel,
                hint: AppLocalizations.of(context)!.passwordHint,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: isPasswordNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecureText = !isObsecureText;
                          });
                        },
                        icon: isObsecureText
                            ? const Icon(Icons.visibility_rounded)
                            : const Icon(Icons.visibility_off_rounded),
                      )
                    : null,
              ),
              const SizedBox(height: 30),
              AppButton(
                width: MediaQuery.of(context).size.width,
                onPressed: () {},
                text: AppLocalizations.of(context)!.signUpTitle,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => context.goNamed(SignInPage.routeName),
                child: Text.rich(
                  TextSpan(
                    text: AppLocalizations.of(context)!.alreadyHaveAccounLabel,
                    style: const TextStyle(
                      color: AppColors.greyColor,
                    ),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.signInTitle,
                        style: const TextStyle(
                          color: AppColors.purpleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
