class CampusEvent {
  final int id;
  final String title;
  final String category;
  final DateTime dateTime;
  final String venue;
  final String description;
  final String imagePath;
  final int capacity;

  int availablePlaces;
  bool isFavorite;
  bool isJoined;

  CampusEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.dateTime,
    required this.venue,
    required this.description,
    required this.imagePath,
    required this.capacity,
    required this.availablePlaces,
    this.isFavorite = false,
    this.isJoined = false,
  })  : assert(capacity > 0),
        assert(availablePlaces >= 0),
        assert(availablePlaces <= capacity);

  bool get isFull => availablePlaces == 0;

  String get availabilityText {
    if (isJoined) return 'Joined • $availablePlaces spots left';
    if (isFull) return 'Full';
    if (availablePlaces == 1) return 'Only 1 spot left';
    return '$availablePlaces spots left';
  }
}
