import 'package:flutter/material.dart';
import 'package:football_news/screens/login.dart';  // Add this import
import 'package:pbp_django_auth/pbp_django_auth.dart';  // Add this import
import 'package:provider/provider.dart';  // Add this import
import 'package:football_news/screens/news_entry_list.dart';  // Ensure correct import

class NewsCard extends StatelessWidget {
  final String title;
  final String summary;
  final String category;
  final String? thumbnailUrl;
  final bool isFeatured;
  final VoidCallback? onTap;

  const NewsCard({
    super.key,
    required this.title,
    required this.summary,
    required this.category,
    this.thumbnailUrl,
    this.isFeatured = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();  // Add CookieRequest here
    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: scheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          if (onTap != null) {
            onTap!();
          } else if (title == "See Football News") {
            // Ensure this navigation works properly
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsEntryListPage(),
              ),
            );
          } else if (title == "Logout") {
            // Perform logout when the user taps on the logout option
            final response = await request.logout(
                "http://localhost:8000/auth/logout/"); 
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message See you again, $uname."),
                ));
                // Navigate back to the login page after successful logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: (thumbnailUrl != null && thumbnailUrl!.isNotEmpty)
                    ? Image.network(
                        thumbnailUrl!,
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _fallbackThumb(scheme),
                      )
                    : _fallbackThumb(scheme),
              ),
              const SizedBox(width: 12),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category + featured
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: scheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category[0].toUpperCase() + category.substring(1),
                            style: TextStyle(
                              color: scheme.onSecondaryContainer,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isFeatured) ...[
                          const SizedBox(width: 6),
                          Icon(Icons.star_rounded,
                              size: 18, color: scheme.tertiary),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fallbackThumb(ColorScheme scheme) {
    return Container(
      width: 84,
      height: 84,
      color: scheme.secondaryContainer,
      child: Icon(Icons.image, color: scheme.onSecondaryContainer),
    );
  }
}
