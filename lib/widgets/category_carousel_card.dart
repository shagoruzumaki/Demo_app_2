import 'package:flutter/material.dart';
import '../data/models/trend_item.dart';
import '../screens/see_all_screen.dart';
import 'movie_card.dart';

class CategoryCarousel extends StatelessWidget {
  final String categoryTitle;
  final IconData categoryIcon;
  final List<TrendItem> items;

  const CategoryCarousel({
    Key? key,
    required this.categoryTitle,
    required this.categoryIcon,
    required this.items,
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

    final sectionHeight = (cardWidth * 1.5) + 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(categoryIcon, color: const Color(0xFF8B5CF6), size: 24),
              const SizedBox(width: 8),
              Text(
                categoryTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Get category from title
                  String category = categoryTitle.toLowerCase();
                  if (category == 'series') {
                    category = 'series';
                  } else if (category == 'games') {
                    category = 'game';
                  } else if (category == 'apps') {
                    category = 'app';
                  } else if (category == 'movies') {
                    category = 'movie';
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeAllScreen(
                        category: category,
                        categoryTitle: categoryTitle,
                        categoryIcon: categoryIcon,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal Scrollable Carousel
        SizedBox(
          height: sectionHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return MovieCard(
                item: item,
              );
            },
          ),
        ),
      ],
    );
  }
}