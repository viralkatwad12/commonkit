import 'package:flutter/widgets.dart';

/// A helper class for managing network image caching in Flutter.
/// Provides methods to preload and clear cached images.
class ImageCacheHelper {
  /// Preloads a network image from [url] into the app's image cache.
  /// Requires a [context] to access the widget tree's image cache.
  /// Useful for improving performance by loading images before display.
  static Future<void> preloadImage(String url, BuildContext context) async {
    // Create a NetworkImage provider for the given URL
    final imageProvider = NetworkImage(url);
    // Preload the image into the cache using the provided context
    await precacheImage(imageProvider, context);
  }

  /// Removes a specific network image from the cache using its [url].
  /// Helps free up memory when an image is no longer needed.
  static void clearImageCache(String url) {
    // Evict the image from the global image cache
    imageCache.evict(NetworkImage(url));
  }
}