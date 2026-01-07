import 'package:flutter/material.dart';
import '../data/models/trend_item.dart';
import '../data/services/trend_service.dart';
import '../widgets/movie_card.dart';

class SeeAllScreen extends StatefulWidget {
  final String category;
  final String categoryTitle;
  final IconData categoryIcon;

  const SeeAllScreen({
    Key? key,
    required this.category,
    required this.categoryTitle,
    required this.categoryIcon,
  }) : super(key: key);

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final TrendService _trendService = TrendService();
  String _sortBy = 'hype'; // 'hype', 'title', 'newest'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2937),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.categoryIcon, color: const Color(0xFF8B5CF6)),
            const SizedBox(width: 8),
            Text(
              widget.categoryTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'hype',
                child: Text('Sort by Hype'),
              ),
              const PopupMenuItem(
                value: 'title',
                child: Text('Sort by Title'),
              ),
              const PopupMenuItem(
                value: 'newest',
                child: Text('Sort by Newest'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1F2937), Color(0xFF111827)],
          ),
        ),
        child: FutureBuilder<List<TrendItem>>(
          future: _trendService.fetchByCategoryWithHype(widget.category),
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF8B5CF6),
                ),
              );
            }

            // Error
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load ${widget.categoryTitle.toLowerCase()}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => setState(() {}),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // Empty
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.categoryIcon,
                      size: 80,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No ${widget.categoryTitle.toLowerCase()} found',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Sort items
            final items = _sortItems(snapshot.data!);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with count
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '${items.length} ${widget.categoryTitle}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF8B5CF6),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _getSortLabel(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8B5CF6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Grid view
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(context),
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return MovieCard(item: items[index]);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<TrendItem> _sortItems(List<TrendItem> items) {
    final sortedItems = List<TrendItem>.from(items);

    switch (_sortBy) {
      case 'hype':
        sortedItems.sort((a, b) {
          final aHype = a.hype?['hype_level'] ?? 0;
          final bHype = b.hype?['hype_level'] ?? 0;
          return bHype.compareTo(aHype); // Descending
        });
        break;
      case 'title':
        sortedItems.sort((a, b) => a.title.compareTo(b.title)); // Ascending
        break;
      case 'newest':
      // Assuming items are already sorted by created_at from backend
        break;
    }

    return sortedItems;
  }

  String _getSortLabel() {
    switch (_sortBy) {
      case 'hype':
        return 'Sorted by Hype';
      case 'title':
        return 'Sorted by Title';
      case 'newest':
        return 'Sorted by Newest';
      default:
        return 'Sorted';
    }
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 2; // Mobile
    } else if (width < 900) {
      return 3; // Tablet
    } else {
      return 4; // Desktop
    }
  }
}