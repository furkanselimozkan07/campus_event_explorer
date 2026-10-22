import 'package:flutter/material.dart';
import '../data/event_data.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'event_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CampusEvent> _events = createDemoEvents();
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = const [
    'All',
    'Technology',
    'Arts',
    'Sports',
  ];

  String _selectedCategory = 'All';
  int _selectedTab = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _joinedCount => _events.where((event) => event.isJoined).length;

  List<CampusEvent> get _eventsForCurrentTab {
    if (_selectedTab == 1) {
      return _events.where((event) => event.isFavorite).toList();
    }
    if (_selectedTab == 2) {
      return _events.where((event) => event.isJoined).toList();
    }
    return _events;
  }

  List<CampusEvent> _applySearchAndCategory(List<CampusEvent> events) {
    final query = _searchController.text.trim().toLowerCase();

    return events.where((event) {
      final titleMatches = event.title.toLowerCase().contains(query);
      final categoryMatches =
          _selectedCategory == 'All' || event.category == _selectedCategory;
      return titleMatches && categoryMatches;
    }).toList();
  }

  void _toggleFavorite(CampusEvent event) {
    setState(() {
      event.isFavorite = !event.isFavorite;
    });
  }

  // Returning false prevents duplicate joins or invalid cancellations.
  bool _changeParticipation(CampusEvent event, bool shouldJoin) {
    if (shouldJoin) {
      if (event.isJoined || event.availablePlaces == 0) return false;
      setState(() {
        event.isJoined = true;
        event.availablePlaces--;
      });
    } else {
      if (!event.isJoined) return false;
      setState(() {
        event.isJoined = false;
        event.availablePlaces++;
      });
    }
    return true;
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _selectedCategory = 'All';
    });
  }

  Future<void> _openDetails(CampusEvent event) async {
    FocusScope.of(context).unfocus();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EventDetailsScreen(
          event: event,
          onFavoriteToggle: _toggleFavorite,
          onParticipationChange: _changeParticipation,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final baseEvents = _eventsForCurrentTab;
    final filteredEvents = _applySearchAndCategory(baseEvents);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Event Explorer'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Text(
                'Joined: $_joinedCount',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 9, 16, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    textInputAction: TextInputAction.search,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search events by title',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close),
                            ),
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: _selectedCategory == category,
                            onSelected: (_) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    filteredEvents.length == 1
                        ? '1 matching event'
                        : '${filteredEvents.length} matching events',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredEvents.isEmpty
                  ? _buildEmptyState(baseEvents.isEmpty)
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = filteredEvents[index];
                        return EventCard(
                          key: ValueKey(event.id),
                          event: event,
                          onOpen: () => _openDetails(event),
                          onFavoriteToggle: () => _toggleFavorite(event),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          FocusScope.of(context).unfocus();
          setState(() {
            _selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            activeIcon: Icon(Icons.event_note),
            label: 'My Events',
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool tabHasNoEvents) {
    String message;
    if (tabHasNoEvents && _selectedTab == 1) {
      message = 'No favorites yet. Tap a heart to save an event.';
    } else if (tabHasNoEvents && _selectedTab == 2) {
      message = 'You have not joined any events yet.';
    } else {
      message = 'No events found. Try a different title or category.';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.event_busy_outlined, size: 52),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            if (_searchController.text.isNotEmpty ||
                _selectedCategory != 'All') ...[
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: _clearFilters,
                child: const Text('Clear search and filters'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
