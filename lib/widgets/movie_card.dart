import 'package:flutter/material.dart';
import '../models/trend_item.dart';
import '../screens/detail_screen.dart';

class MovieCard extends StatelessWidget {
  final TrendItem item;

  const MovieCard({Key? key, required this.item}) : super(key: key);

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
    final emojiFontSize = cardWidth * 0.35;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(item: item),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: cardHeight,
                  width: cardWidth,
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
                    child: Text(item.emoji, style: TextStyle(fontSize: emojiFontSize)),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.quality,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: LinearProgressIndicator(
                        value: item.hypeLevel / 100,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(_getHypeColor()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              '${item.year}, ${item.duration}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

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
}