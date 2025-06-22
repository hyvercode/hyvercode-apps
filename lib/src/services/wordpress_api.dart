import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class WordPressApi {
  // IMPORTANT: Replace this with your actual WordPress site URL
  // Example: 'https://yourwordpresssite.com/wp-json/wp/v2'
  final String baseUrl;

  WordPressApi({this.baseUrl = 'https://hyvercode.com/wp-json/wp/v2'});

  Future<List<Post>> fetchPosts() async {
    // WordPress API endpoint for posts, including featured media details
    final response = await http.get(Uri.parse('$baseUrl/posts?_embed'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
}
