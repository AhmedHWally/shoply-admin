import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:shoply_admin/Features/offers/presentation/views/offers_view.dart';
import 'package:shoply_admin/Features/orders/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:shoply_admin/Features/orders/presentation/views/orders_view.dart';
import 'package:shoply_admin/Features/orders/presentation/views/widgets/oders_view_body.dart';
import 'package:shoply_admin/Features/products/presentation/manager/products_cubit/products_cubit.dart';

import 'package:shoply_admin/Features/products/presentation/views/products_view.dart';
import 'package:shoply_admin/constants.dart';

class HomePageGridItem extends StatelessWidget {
  const HomePageGridItem({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          switch (title) {
            case 'products':
              {
                BlocProvider.of<ProductsCubit>(context).loadProducts();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProductsView()));
                break;
              }
            case 'orders':
              {
                BlocProvider.of<OrdersCubit>(context).loadOrders();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrdersView()));
                break;
              }
            case 'offers':
              {
                BlocProvider.of<OffersCubit>(context).loadOffers();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OffersView()));
                break;
              }
          }
        },
        child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                  colors: [kSecondaryColor, kPrimaryColor],
                  end: Alignment.bottomRight,
                  begin: Alignment.topLeft),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: kPrimaryColor,
                          offset: Offset(1, 1),
                          blurRadius: 1)
                    ]),
              ),
            )),
      ),
    );
  }
}
