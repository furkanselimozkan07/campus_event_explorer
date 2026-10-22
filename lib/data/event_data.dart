import '../models/event.dart';

// Fictional events. All dates are after the assignment deadline (25 Oct 2026).
List<CampusEvent> createDemoEvents() {
  return [
    CampusEvent(
      id: 1,
      title: 'AI and Careers Talk',
      category: 'Technology',
      dateTime: DateTime(2026, 11, 3, 14, 0),
      venue: 'Engineering Hall A101',
      description:
          'Meet student developers and discuss how artificial intelligence '
          'is changing internships, projects and career opportunities.',
      imagePath: 'assets/images/technology.png',
      capacity: 40,
      availablePlaces: 18,
    ),
    CampusEvent(
      id: 2,
      title: 'Flutter Basics Workshop',
      category: 'Technology',
      dateTime: DateTime(2026, 11, 6, 13, 30),
      venue: 'Computer Lab B204',
      description:
          'Build your first mobile screen with Flutter widgets. Bring your '
          'laptop and try simple layouts and buttons.',
      imagePath: 'assets/images/technology.png',
      capacity: 20,
      availablePlaces: 1,
    ),
    CampusEvent(
      id: 3,
      title: 'Cybersecurity Meetup',
      category: 'Technology',
      dateTime: DateTime(2026, 11, 12, 16, 0),
      venue: 'Technology Center Room 3',
      description:
          'Join a friendly discussion about online safety, passwords and '
          'student cybersecurity projects.',
      imagePath: 'assets/images/technology.png',
      capacity: 35,
      availablePlaces: 12,
    ),
    CampusEvent(
      id: 4,
      title: 'Student Art Exhibition',
      category: 'Arts',
      dateTime: DateTime(2026, 11, 4, 11, 0),
      venue: 'Campus Art Gallery',
      description:
          'Explore drawings, paintings and photographs made by university '
          'students, and talk to the artists about their work.',
      imagePath: 'assets/images/arts.png',
      capacity: 60,
      availablePlaces: 24,
    ),
    CampusEvent(
      id: 5,
      title: 'Acoustic Music Night',
      category: 'Arts',
      dateTime: DateTime(2026, 11, 9, 19, 0),
      venue: 'Student Center Stage',
      description:
          'Listen to acoustic performances by campus musicians. This event '
          'starts full, so new students cannot join until a spot opens.',
      imagePath: 'assets/images/arts.png',
      capacity: 30,
      availablePlaces: 0,
    ),
    CampusEvent(
      id: 6,
      title: 'Photography Walk',
      category: 'Arts',
      dateTime: DateTime(2026, 11, 16, 15, 0),
      venue: 'Main Library Entrance',
      description:
          'Walk around campus with other photography enthusiasts and '
          'practice framing, light and storytelling.',
      imagePath: 'assets/images/arts.png',
      capacity: 25,
      availablePlaces: 10,
    ),
    CampusEvent(
      id: 7,
      title: 'Campus Basketball Game',
      category: 'Sports',
      dateTime: DateTime(2026, 11, 7, 17, 0),
      venue: 'Indoor Sports Hall',
      description:
          'Take part in a friendly basketball game organized for students '
          'of all skill levels.',
      imagePath: 'assets/images/sports.png',
      capacity: 24,
      availablePlaces: 7,
    ),
    CampusEvent(
      id: 8,
      title: 'Morning Yoga Session',
      category: 'Sports',
      dateTime: DateTime(2026, 11, 11, 9, 0),
      venue: 'Green Campus Lawn',
      description:
          'Start the day with simple stretching, breathing and a relaxed '
          'outdoor yoga session. Beginners are welcome.',
      imagePath: 'assets/images/sports.png',
      capacity: 28,
      availablePlaces: 15,
    ),
  ];
}
