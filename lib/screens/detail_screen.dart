import 'package:flutter/material.dart';
import '../data/models/trend_item.dart';
import '../data/services/opinion_service.dart';
import '../widgets/social_sentiment_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailScreen extends StatefulWidget {
  final TrendItem item;

  const DetailScreen({
    super.key,
    required this.item,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _opinionController = TextEditingController();
  bool _isSubmitting = false;
  final OpinionService _opinionService = OpinionService();

  Future<void> _submitOpinion() async {
    if (_opinionController.text.trim().isEmpty) return;

    setState(() => _isSubmitting = true);

    try {
      await _opinionService.addOpinion(
        itemId: widget.item.id,
        text: _opinionController.text.trim(),
      );

      _opinionController.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Opinion submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final hype = widget.item.hype;

    // Safety guard
    if (hype == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F2937),
          title: Text(item.title),
        ),
        body: const Center(
          child: Text(
            'No hype data available',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Image App Bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: const Color(0xFF1F2937),
            flexibleSpace: FlexibleSpaceBar(
              background: item.posterUrl != null
                  ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.posterUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getCategoryColor().withOpacity(0.8),
                              _getCategoryColor(),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _getCategoryEmoji(),
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getCategoryColor().withValues(alpha: 0.8),
                      _getCategoryColor(),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    _getCategoryEmoji(),
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.category.toUpperCase(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  if (item.description != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      item.description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Hype Level Card
                  _buildHypeLevel(_getHypeLevel(hype)),
                  const SizedBox(height: 24),

                  // Why Hyped Section
                  _buildSection(
                    '🔥 Why Was It Hyped?',
                    _getStringValue(hype['why_hyped']) ?? 'No information available',
                    Colors.yellow[700]!,
                  ),
                  const SizedBox(height: 16),

                  // Expectation vs Reality
                  Row(
                    children: [
                      Expanded(
                        child: _buildExpectationCard(
                          'Expectation',
                          _getStringValue(hype['expectation']) ?? 'No data',
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildExpectationCard(
                          'Reality',
                          _getStringValue(hype['reality']) ?? 'No data',
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Social Media Sentiment Section
                  const Text(
                    '📊 Social Media Sentiment',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  SocialSentimentCard(
                    platform: 'YouTube',
                    sentiment: _getStringValue(hype['youtube_sentiment']) ?? 'No data',
                    icon: Icons.play_circle_filled,
                    platformColor: const Color(0xFFFF0000),
                  ),
                  const SizedBox(height: 12),

                  SocialSentimentCard(
                    platform: 'Reddit',
                    sentiment: _getStringValue(hype['reddit_sentiment']) ?? 'No data',
                    icon: Icons.reddit,
                    platformColor: const Color(0xFFFF4500),
                  ),
                  const SizedBox(height: 12),

                  SocialSentimentCard(
                    platform: 'Twitter',
                    sentiment: _getStringValue(hype['twitter_sentiment']) ?? 'No data',
                    icon: Icons.chat_bubble_outline,
                    platformColor: const Color(0xFF1DA1F2),
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Opinion Section
                  const Text(
                    'Share Your Opinion',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: _opinionController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'What do you think about this trend?',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitOpinion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Submit Opinion',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHypeLevel(int hypeLevel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current Hype Level',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  Icon(
                    hypeLevel >= 70 ? Icons.trending_up : Icons.trending_down,
                    color: hypeLevel >= 70 ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$hypeLevel%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: hypeLevel / 100,
              minHeight: 12,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(
                  _getHypeColor(hypeLevel)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content, Color titleColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildExpectationCard(String label, String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentCard(String platform, String sentiment, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Platform Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),

          // Platform Name and Sentiment
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sentiment,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Sentiment Indicator
          _buildSentimentIndicator(sentiment, color),
        ],
      ),
    );
  }

  Widget _buildSentimentIndicator(String sentiment, Color platformColor) {
    IconData icon;
    Color color;

    final lowerSentiment = sentiment.toLowerCase();

    if (lowerSentiment.contains('positive') || lowerSentiment.contains('good') || lowerSentiment.contains('great')) {
      icon = Icons.sentiment_very_satisfied;
      color = Colors.green;
    } else if (lowerSentiment.contains('negative') || lowerSentiment.contains('bad') || lowerSentiment.contains('poor')) {
      icon = Icons.sentiment_very_dissatisfied;
      color = Colors.red;
    } else if (lowerSentiment.contains('mixed') || lowerSentiment.contains('neutral')) {
      icon = Icons.sentiment_neutral;
      color = Colors.orange;
    } else {
      icon = Icons.help_outline;
      color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  Color _getCategoryColor() {
    switch (widget.item.category.toLowerCase()) {
      case 'game':
        return const Color(0xFF7C3AED);
      case 'movie':
        return const Color(0xFF991B1B);
      case 'series':
        return const Color(0xFF1E40AF);
      case 'app':
        return const Color(0xFF065F46);
      default:
        return Colors.grey;
    }
  }

  String _getCategoryEmoji() {
    switch (widget.item.category.toLowerCase()) {
      case 'game':
        return '🎮';
      case 'movie':
        return '🎬';
      case 'series':
        return '📺';
      case 'app':
        return '📱';
      default:
        return '❓';
    }
  }

  Color _getHypeColor(int hypeLevel) {
    if (hypeLevel >= 70) return Colors.green;
    if (hypeLevel >= 50) return Colors.yellow;
    if (hypeLevel >= 30) return Colors.orange;
    return Colors.red;
  }

  // Helper methods to safely extract values from hype map
  int _getHypeLevel(Map<String, dynamic>? hype) {
    if (hype == null) return 0;
    final value = hype['hype_level'];
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  String? _getStringValue(dynamic value) {
    if (value == null) return null;
    String str = value is String ? value : value.toString();

    // Clean up the string - remove curly braces, quotes, and extra whitespace
    str = str.replaceAll('{', '').replaceAll('}', '').trim();

    return str;
  }

  @override
  void dispose() {
    _opinionController.dispose();
    super.dispose();
  }
}