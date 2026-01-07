import 'package:supabase_flutter/supabase_flutter.dart';

class OpinionService {
  final _supabase = Supabase.instance.client;

  // Add Opinion
  Future<void> addOpinion({
    required String itemId,
    required String text,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    await _supabase.from('opinions').insert({
      'user_id': userId,
      'item_id': itemId,
      'opinion_text': text,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // Get My Opinions
  Future<List<Map<String, dynamic>>> getMyOpinions() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    final response = await _supabase
        .from('opinions')
        .select('*, trending_items(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // Update Opinion
  Future<void> updateOpinion({
    required String opinionId,
    required String newText,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    await _supabase
        .from('opinions')
        .update({
      'opinion_text': newText,
      'updated_at': DateTime.now().toIso8601String(),
    })
        .eq('id', opinionId)
        .eq('user_id', userId); // Security: only update your own opinions
  }

  // Delete Opinion
  Future<void> deleteOpinion(String opinionId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    await _supabase
        .from('opinions')
        .delete()
        .eq('id', opinionId)
        .eq('user_id', userId); // Security: only delete your own opinions
  }
}