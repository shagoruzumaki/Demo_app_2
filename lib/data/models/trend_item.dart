class TrendItem {
  final String id;
  final String title;
  final String category;
  final String? posterUrl;
  final String? description;

  // 🔥 NEW: backend hype (raw map)
  final Map<String, dynamic>? hype;

  TrendItem({
    required this.id,
    required this.title,
    required this.category,
    this.posterUrl,
    this.description,
    this.hype,
  });

  factory TrendItem.fromMap(Map<String, dynamic> map) {
    return TrendItem(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      posterUrl: map['poster_url'],
      description: map['description'],
      hype: map['trend_hype'], // 👈 joined table
    );
  }
}
