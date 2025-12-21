import 'package:flutter/material.dart';
import '../models/trend_item.dart';
import '../widgets/category_carousel_card.dart';
import 'profile_screen.dart';
import 'profile_screen_for_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movies = allTrendingItems.where((i) => i.category == 'movie').toList();
    final series = allTrendingItems.where((i) => i.category == 'series').toList();
    final games = allTrendingItems.where((i) => i.category == 'game').toList();
    final apps = allTrendingItems.where((i) => i.category == 'app').toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
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
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const profileForAuth()),
                    );
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (movies.isNotEmpty)
                    CategoryCarousel(
                      title: 'Movies',
                      icon: Icons.movie_rounded,
                      items: movies,
                    ),
                  const SizedBox(height: 20),
                  if (series.isNotEmpty)
                    CategoryCarousel(
                      title: 'Series',
                      icon: Icons.tv_rounded,
                      items: series,
                    ),
                  const SizedBox(height: 20),
                  if (games.isNotEmpty)
                    CategoryCarousel(
                      title: 'Games',
                      icon: Icons.games_rounded,
                      items: games,
                    ),
                  const SizedBox(height: 20),
                  if (apps.isNotEmpty)
                    CategoryCarousel(
                      title: 'Apps',
                      icon: Icons.phone_android_rounded,
                      items: apps,
                    ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}