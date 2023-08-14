import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoply_admin/Features/home/presentation/views/products_view.dart';
import 'package:shoply_admin/constants.dart';

import '../../manager/products_cubit/products_cubit.dart';

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
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
                print('orders title');
                print('object');
                break;
              }
            case 'offers':
              {
                print('offers title');
                print('object');
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
