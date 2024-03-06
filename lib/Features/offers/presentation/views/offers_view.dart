import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/offers/presentation/views/widgets/offers_viewbody.dart';
import 'package:shoply_admin/constants.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: OffersViewBody(),
      ),
    );
  }
}
