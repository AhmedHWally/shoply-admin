import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoply_admin/Features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:shoply_admin/Features/orders/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:shoply_admin/Features/products/presentation/manager/manage_products_cubit/manage_products_cubit.dart';
import 'package:shoply_admin/Features/products/presentation/manager/products_cubit/products_cubit.dart';

import 'Features/authentication/presentation/login_view.dart';
import 'Features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'Features/home/presentation/views/homeview.dart';
import 'Features/onBoarding/presentation/views/onboarding_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  final isAuth = prefs.getBool('isAuth') ?? false;
  runApp(MyApp(showHome: showHome, isAuth: isAuth));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.showHome, this.isAuth});
  final bool? showHome;
  final bool? isAuth;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => ProductsCubit()),
          BlocProvider(create: (context) => ManageProductsCubit()),
          BlocProvider(create: (context) => OrdersCubit()),
          BlocProvider(create: (context) => OffersCubit()),
        ],
        child: MaterialApp(
            theme: ThemeData(useMaterial3: false),
            debugShowCheckedModeBanner: false,
            home: showHome as bool
                ? isAuth as bool
                    ? const HomeView()
                    : const LoginView()
                : const OnBoardingView()));
  }
}
