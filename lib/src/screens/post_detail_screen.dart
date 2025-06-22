import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../models/post.dart';
import 'package:intl/intl.dart'; // Add intl dependency to pubspec.yaml

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // Format the date
    String formattedDate;
    try {
      final dateTime = DateTime.parse(post.date);
      formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    } catch (e) {
      formattedDate = post.date; // Fallback if date parsing fails
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.featuredImageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  post.featuredImageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16.0),
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            const Divider(height: 30, thickness: 1),
            // Use HtmlWidget to render HTML content
            HtmlWidget(
              post.content,
              textStyle: const TextStyle(fontSize: 16),
              // You can add custom styling for HTML tags here if needed
              // e.g., customStylesBuilder: (element) { ... }
            ),
          ],
        ),
      ),
    );
  }
}