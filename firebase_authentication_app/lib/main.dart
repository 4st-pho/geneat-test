import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_app/blocs/auth/auth_bloc.dart';
import 'package:firebase_authentication_app/constants/route_configure.dart';
import 'package:firebase_authentication_app/firebase_options.dart';
import 'package:firebase_authentication_app/pages/splash_page.dart';
import 'package:firebase_authentication_app/repositories/auth_repository.dart';
import 'package:firebase_authentication_app/repositories/profile_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRespository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AuthBloc(authRespository: context.read<AuthRespository>());
            },
          ),
        ],
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.initRoute,
            home: const SplashPage(),
          ),
        ),
      ),
    );
  }
}
