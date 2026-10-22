import 'package:flutter/material.dart';
import '../models/event.dart';
import '../utils/event_format.dart';

// Reusable StatelessWidget used in Explore, Favorites and My Events.
class EventCard extends StatelessWidget {
  final CampusEvent event;
  final VoidCallback onOpen;
  final VoidCallback onFavoriteToggle;

  const EventCard({
    super.key,
    required this.event,
    required this.onOpen,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = eventCategoryColor(event.category);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: onOpen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  event.imagePath,
                  height: 148,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton.filledTonal(
                    tooltip: event.isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                    onPressed: onFavoriteToggle,
                    icon: Icon(event.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event.category,
                          style: TextStyle(
                            color: categoryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        event.availabilityText,
                        style: TextStyle(
                          color: event.isFull && !event.isJoined
                              ? Colors.red.shade700
                              : Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 17),
                      const SizedBox(width: 6),
                      Expanded(child: Text(formatEventDate(event.dateTime))),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 17),
                      const SizedBox(width: 6),
                      Expanded(child: Text(event.venue)),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'View details →',
                      style: TextStyle(color: categoryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
