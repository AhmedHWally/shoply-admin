import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/authentication/presentation/widgets/login_view_body.dart';
import 'package:shoply_admin/constants.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LoginViewBody(),
      ),
    );
  }
}
