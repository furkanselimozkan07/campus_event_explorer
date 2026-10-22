import 'package:flutter/material.dart';
import '../models/event.dart';
import '../utils/event_format.dart';
import 'image_viewer_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final CampusEvent event;
  final void Function(CampusEvent event) onFavoriteToggle;
  final bool Function(CampusEvent event, bool shouldJoin) onParticipationChange;

  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.onFavoriteToggle,
    required this.onParticipationChange,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  void _toggleFavorite() {
    widget.onFavoriteToggle(widget.event);
    setState(() {});
  }

  Future<void> _confirmParticipation() async {
    final joining = !widget.event.isJoined;
    if (joining && widget.event.isFull) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(joining ? 'Join this event?' : 'Cancel participation?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Date: ${formatEventDate(widget.event.dateTime)}'),
            const SizedBox(height: 5),
            Text('Venue: ${widget.event.venue}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    // Both No and tapping outside the dialog leave the state unchanged.
    if (!mounted || confirmed != true) return;

    final changed = widget.onParticipationChange(widget.event, joining);
    if (!changed) return;

    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(joining
            ? 'You joined ${widget.event.title}.'
            : 'Participation cancelled for ${widget.event.title}.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final canJoin = event.isJoined || !event.isFull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          IconButton(
            tooltip: event.isFavorite
                ? 'Remove from favorites'
                : 'Add to favorites',
            onPressed: _toggleFavorite,
            icon: Icon(event.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onDoubleTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ImageViewerScreen(
                      imagePath: event.imagePath,
                      title: event.title,
                    ),
                  ),
                );
              },
              child: Image.asset(
                event.imagePath,
                height: 245,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Text(
                'Double-tap the picture to enlarge it',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 13),
                  _infoRow(Icons.tag, 'Event ID', '${event.id}'),
                  _infoRow(Icons.category_outlined, 'Category', event.category),
                  _infoRow(Icons.schedule, 'Date / Time',
                      formatEventDate(event.dateTime)),
                  _infoRow(Icons.place_outlined, 'Venue', event.venue),
                  _infoRow(Icons.groups_outlined, 'Total capacity',
                      '${event.capacity} students'),
                  _infoRow(Icons.event_seat_outlined, 'Available places',
                      '${event.availablePlaces}'),
                  _infoRow(Icons.favorite_border, 'Favorite',
                      event.isFavorite ? 'Yes' : 'No'),
                  _infoRow(Icons.check_circle_outline, 'Participation',
                      event.isJoined ? 'Joined' : 'Not joined'),
                  const SizedBox(height: 15),
                  Text(
                    'About this event',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(event.description),
                  const SizedBox(height: 18),
                  if (event.isFull && !event.isJoined)
                    const Text(
                      'Full — no places are available.',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: canJoin ? _confirmParticipation : null,
                      icon: Icon(event.isJoined
                          ? Icons.event_busy_outlined
                          : Icons.event_available_outlined),
                      label: Text(event.isJoined
                          ? 'Cancel participation'
                          : event.isFull
                              ? 'Full'
                              : 'Join event'),
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

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.black54)),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
