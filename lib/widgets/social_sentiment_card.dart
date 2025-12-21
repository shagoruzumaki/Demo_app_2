import 'package:flutter/material.dart';

class SocialSentimentCard extends StatelessWidget {
  final String platform;
  final Map<String, dynamic> sentimentData;
  final Color platformColor;
  final String platformIcon;

  const SocialSentimentCard({
    Key? key,
    required this.platform,
    required this.sentimentData,
    required this.platformColor,
    required this.platformIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract data based on platform type
    int positive = 0;
    int negative = 0;
    String topContent = '';
    String additionalInfo = '';

    if (platform == 'Reddit') {
      positive = sentimentData['positive'] ?? 0;
      negative = sentimentData['negative'] ?? 0;
      topContent = '"${sentimentData['topComment'] ?? 'No comment'}"';
      additionalInfo = '${positive + negative} discussions in ${sentimentData['subreddit'] ?? 'various subreddits'}';
    } else if (platform == 'YouTube') {
      positive = sentimentData['likes'] ?? 0;
      negative = sentimentData['dislikes'] ?? 0;
      topContent = '"${sentimentData['topComment'] ?? 'No comment'}"';
      additionalInfo = '${sentimentData['videoCount'] ?? 0} videos analyzed';
    } else if (platform == 'Twitter/X') {
      positive = sentimentData['positive'] ?? 0;
      negative = sentimentData['negative'] ?? 0;
      topContent = sentimentData['hashtag'] ?? '#NoHashtag';
      additionalInfo = '${positive + negative} tweets analyzed';
    }

    // Calculate sentiment percentage
    final total = positive + negative;
    final percentage = total > 0 ? ((positive / total) * 100).round() : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: platformColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Platform Header Row
          Row(
            children: [
              // Platform Icon/Logo
              _buildPlatformIcon(),
              const SizedBox(width: 12),

              // Platform Name
              Expanded(
                child: Text(
                  platform,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),

              // Sentiment Percentage
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getSentimentColor(percentage).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getSentimentColor(percentage),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getSentimentIcon(percentage),
                      size: 16,
                      color: _getSentimentColor(percentage),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _getSentimentColor(percentage),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Sentiment Bar
          _buildSentimentBar(percentage),

          const SizedBox(height: 12),

          // Top Comment/Hashtag
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: platformColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: platformColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      platform == 'Twitter/X'
                          ? Icons.tag
                          : Icons.format_quote,
                      size: 14,
                      color: platformColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      platform == 'Twitter/X'
                          ? 'Trending Hashtag'
                          : 'Top Comment',
                      style: TextStyle(
                        fontSize: 11,
                        color: platformColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  topContent,
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Additional Info (discussions/videos/tweets count)
          Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  additionalInfo,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========================================
  // BUILD PLATFORM ICON
  // ========================================
  Widget _buildPlatformIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: platformColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: platformColor.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          platformIcon,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ========================================
  // BUILD SENTIMENT BAR
  // ========================================
  Widget _buildSentimentBar(int percentage) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 12,
                  color: Colors.green[400],
                ),
                const SizedBox(width: 4),
                Text(
                  'Positive',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green[400],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Negative',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red[400],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.thumb_down,
                  size: 12,
                  color: Colors.red[400],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 8,
            child: Stack(
              children: [
                // Background (negative)
                Container(
                  width: double.infinity,
                  color: Colors.red[900]!.withOpacity(0.3),
                ),
                // Foreground (positive)
                FractionallySizedBox(
                  widthFactor: percentage / 100,
                  child: Container(
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ========================================
  // HELPER METHODS
  // ========================================

  Color _getSentimentColor(int percentage) {
    if (percentage >= 70) return Colors.green;
    if (percentage >= 60) return Colors.lightGreen;
    if (percentage >= 50) return Colors.yellow;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  IconData _getSentimentIcon(int percentage) {
    if (percentage >= 70) return Icons.sentiment_very_satisfied;
    if (percentage >= 60) return Icons.sentiment_satisfied;
    if (percentage >= 50) return Icons.sentiment_neutral;
    if (percentage >= 40) return Icons.sentiment_dissatisfied;
    return Icons.sentiment_very_dissatisfied;
  }
}