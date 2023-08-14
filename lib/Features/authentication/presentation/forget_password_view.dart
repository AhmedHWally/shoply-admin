import 'package:flutter/material.dart';

import 'package:shoply_admin/constants.dart';

import 'widgets/forgerPassword_viewbody.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
        ),
        child: const Scaffold(
            backgroundColor: Colors.transparent,
            body: ForgetPasswordViewBody()));
  }
}
