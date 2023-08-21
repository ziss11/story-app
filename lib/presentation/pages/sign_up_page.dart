import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:story_app/cubit/auth/auth_cubit.dart';
import 'package:story_app/presentation/pages/sign_in_page.dart';
import 'package:story_app/presentation/widgets/animated_circular_indicator.dart';
import 'package:story_app/presentation/widgets/app_button.dart';
import 'package:story_app/presentation/widgets/app_textfield.dart';
import 'package:story_app/utils/common.dart';
import 'package:story_app/utils/styles/app_colors.dart';
import 'package:story_app/utils/validators.dart';

class SignUpPage extends StatefulWidget {
  static const path = '/sign-up';
  static const routeName = 'sign-up';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  bool isObsecureText = true;
  bool isPasswordNotEmpty = false;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;

  void register() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(context, nameController.text,
          emailController.text, passController.text);
    }
  }

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
    return KeyboardDismisser(
      child: Scaffold(
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
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 70, 16, 30),
              child: Form(
                key: _formKey,
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
                      validator: (value) =>
                          Validators.validateEmail(context, value),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      controller: passController,
                      obscureText: isObsecureText,
                      label: AppLocalizations.of(context)!.passwordLabel,
                      hint: AppLocalizations.of(context)!.passwordHint,
                      validator: (value) =>
                          Validators.validatePassword(context, value),
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
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          context.goNamed(SignInPage.routeName);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.lightBlueColor,
                              content: Text(
                                AppLocalizations.of(context)!
                                    .registerSuccessMessage,
                              ),
                            ),
                          );
                        } else if (state is AuthFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.redColor,
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          width: MediaQuery.of(context).size.width,
                          onPressed: register,
                          child: (state is AuthLoading)
                              ? const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: AnimatedCircularIndicator(
                                    color: AppColors.lightBlueColor,
                                  ),
                                )
                              : Text(AppLocalizations.of(context)!.signUpTitle),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => context.goNamed(SignInPage.routeName),
                      child: Text.rich(
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .alreadyHaveAccounLabel,
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
          ),
        ),
      ),
    );
  }
}
