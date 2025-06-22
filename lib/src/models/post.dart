class Post {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final String? featuredImageUrl;
  final String date;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    this.featuredImageUrl,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // Helper to safely extract content and excerpt without HTML tags
    String stripHtml(String htmlString) {
      final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
      return htmlString.replaceAll(exp, '');
    }

    // Safely get the featured image URL
    String? getFeaturedImageUrl(Map<String, dynamic> json) {
      if (json['_embedded'] != null && json['_embedded']['wp:featuredmedia'] != null &&
          json['_embedded']['wp:featuredmedia'].isNotEmpty) {
        final media = json['_embedded']['wp:featuredmedia'][0];
        if (media['media_details'] != null && media['media_details']['sizes'] != null) {
          // Try to get a larger size, fallback to full
          return media['media_details']['sizes']['medium_large']?['source_url'] ??
              media['media_details']['sizes']['large']?['source_url'] ??
              media['media_details']['sizes']['full']?['source_url'];
        }
      }
      return null;
    }

    return Post(
      id: json['id'] as int,
      title: stripHtml(json['title']['rendered'] as String), // Remove HTML from title
      content: json['content']['rendered'] as String,
      excerpt: stripHtml(json['excerpt']['rendered'] as String), // Remove HTML from excerpt
      featuredImageUrl: getFeaturedImageUrl(json),
      date: json['date'] as String,
    );
  }
}