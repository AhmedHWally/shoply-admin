import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/home_view_widgets/home_page_gridview_item.dart';

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
              HomePageGridItem(title: 'products'),
              HomePageGridItem(title: 'orders'),
              HomePageGridItem(title: 'offers')
            ],
          ),
        )
      ],
    ));
  }
}
