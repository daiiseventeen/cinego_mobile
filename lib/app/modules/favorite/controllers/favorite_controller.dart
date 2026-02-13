import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final favorites = <FavoriteMovie>[].obs;
  final selectedGenre = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    // Dummy data for UI demonstration
    favorites.value = [
      FavoriteMovie(
        id: '1',
        title: 'The Matrix Reloaded',
        genre: 'Sci-Fi',
        rating: 4.9,
        image:
            'https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=2070&auto=format&fit=crop',
        releaseDate: '14 Feb 2026',
      ),
      FavoriteMovie(
        id: '2',
        title: 'Avatar: The Way of Water',
        genre: 'Sci-Fi',
        rating: 4.8,
        image:
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=2094&auto=format&fit=crop',
        releaseDate: '15 Feb 2026',
      ),
      FavoriteMovie(
        id: '3',
        title: "Oppenheimer",
        genre: 'Drama',
        rating: 4.7,
        image:
            'https://images.unsplash.com/photo-1585647347483-22b66260dfff?q=80&w=2070&auto=format&fit=crop',
        releaseDate: '10 Feb 2026',
      ),
      FavoriteMovie(
        id: '4',
        title: 'Joker: Folie à Deux',
        genre: 'Thriller',
        rating: 4.6,
        image:
            'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1925&auto=format&fit=crop',
        releaseDate: '20 Feb 2026',
      ),
      FavoriteMovie(
        id: '5',
        title: 'Gladiator II',
        genre: 'Action',
        rating: 4.5,
        image:
            'https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=2059&auto=format&fit=crop',
        releaseDate: '18 Feb 2026',
      ),
      FavoriteMovie(
        id: '6',
        title: 'Dune: Part Two',
        genre: 'Sci-Fi',
        rating: 4.8,
        image:
            'https://images.unsplash.com/photo-1519330379827-4e5e6b34e3e8?q=80&w=2070&auto=format&fit=crop',
        releaseDate: '12 Feb 2026',
      ),
    ];
  }

  void filterByGenre(String genre) {
    selectedGenre.value = genre;
  }

  void removeFavorite(String id) {
    favorites.removeWhere((movie) => movie.id == id);
  }
}

class FavoriteMovie {
  final String id;
  final String title;
  final String genre;
  final double rating;
  final String image;
  final String releaseDate;

  FavoriteMovie({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    required this.image,
    required this.releaseDate,
  });
}
