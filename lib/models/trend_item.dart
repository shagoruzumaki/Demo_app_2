import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:demo_app_2/Auth/trend_service.dart';

class TrendItem {
  final String id;
  final String title;
  final String category; // movie, series, game, app
  final String year;
  final String duration;
  final String quality;
  final String emoji;
  final int hypeLevel; // 0-100
  final String releaseDate;

  // Social sentiment
  final Map<String, dynamic> redditSentiment;
  final Map<String, dynamic> youtubeSentiment;
  final Map<String, dynamic> twitterSentiment;

  // Analysis
  final String whyHyped;
  final String worthIt;
  final String expectation;
  final String reality;

  // Platform data
  final int worthVotes;
  final int overratedVotes;

  TrendItem({
    required this.id,
    required this.title,
    required this.category,
    required this.year,
    required this.duration,
    required this.quality,
    required this.emoji,
    required this.hypeLevel,
    required this.releaseDate,
    required this.redditSentiment,
    required this.youtubeSentiment,
    required this.twitterSentiment,
    required this.whyHyped,
    required this.worthIt,
    required this.expectation,
    required this.reality,
    required this.worthVotes,
    required this.overratedVotes,
  });
  factory TrendItem.fromJson(Map<String, dynamic> json) {
    return TrendItem(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      year: json['year'],
      duration: json['duration'],
      quality: json['quality'],
      emoji: json['emoji'],
      hypeLevel: json['hype_level'],
      releaseDate: json['release_date'],
      redditSentiment: json['reddit_sentiment'] ?? {},
      youtubeSentiment: json['youtube_sentiment'] ?? {},
      twitterSentiment: json['twitter_sentiment'] ?? {},
      whyHyped: json['why_hyped'],
      worthIt: json['worth_it'],
      expectation: json['expectation'],
      reality: json['reality'],
      worthVotes: json['worth_votes'] ?? 0,
      overratedVotes: json['overrated_votes'] ?? 0,
    );
  }

}



// Sample data
final List<TrendItem> allTrendingItems = [
  // GAMES
  TrendItem(
    id: '1',
    title: "Baldur's Gate 3",
    category: 'game',
    year: '2023',
    duration: 'RPG',
    quality: 'PC/Console',
    emoji: '🎮',
    hypeLevel: 94,
    releaseDate: 'Aug 2023',
    redditSentiment: {
      'positive': 9379,
      'negative': 456,
      'topComment': 'This is what RPGs should be. Every choice matters.',
      'subreddit': 'r/BaldursGate3'
    },
    youtubeSentiment: {
      'likes': 45000,
      'dislikes': 890,
      'topComment': 'GOTY and it\'s not even close',
      'videoCount': 3400
    },
    twitterSentiment: {
      'positive': 67000,
      'negative': 3200,
      'hashtag': '#BG3'
    },
    whyHyped: "Larian Studios reputation, D&D 5e license, early access feedback, massive scope, 'every choice matters' promise",
    worthIt: "Absolutely YES - Rare case where reality exceeded hype. Universally praised across all platforms. GOTY quality confirmed by both critics and players.",
    expectation: "Deep RPG, meaningful choices, polished gameplay",
    reality: "Exceeded expectations, GOTY quality, massive content",
    worthVotes: 8421,
    overratedVotes: 234,
  ),
  TrendItem(
    id: '2',
    title: 'Skull and Bones',
    category: 'game',
    year: '2024',
    duration: 'AAA',
    quality: 'PC/Console',
    emoji: '🏴‍☠️',
    hypeLevel: 45,
    releaseDate: 'Feb 2024',
    redditSentiment: {
      'positive': 234,
      'negative': 1456,
      'topComment': '10 years for a live service grind fest',
      'subreddit': 'r/gaming'
    },
    youtubeSentiment: {
      'likes': 2400,
      'dislikes': 8900,
      'topComment': 'Looks beautiful but gameplay feels empty',
      'videoCount': 127
    },
    twitterSentiment: {
      'positive': 1200,
      'negative': 4500,
      'hashtag': '#SkullAndBonesDisappointment'
    },
    whyHyped: "Ubisoft's AAA budget, 10 years in development, gorgeous graphics, 'AAAA game' marketing claim",
    worthIt: "No - Repetitive missions, shallow combat, feels like a \$70 mobile game. The hype was built on marketing, not substance.",
    expectation: "Epic pirate battles, massive open world, next-gen naval combat",
    reality: "Repetitive gameplay, limited content, feels like a mobile game",
    worthVotes: 234,
    overratedVotes: 892,
  ),

  // SERIES
  TrendItem(
    id: '3',
    title: 'The Acolyte',
    category: 'series',
    year: '2024',
    duration: '8 Episodes',
    quality: 'WEB-DL',
    emoji: '⭐',
    hypeLevel: 38,
    releaseDate: 'Jun 2024',
    redditSentiment: {
      'positive': 445,
      'negative': 723,
      'topComment': 'Lore breaks and bad writing ruined it',
      'subreddit': 'r/StarWars'
    },
    youtubeSentiment: {
      'likes': 3200,
      'dislikes': 12000,
      'topComment': 'Great visuals, terrible story decisions',
      'videoCount': 234
    },
    twitterSentiment: {
      'positive': 8900,
      'negative': 15600,
      'hashtag': '#TheAcolyte'
    },
    whyHyped: "Star Wars IP, Disney+ exclusive, influencer early access, 'fresh perspective' marketing",
    worthIt: "Divisive - Fans are split. Production quality is high, but story choices alienated core fanbase.",
    expectation: "Fresh Star Wars story, deep lore exploration, strong characters",
    reality: "Divisive writing, pacing issues, mixed character development",
    worthVotes: 445,
    overratedVotes: 723,
  ),

  // MOVIES
  TrendItem(
    id: '4',
    title: 'Dhurandhar',
    category: 'movie',
    year: '2025',
    duration: '214 Min',
    quality: 'TELECINE',
    emoji: '🎬',
    hypeLevel: 85,
    releaseDate: '2025',
    redditSentiment: {
      'positive': 678,
      'negative': 234,
      'topComment': 'Visually stunning, great action sequences',
      'subreddit': 'r/movies'
    },
    youtubeSentiment: {
      'likes': 12000,
      'dislikes': 3400,
      'topComment': 'Best Indian action film this year',
      'videoCount': 89
    },
    twitterSentiment: {
      'positive': 23000,
      'negative': 5600,
      'hashtag': '#Dhurandhar'
    },
    whyHyped: "Big budget production, star cast, massive marketing campaign",
    worthIt: "Mixed - Great visuals and action, but story could be stronger. Worth watching for the spectacle.",
    expectation: "Epic action drama with strong narrative",
    reality: "Great action, decent story, impressive cinematography",
    worthVotes: 2341,
    overratedVotes: 892,
  ),

  // APPS
  TrendItem(
    id: '5',
    title: 'BeReal',
    category: 'app',
    year: '2022',
    duration: 'Social',
    quality: 'iOS/Android',
    emoji: '📸',
    hypeLevel: 28,
    releaseDate: '2020',
    redditSentiment: {
      'positive': 312,
      'negative': 1204,
      'topComment': 'Novelty wore off fast, nobody uses it anymore',
      'subreddit': 'r/apps'
    },
    youtubeSentiment: {
      'likes': 4500,
      'dislikes': 8900,
      'topComment': 'Was fun for a month, now it\'s dead',
      'videoCount': 56
    },
    twitterSentiment: {
      'positive': 8900,
      'negative': 23000,
      'hashtag': '#BeReal'
    },
    whyHyped: "Anti-Instagram concept, Gen-Z appeal, viral growth, 'authentic' social media promise",
    worthIt: "No - The novelty wore off quickly. Friends stopped posting. Became just another notification to ignore.",
    expectation: "Authentic social media, no filters, genuine connections",
    reality: "Novelty wore off, friends stopped posting, became another chore",
    worthVotes: 312,
    overratedVotes: 1204,
  ),
];