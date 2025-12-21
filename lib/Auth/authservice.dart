
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final SupabaseClient _supabase = Supabase.instance.client;
  
  Future<AuthResponse> signInWithEmailAndPassword(String mail,String pass)async{
    return await _supabase.auth.signInWithPassword(email: mail, password: pass);
  }

  Future<AuthResponse> signUpWithEmailAndPassword(String mail,String pass)async{
    return await _supabase.auth.signUp(email: mail,password: pass);

  }

}
