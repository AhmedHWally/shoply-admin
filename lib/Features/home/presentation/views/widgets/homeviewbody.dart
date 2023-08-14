import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/custom_grid_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.2),
            children: const [
              CustomGridItem(title: 'products'),
              CustomGridItem(title: 'orders'),
              CustomGridItem(title: 'offers')
            ],
          ),
        )
      ],
    ));
  }
}
