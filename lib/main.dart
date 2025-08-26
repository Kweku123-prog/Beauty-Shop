import 'package:beauty/data/repository/ProfessionalRepository.dart';
import 'package:beauty/data/bloc/discover_bloc/discover_event_bloc.dart';
import 'package:beauty/features/pages/discover_screen.dart';
import 'package:beauty/features/pages/splash_screen.dart';
import 'package:beauty/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const ProBookingApp());
}

class ProBookingApp extends StatelessWidget {
  const ProBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ProfessionalRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DiscoverEventBloc(context.read<ProfessionalRepository>())
                  ..add(LoadProfessionals()),
          ),
          BlocProvider(
            create: (_) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: "Beauty App",
              debugShowCheckedModeBanner: false,
              themeMode: themeMode, // 👈 controlled by ThemeCubit

              // Light Theme
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.purple,
                scaffoldBackgroundColor: Colors.white,
                cardTheme: CardTheme(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Dark Theme
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.deepPurple,
                scaffoldBackgroundColor: Colors.black,
                cardTheme: CardTheme(
                  color: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.black87,
                  titleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
