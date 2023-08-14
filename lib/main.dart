import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'Features/home/presentation/manager/products_cubit/products_cubit.dart';
import 'Features/home/presentation/views/homeview.dart';
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
        ],
        child: const MaterialApp(
            // home: showHome as bool
            //     ? isAuth as bool
            //         ? const HomeView()
            //         : const LoginView()
            //     : const OnBoardingView()),
            home: HomeView()));
  }
}
