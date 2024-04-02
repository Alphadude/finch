import 'package:finch/config/router.dart';
import 'package:finch/firebase_options.dart';
import 'package:finch/provider/authentication/auth_provider.dart';
import 'package:finch/provider/loan/loan_provider.dart';
import 'package:finch/styles/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoanProviderImpl()),
        ChangeNotifierProvider(create: (_) => AuthenticationProviderImpl()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, scrolledUnderElevation: 0),
          scaffoldBackgroundColor: background,
          primaryColor: primaryColor,
        ),
      ),
    );
  }
}
