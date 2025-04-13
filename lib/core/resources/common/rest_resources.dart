class NewsRestResources {
  static const String _prefix = 'https://newsapi.org/v2/everything';

  static String getNews(int page, String category) => '$_prefix?q=$category&page=$page&pageSize=20&sortBy=publishedAt';
}
