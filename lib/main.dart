import 'package:flutter/material.dart';
import 'package:gadgetify/features/splash/presentation/view/splash_view.dart';
import 'package:provider/provider.dart';
 // We will create this later

Future<void> main() async {
  // Ensure that Flutter widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  runApp(const GadgetApp());
}

class GadgetApp extends StatelessWidget {
  const GadgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Register all your Cubits here for dependency injection
      providers: [
        Provider<SplashCubit>(create: (_) => SplashCubit()),
        // Provider<AuthCubit>(create: (_) => AuthCubit()), // Example for later
      ],
      child: MaterialApp(
        title: 'Gadgetify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Poppins',
        ),
        // Start with the SplashView
        home: const SplashView(),
        // We will define the routes later in the AppRouter class
        // onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
