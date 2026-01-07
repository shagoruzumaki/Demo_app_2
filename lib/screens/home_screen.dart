import 'package:flutter/material.dart';
import '../data/models/trend_item.dart';
import '../data/services/trend_service.dart';
import 'detail_screen.dart';
import 'profile_screen_for_auth.dart';
import 'profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TrendService _trendService = TrendService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Beautiful App Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: const Color(0xFF1F2937),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.trending_up_rounded, color: Color(0xFF8B5CF6)),
                  const SizedBox(width: 8),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                    ).createShader(bounds),
                    child: const Text(
                      'Trend Evaluator',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1F2937), Color(0xFF111827)],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {
                  final user = Supabase.instance.client.auth.currentUser;

                  if (user != null) {
                    // User is logged in Go to Profile
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  } else {
                    // User not logged  Go to Auth
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const profileForAuth()),
                    );
                  }
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movies Section
                FutureBuilder<List<TrendItem>>(
                  future: _trendService.fetchByCategoryWithHype('movie'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(50.0),
                          child: CircularProgressIndicator(
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red, size: 60),
                              const SizedBox(height: 16),
                              Text(
                                'Failed to load movies',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return _CategoryCarousel(
                      categoryTitle: 'Movies',
                      categoryIcon: Icons.movie_rounded,
                      items: snapshot.data!,
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Series Section
                FutureBuilder<List<TrendItem>>(
                  future: _trendService.fetchByCategoryWithHype('series'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(50.0),
                          child: CircularProgressIndicator(
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red, size: 60),
                              const SizedBox(height: 16),
                              Text(
                                'Failed to load series',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return _CategoryCarousel(
                      categoryTitle: 'Series',
                      categoryIcon: Icons.tv_rounded,
                      items: snapshot.data!,
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Games Section
                FutureBuilder<List<TrendItem>>(
                  future: _trendService.fetchByCategoryWithHype('game'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(50.0),
                          child: CircularProgressIndicator(
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red, size: 60),
                              const SizedBox(height: 16),
                              Text(
                                'Failed to load games',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return _CategoryCarousel(
                      categoryTitle: 'Games',
                      categoryIcon: Icons.games_rounded,
                      items: snapshot.data!,
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Apps Section
                FutureBuilder<List<TrendItem>>(
                  future: _trendService.fetchByCategoryWithHype('app'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(50.0),
                          child: CircularProgressIndicator(
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red, size: 60),
                              const SizedBox(height: 16),
                              Text(
                                'Failed to load apps',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return _CategoryCarousel(
                      categoryTitle: 'Apps',
                      categoryIcon: Icons.phone_android_rounded,
                      items: snapshot.data!,
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================
// CATEGORY CAROUSEL WIDGET
// ========================================
class _CategoryCarousel extends StatelessWidget {
  final String categoryTitle;
  final IconData categoryIcon;
  final List<TrendItem> items;

  const _CategoryCarousel({
    required this.categoryTitle,
    required this.categoryIcon,
    required this.items,
  });

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
            ],
          ),
        ),

        // Horizontal Scrollable Carousel
        SizedBox(
          height: sectionHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _TrendItemCard(item: items[index]);
            },
          ),
        ),
      ],
    );
  }
}

// ========================================
// TREND ITEM CARD
// ========================================
class _TrendItemCard extends StatelessWidget {
  final TrendItem item;

  const _TrendItemCard({required this.item});

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

    // Get hype level from backend
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
            // Poster Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: item.posterUrl != null
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
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
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
                          child: Text(
                            _getCategoryEmoji(),
                            style: TextStyle(fontSize: cardWidth * 0.4),
                          ),
                        ),
                      );
                    },
                  )
                      : Container(
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
                      child: Text(
                        _getCategoryEmoji(),
                        style: TextStyle(fontSize: cardWidth * 0.4),
                      ),
                    ),
                  ),
                ),

                // Quality Badge
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
                      item.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Hype Level Bar
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

            // Hype Level
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
                ],
              ),
          ],
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