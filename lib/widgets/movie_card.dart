import 'package:flutter/material.dart';
import '../data/models/trend_item.dart';
import '../screens/detail_screen.dart';

class MovieCard extends StatelessWidget {
  final TrendItem item;

  const MovieCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double cardWidth;
    if (screenWidth < 600) {
      cardWidth = screenWidth / 2.5;
    } else if (screenWidth < 900) {
      cardWidth = screenWidth / 4;
    } else {
      cardWidth = screenWidth / 6;
    }

    final cardHeight = cardWidth * 1.5;

    // Get hype from backend
    final hype = item.hype;
    final hypeLevel = hype?['hype_level'] ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item: item,
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image Stack
            Stack(
              children: [
                // Main Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: item.posterUrl != null && item.posterUrl!.isNotEmpty
                      ? Image.network(
                    item.posterUrl!,
                    height: cardHeight,
                    width: cardWidth,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: cardHeight,
                        width: cardWidth,
                        color: Colors.grey[800],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                            color: const Color(0xFF8B5CF6),
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return _buildFallbackPoster(cardHeight, cardWidth);
                    },
                  )
                      : _buildFallbackPoster(cardHeight, cardWidth),
                ),

                // Quality Badge (Top Right)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Hype Level Indicator (Center - Optional)
                if (hype != null && hypeLevel >= 80)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.whatshot, size: 12, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'HOT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Hype Level Bar (Bottom)
                if (hype != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        child: LinearProgressIndicator(
                          value: hypeLevel / 100,
                          backgroundColor: Colors.grey[800],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getHypeColor(hypeLevel),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Title
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 2),

            // Hype Level Text
            if (hype != null)
              Row(
                children: [
                  Text(
                    'Hype: ',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    '$hypeLevel%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _getHypeColor(hypeLevel),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    hypeLevel >= 70
                        ? Icons.trending_up
                        : Icons.trending_down,
                    size: 14,
                    color: _getHypeColor(hypeLevel),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Fallback poster with gradient and emoji
  Widget _buildFallbackPoster(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCategoryColor().withOpacity(0.8),
            _getCategoryColor(),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          _getCategoryEmoji(),
          style: TextStyle(fontSize: width * 0.4),
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (item.category.toLowerCase()) {
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
    switch (item.category.toLowerCase()) {
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
}