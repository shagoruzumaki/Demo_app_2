import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';

void main() async{
  await Supabase.initialize(
      url: "https://motawlyahpexqcixiwgb.supabase.co",
      anonKey: "sb_publishable_PtimowdFwXc4nmzTmCiB4w_VPwFBooj"
  );
  runApp(const TrendEvaluatorApp());
}

class TrendEvaluatorApp extends StatelessWidget {
  const TrendEvaluatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trend Evaluator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF8B5CF6),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}