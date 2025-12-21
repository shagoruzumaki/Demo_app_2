import 'package:flutter/material.dart';
import '../models/trend_item.dart';

class DetailScreen extends StatelessWidget {
  final TrendItem item;

  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalVotes = item.worthVotes + item.overratedVotes;
    final worthPercentage = ((item.worthVotes / totalVotes) * 100).round();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Top App Bar with Poster
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getCategoryColor().withOpacity(0.8),
                      _getCategoryColor(),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    item.emoji,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section with Badges
                  _buildTitleSection(),
                  const SizedBox(height: 20),

                  // Current Hype Level Bar
                  _buildHypeLevel(),
                  const SizedBox(height: 24),

                  // Social Media Sentiment Section
                  _buildSocialSentiment(),
                  const SizedBox(height: 24),

                  // Why Was It Hyped?
                  _buildSection(
                    '🔥 Why Was It Hyped?',
                    item.whyHyped,
                    Colors.yellow[700]!,
                  ),
                  const SizedBox(height: 16),

                  // Is It Worth The Hype?
                  _buildSection(
                    '⭐ Is It Worth The Hype?',
                    item.worthIt,
                    Colors.blue[400]!,
                  ),
                  const SizedBox(height: 24),

                  // Expectation vs Reality Cards
                  _buildExpectationVsReality(),
                  const SizedBox(height: 24),

                  // Our Platform's Statistics
                  _buildPlatformStats(worthPercentage),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================
  // BUILD TITLE SECTION WITH BADGES
  // ========================================
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badges Row
        Row(
          children: [
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getCategoryColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Ratings Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star, size: 14, color: Colors.yellow),
                  SizedBox(width: 4),
                  Text(
                    'Ratings',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Title
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Release Date
        Text(
          item.releaseDate,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // ========================================
  // BUILD CURRENT HYPE LEVEL BAR
  // ========================================
  Widget _buildHypeLevel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current Hype Level',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Icon(
                    item.hypeLevel >= 70
                        ? Icons.trending_up
                        : Icons.trending_down,
                    color: item.hypeLevel >= 70
                        ? Colors.green
                        : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${item.hypeLevel}%',
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

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: item.hypeLevel / 100,
              minHeight: 12,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(_getHypeColor()),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================
  // BUILD SOCIAL MEDIA SENTIMENT SECTION
  // ========================================
  Widget _buildSocialSentiment() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[900]!.withOpacity(0.3),
            Colors.purple[900]!.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          const Row(
            children: [
              Icon(Icons.public, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text(
                'What Social Media Says',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Reddit Card
          _buildSocialCard(
            'Reddit',
            item.redditSentiment,
            Colors.orange,
            'R',
          ),
          const SizedBox(height: 12),

          // YouTube Card
          _buildSocialCard(
            'YouTube',
            item.youtubeSentiment,
            Colors.red,
            '▶',
          ),
          const SizedBox(height: 12),

          // Twitter/X Card
          _buildSocialCard(
            'Twitter/X',
            item.twitterSentiment,
            Colors.blue,
            '𝕏',
          ),
        ],
      ),
    );
  }

  // ========================================
  // BUILD INDIVIDUAL SOCIAL MEDIA CARD
  // ========================================
  Widget _buildSocialCard(
      String platform,
      Map<String, dynamic> data,
      Color color,
      String icon,
      ) {
    // Extract data based on platform
    int positive = 0;
    int negative = 0;
    String topContent = '';

    if (platform == 'Reddit') {
      positive = data['positive'] ?? 0;
      negative = data['negative'] ?? 0;
      topContent = '"${data['topComment']}"';
    } else if (platform == 'YouTube') {
      positive = data['likes'] ?? 0;
      negative = data['dislikes'] ?? 0;
      topContent = '"${data['topComment']}"';
    } else {
      // Twitter
      positive = data['positive'] ?? 0;
      negative = data['negative'] ?? 0;
      topContent = data['hashtag'] ?? '';
    }

    // Calculate percentage
    final total = positive + negative;
    final percentage = total > 0 ? ((positive / total) * 100).round() : 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Platform Header
          Row(
            children: [
              // Platform Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    icon,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Platform Name
              Text(
                platform,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),

              // Percentage
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _getSentimentColor(percentage.toDouble()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Top Comment or Hashtag
          Text(
            topContent,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Discussion Count
          if (platform == 'Reddit')
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${data['positive'] + data['negative']} discussions',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),

          if (platform == 'YouTube')
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${data['videoCount']} videos analyzed',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ========================================
  // BUILD SECTION (WHY HYPED / WORTH IT)
  // ========================================
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
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ========================================
  // BUILD EXPECTATION VS REALITY CARDS
  // ========================================
  Widget _buildExpectationVsReality() {
    return Row(
      children: [
        // Expectation Card
        Expanded(
          child: _buildExpectationCard(
            'Expectation',
            item.expectation,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),

        // Reality Card
        Expanded(
          child: _buildExpectationCard(
            'Reality',
            item.reality,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildExpectationCard(String label, String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
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
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ========================================
  // BUILD PLATFORM STATISTICS
  // ========================================
  Widget _buildPlatformStats(int worthPercentage) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Platform\'s Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Vote Statistics Row
          Row(
            children: [
              // Worth the Hype
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[900]!.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$worthPercentage%',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const Text(
                        'Worth the Hype',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item.worthVotes} votes',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Overrated
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[900]!.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${100 - worthPercentage}%',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                        'Overrated',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item.overratedVotes} votes',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
  // HELPER METHODS FOR COLORS
  // ========================================

  Color _getCategoryColor() {
    switch (item.category) {
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

  Color _getHypeColor() {
    if (item.hypeLevel >= 70) return Colors.green;
    if (item.hypeLevel >= 50) return Colors.yellow;
    if (item.hypeLevel >= 30) return Colors.orange;
    return Colors.red;
  }

  Color _getSentimentColor(double percentage) {
    if (percentage >= 60) return Colors.green;
    if (percentage >= 40) return Colors.yellow;
    return Colors.red;
  }
}