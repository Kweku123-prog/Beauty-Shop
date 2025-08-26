Beauty Marketplace App — Feature Design Brief
1. Assumptions
•	Platforms: iOS & Android (phones only, tablet ).
•	Min SDKs: Android 7.0 (API 24+), iOS 13+.
•	Themes: Full light & dark theme support.
•	Connectivity: Online-first experience with limited offline caching 
•	User Types: Client (discover/book) 
 
2. Architecture & State Management
•	Chosen: BLoC (Business Logic Component) with Cubit for simpler flows.
•	Why:
o	Clear separation of concerns (UI vs logic).
o	Scales well for two-sided marketplace (search, bookings, payments).
o	Easy testability with bloc_test.
o	Widely adopted in Flutter teams → maintainable for handoff.
 
3. Navigation Structure
•	Entry: Splash → Discover Page → Bookings page
Screens / Routes:
•	/discover → Grid/List of professionals (filter & search).
•	/professional/:id → Professional profile with services & availability.
•	/booking/:id → Slot selection & confirmation.
 
4. Offline & Error UX
•	Loading: Skeleton shimmer for lists, activity indicator for blocking actions.
•	Empty State: Friendly illustration + “Try agai ” CTA.
•	API Errors: Snackbar + inline retry button.
•	Offline: Show cached results (from local DB/cache), display “You’re offline” banner, 
 
5. Performance & Testing
•	Performance:
o	Memoization for filters & search results.
o	Lazy loading with ListView.builder + pagination.
o	Image caching with cached_network_image.
•	Caching: Local storage for filters,
•	Testing Priorities:
o	Widget tests for Booking Review Page  & Discover page .
o	Unit tests for BLoC logic (Discover bloc and search filter ).
Part 3 — Short Questions
1. State choice (BLoC)
•	BLoC is great for event-driven UI updates (e.g., filtering, loading, booking).
•	Feature boundaries: one Bloc per feature — e.g., DiscoverBloc, BookingBloc, ProfileBloc. Keeps logic isolated, reusable, and testable.
2.   Performance optimizations
•	Use const constructors wherever widgets don’t depend on changing state.
•	Use ListView.builder (or GridView.builder) instead of building all items upfront.
•	(Bonus: use BlocSelector for fine-grained rebuilds).
3 . Offline / Latency
•	Optimistic updates: immediately update the UI on booking/filter action, then confirm with API.
•	Caching: lightweight store with shared_preferences for filters or recent searches, or Hive/drift for persisted lists.
•	This avoids over-engineering but still improves UX when offline or on bad network.
4. Error UX
•	Clearly communicated to users (UI feedback):
o	Network failures (e.g., “Couldn’t load professionals, check your internet”).
o	Form/validation errors (e.g., “Please select a date before booking”).
o	Payment/booking failures (e.g., “Payment declined, try again”).
•	Logged silently (developer/debug logs, crash reporting):
o	JSON parsing/DTO mapping mismatches.
o	API edge-case errors that don’t affect UX directly.
o	Caching/storage read/write failures when a fallback still works.
 
5. Scalability (with auth + booking APIs):
•	DTOs (Data Transfer Objects):
o	Add AuthDTO (login/signup responses).
o	Add BookingDTO (requests, confirmations).
•	Mappers:
o	Convert API DTOs → domain models (User, Booking, Professional).
o	Handle null-safety + defaults consistently.
•	Error Types:
o	Domain-level error classes (AuthFailure, BookingFailure, NetworkFailure).
o	Map raw API errors → typed failures → BLoC state (so UI can react properly).
•	Layers:
o	Repository layer expands: AuthRepository, BookingRepository.
o	Feature BLoCs: AuthBloc, BookingBloc scoped per feature.
o	Shared core: ApiClient, TokenInterceptor (for authenticated requests).


