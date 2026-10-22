# Manual test checklist 
Date tested: 22.10.2026
Tester: Furkan Selim Özkan / Ahmet Enes Şahan
Flutter version / channel: 3.47.6 Stable
Device / emulator: Pixel 7 Android emulator

- [x] Explore initially lists 8 events, with 3 categories and local images.
- [x] Acoustic Music Night shows **Full**; its Join button is disabled.
- [x] Flutter Basics Workshop initially has **exactly 1** spot.
- [x] Search `  FLuTTeR  ` finds the Flutter workshop.
- [x] Search and category filter work at the same time.
- [x] `abcdefgh987` produces a readable empty state and search can be cleared.
- [x] The search/category settings stay the same when switching tabs.
- [x] Tapping a card opens a details page with title, category, date, venue,
      description, capacity, available places, and a favorite control.
- [x] Double-tapping the details image opens a new enlarged-image page.
- [x] Back from image viewer returns to details; Back again returns to list.
- [x] A favorite toggled on a card appears in Favorites.
- [x] A favorite toggled in Details updates Favorites.
- [x] Favorites does not change available places or My Events.
- [x] A join dialog has title, date, venue and No/Yes buttons.
- [x] Tapping No or dismissing a join dialog leaves capacity unchanged.
- [x] Yes joins exactly once, reduces remaining places by one, and shows feedback.
- [x] Joined event appears in My Events; joined count updates.
- [x] Joining the final available spot makes availability 0.
- [x] A student who filled the final spot can still cancel participation.
- [x] Cancel dialog No leaves joined state unchanged.
- [x] Cancel dialog Yes restores exactly one place and removes event from My Events.
- [x] Favorites and My Events show helpful empty states when empty.
- [x] App works without a network connection after installation.

## Screenshots

- [x] `screenshots/01_explore.png` — Explore showing cards and availability.
- [x] `screenshots/02_details.png` — Event Details with data and join button.
- [x] `screenshots/03_favorites.png` — A favorited event on Favorites.
- [x] `screenshots/04_my_events.png` — A joined event on My Events.



