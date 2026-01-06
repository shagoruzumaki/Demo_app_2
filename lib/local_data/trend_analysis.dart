class TrendAnalysis {
  final String itemId; // IMPORTANT: link to TrendItem.id

  final Map<String, dynamic> redditSentiment;
  final Map<String, dynamic> twitterSentiment;
  final Map<String, dynamic> youtubeSentiment;

  final int hypeLevel; // 0–100

  final String whyHyped;
  final String expectation;
  final String reality;
  final String worthIt;

  TrendAnalysis({
    required this.itemId,
    required this.redditSentiment,
    required this.twitterSentiment,
    required this.youtubeSentiment,
    required this.hypeLevel,
    required this.whyHyped,
    required this.expectation,
    required this.reality,
    required this.worthIt,
  });
}
