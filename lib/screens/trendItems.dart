import 'package:flutter/material.dart';
import 'package:demo_app_2/Auth/trend_service.dart';
import 'package:demo_app_2/models/trend_item.dart';

class trendItems extends StatefulWidget {
  const trendItems({super.key});

  @override
  State<trendItems> createState() => _trendItemsState();
}

class _trendItemsState extends State<trendItems> {
  late Future<List<TrendItem>> trendFuture;

  @override
  void initState() {
    super.initState();
    trendFuture = TrendItemService().fetchTrendItems();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Items'),
      ),
      body: FutureBuilder<List<TrendItem>>(
        future: trendFuture,
        builder: (context, snapshot) {
          // 1️⃣ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2️⃣ Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // 3️⃣ Data
          final items = snapshot.data!;
          final games =
          items.where((i) => i.category == 'game').toList();

          if (games.isEmpty) {
            return const Center(
              child: Text('No games found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Text(
                    game.emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(game.title),
                  subtitle: Text(
                    'Hype: ${game.hypeLevel}/100',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
