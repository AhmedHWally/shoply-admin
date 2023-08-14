import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import 'custom_onboarding_item.dart';
import 'onboarding_buttons_section.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late final PageController onBoardingController;
  bool isLastPage = false;
  late Image onBoardingScreen1;
  late Image onBoardingScreen2;
  late Image onBoardingScreen3;

  @override
  void initState() {
    onBoardingController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        const AssetImage('assets/images/onBoardingScreen1.png'), context);
    precacheImage(
        const AssetImage('assets/images/onBoardingScreen2.png'), context);
    precacheImage(
        const AssetImage('assets/images/onBoardingScreen3.png'), context);
    precacheImage(const AssetImage(kBackGroundImage), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    onBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackGroundImage), fit: BoxFit.fill)),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: onBoardingController,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == 2);
                  },
                  children: pageViewItems),
            ),
            OnBoardingButtonsSection(
                isLastPage: isLastPage,
                width: width,
                height: height,
                onBoardingController: onBoardingController),
          ],
        ),
      ),
    );
  }

  final List<Widget> pageViewItems = const [
    CustomOnBoardingItem(
      image: 'assets/images/onBoardingScreen1.png',
      title: 'Control the user application',
      subtitle: 'You get full control over the user shoply app',
    ),
    CustomOnBoardingItem(
      image: 'assets/images/onBoardingScreen2.png',
      title: 'Manage the user application',
      subtitle:
          'You will be able to add edit or delete products and offers and much more',
    ),
    CustomOnBoardingItem(
      image: 'assets/images/onBoardingScreen3.png',
      title: 'Start managing now',
      subtitle: 'Let\'s start a great admin experiance',
    ),
  ];
}
