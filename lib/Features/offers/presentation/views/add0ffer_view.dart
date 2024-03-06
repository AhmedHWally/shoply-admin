import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/presentation/manager/image_picker_cubit/image_picker_cubit.dart';
import 'package:shoply_admin/Features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:shoply_admin/Features/offers/presentation/views/widgets/addOffer_viewbody.dart';
import 'package:shoply_admin/constants.dart';

class AddOfferPage extends StatelessWidget {
  const AddOfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => OffersCubit()),
            BlocProvider(create: (context) => ImagePickerCubit())
          ],
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: AddOfferPageViewBody()),
        ));
  }
}
