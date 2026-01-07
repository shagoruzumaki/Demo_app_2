import 'package:flutter/material.dart';
import '../data/models/trend_item.dart';
import '../data/services/trend_service.dart';
import '../widgets/category_carousel_card.dart';
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  } else {
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

                    return CategoryCarousel(
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

                    return CategoryCarousel(
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

                    return CategoryCarousel(
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

                    return CategoryCarousel(
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