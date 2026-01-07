import 'package:flutter/material.dart';

class SocialSentimentCard extends StatelessWidget {
  final String platform;
  final String sentiment;
  final IconData icon;
  final Color platformColor;

  const SocialSentimentCard({
    Key? key,
    required this.platform,
    required this.sentiment,
    required this.icon,
    required this.platformColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            platformColor.withValues(alpha: 0.1),
            platformColor.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(color: platformColor.withValues(alpha: 0.3), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: platformColor.withValues(alpha: 0.1),
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
              color: platformColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: platformColor,
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
                    color: platformColor,
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
          _buildSentimentIndicator(sentiment),
        ],
      ),
    );
  }

  Widget _buildSentimentIndicator(String sentiment) {
    IconData indicatorIcon;
    Color color;

    final lowerSentiment = sentiment.toLowerCase();

    if (lowerSentiment.contains('positive') ||
        lowerSentiment.contains('good') ||
        lowerSentiment.contains('great')) {
      indicatorIcon = Icons.sentiment_very_satisfied;
      color = Colors.green;
    } else if (lowerSentiment.contains('negative') ||
        lowerSentiment.contains('bad') ||
        lowerSentiment.contains('poor')) {
      indicatorIcon = Icons.sentiment_very_dissatisfied;
      color = Colors.red;
    } else if (lowerSentiment.contains('mixed') ||
        lowerSentiment.contains('neutral')) {
      indicatorIcon = Icons.sentiment_neutral;
      color = Colors.orange;
    } else {
      indicatorIcon = Icons.help_outline;
      color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        indicatorIcon,
        color: color,
        size: 24,
      ),
    );
  }
}