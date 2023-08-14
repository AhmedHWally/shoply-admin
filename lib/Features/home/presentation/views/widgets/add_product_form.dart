import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/presentation/manager/manage_products_cubit/manage_products_cubit.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ManageProductsCubit, ManageProductsState>(
          listener: (context, state) {
            if (state is ManageProductsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('product uploaded succefully')));
            } else if (state is ManageProductsFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('some thing went wrong')));
            }
          },
          builder: (context, state) => Center(
                  child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ManageProductsCubit>(context).uploadProduct();
                },
                child: const Text('add product'),
              ))),
    );
  }
}
