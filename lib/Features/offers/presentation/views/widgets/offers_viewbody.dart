import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:shoply_admin/Features/offers/presentation/views/add0ffer_view.dart';
import 'package:shoply_admin/constants.dart';

class OffersViewBody extends StatelessWidget {
  const OffersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: BlocListener<OffersCubit, OffersState>(
      listener: (context, state) {
        if (state is ConfirmRemove) {
          showAdaptiveDialog(
              context: context,
              builder: (ctx) => AlertDialog.adaptive(
                    content: const Text("Remove offer ?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<OffersCubit>(context)
                                .currentOfferId = null;
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<OffersCubit>(context).removeOffer(
                                BlocProvider.of<OffersCubit>(context)
                                    .currentOfferId!);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("Yes"))
                    ],
                  ));
        }
      },
      child: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          if (state is OffersSuccess || state is ConfirmRemove) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(16),
                            height: height * 0.2,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        BlocProvider.of<OffersCubit>(context)
                                            .offers[index]
                                            .offerImageUrl),
                                    fit: BoxFit.cover)),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor),
                              onPressed: () {
                                BlocProvider.of<OffersCubit>(context)
                                    .confirmRemove();
                                BlocProvider.of<OffersCubit>(context)
                                        .currentOfferId =
                                    BlocProvider.of<OffersCubit>(context)
                                        .offers[index]
                                        .offerId;
                              },
                              child: const Text("Remove Offer")),
                        ],
                      ),
                    ),
                    itemCount:
                        BlocProvider.of<OffersCubit>(context).offers.length,
                  ),
                ),
                SizedBox(
                  width: width,
                  height: height * 0.05,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: kPrimaryColor,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddOfferPage()));
                      },
                      child: const Text("add Offer")),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}
