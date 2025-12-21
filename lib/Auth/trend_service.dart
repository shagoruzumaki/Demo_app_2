import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:demo_app_2/models/trend_item.dart';

class TrendItemService{
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<TrendItem>> fetchTrendItems() async{
    final response = await _client.from('trend_items').select();
    return (response as List).map((e) => TrendItem.fromJson(e)).toList();
  }

}