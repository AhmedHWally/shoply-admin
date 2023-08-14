import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/homeviewbody.dart';

import '../../../../constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: const HomeViewBody(),
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text(
            'Home Page',
            style: TextStyle(fontSize: 24, shadows: [
              Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
            ]),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
