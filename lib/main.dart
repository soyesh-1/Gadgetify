import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gadgetify/app/router/app_router.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/auth/data/model/auth_hive_model.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:gadgetify/features/splash/presentation/view_model/splash_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(AuthHiveModelAdapter());

  // Setup dependency injection
  setupDependencies();

  runApp(const GadgetApp());
}

class GadgetApp extends StatelessWidget {
  const GadgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()),
        // Use the service locator to create the AuthCubit instance
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
      ],
      child: MaterialApp(
        title: 'Gadgetify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(/* Your theme data */),
        initialRoute: AppRouter.splashRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
