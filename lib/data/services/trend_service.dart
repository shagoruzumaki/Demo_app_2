import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/trend_item.dart';

class TrendService {
  final _client = Supabase.instance.client;

  Future<List<TrendItem>> fetchByCategoryWithHype(String category) async {
    final res = await Supabase.instance.client
        .from('trending_items')
        .select('''
        id,
        title,
        category,
        poster_url,
        description,
        trend_hype (
          hype_level,
          why_hyped,
          expectation,
          reality,
          worth_it,
          reddit_sentiment,
          twitter_sentiment,
          youtube_sentiment
        )
      ''')
        .eq('category', category);

    return (res as List)
        .map((e) => TrendItem.fromMap(e))
        .toList();
  }

}
