import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../models/user_profile.dart';
import '../messages/chat_screen.dart';
import '../home/main_shell.dart';
import '../../widgets/loading_widget.dart';

/// SwipeScreen — card-based talent matching using flutter_card_swiper v6.
/// Displays a swipeable deck of [UserProfile] cards.
class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final CardSwiperController _controller = CardSwiperController();

  late List<UserProfile> _allProfiles;
  late List<UserProfile> _deck;

  bool _showMatchOverlay = false;
  UserProfile? _lastMatch;
  bool _isLoading = true;

  // Filter state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All', 'Flutter', 'Python', 'Figma', 'HealthTech', 'FinTech', 'SaaS'
  ];

  @override
  void initState() {
    super.initState();
    _allProfiles = List.from(mockSwipeProfiles);
    _applyFilters();
    _simulateLoading();
  }

  void _simulateLoading() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _deck = _allProfiles.where((p) {
        final matchesFilter = _selectedFilter == 'All' || p.skills.contains(_selectedFilter) || p.role.contains(_selectedFilter);
        final matchesSearch = _searchQuery.isEmpty || 
                              p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                              p.skills.any((s) => s.toLowerCase().contains(_searchQuery.toLowerCase())) ||
                              p.role.toLowerCase().contains(_searchQuery.toLowerCase());
        return matchesFilter && matchesSearch;
      }).toList();
    });
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (previousIndex < 0 || previousIndex >= _deck.length) return false;
    final profile = _deck[previousIndex];

    if (direction == CardSwiperDirection.right) {
      // Connect/Match
      setState(() {
        _lastMatch = profile;
        _showMatchOverlay = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection request sent to ${profile.name}'),
          backgroundColor: const Color(0xFF0052FF),
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (direction == CardSwiperDirection.top) {
      // Save
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile saved: ${profile.name}'),
          backgroundColor: const Color(0xFFF59E0B),
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (direction == CardSwiperDirection.left) {
      // Skip
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Skipped ${profile.name}'),
          backgroundColor: const Color(0xFF64748B),
          duration: const Duration(seconds: 1),
        ),
      );
    }
    return true;
  }

  void _passCard() {
    if (_deck.isNotEmpty) {
      _controller.swipeLeft();
    }
  }

  void _superLike() {
    if (_deck.isNotEmpty) {
      _controller.swipeTop();
    }
  }

  void _connectCard() {
    if (_deck.isNotEmpty) {
      _controller.swipeRight();
    }
  }

  Widget _buildGlassTag(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onTap,
    String? label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: size * 0.42),
          ),
          if (label != null) ...[
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCard(UserProfile profile, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              profile.avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE0E7FF),
                child: const Center(
                  child: Icon(Icons.person, size: 80, color: Color(0xFF0052FF)),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.35, 0.55, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 28,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          profile.name,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (profile.isVerified) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.verified, color: Color(0xFF38BDF8), size: 22),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.role,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(children: profile.skills.map(_buildGlassTag).toList()),
                  const SizedBox(height: 10),
                  Text(
                    profile.bio,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white70, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      profile.location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_outline, size: 72, color: Color(0xFFCBD5E1)),
            const SizedBox(height: 20),
            const Text(
              "You've seen everyone!",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your filters or check back later.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reload Deck'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0052FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _searchController.clear();
                  _searchQuery = '';
                  _selectedFilter = 'All';
                });
                _applyFilters();
                _simulateLoading();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchOverlay(UserProfile match) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.92),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, color: Colors.redAccent, size: 72),
              const SizedBox(height: 20),
              const Text(
                "It's a Match!",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'You and ${match.name} are ready to build together.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 17,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 46,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
                    ),
                    backgroundColor: Colors.white,
                  ),
                  Align(
                    widthFactor: 0.6,
                    child: CircleAvatar(
                      radius: 46,
                      backgroundImage: NetworkImage(match.avatarUrl),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() => _showMatchOverlay = false);
                  final shell = context.findAncestorStateOfType<MainShellState>();
                  if (shell != null) {
                    shell.setSelectedIndex(1);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          name: match.name,
                          avatar: match.avatarUrl,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Start Chatting',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextButton(
                onPressed: () => setState(() => _showMatchOverlay = false),
                child: const Text(
                  'Keep Swiping',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // ── Filter Bar ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Column(
            children: [
              // Search Field
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF94A3B8), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (v) {
                          _searchQuery = v;
                          _applyFilters();
                        },
                        style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Search by skill, role or industry...',
                          hintStyle: TextStyle(color: Color(0xFFADB5BD), fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                          _applyFilters();
                        },
                        child: const Icon(Icons.close, color: Color(0xFF94A3B8), size: 18),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Horizontal Chips
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (_, i) {
                    final label = _filters[i];
                    final isActive = _selectedFilter == label;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = label;
                        });
                        _applyFilters();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Filter updated to: $label'),
                            backgroundColor: const Color(0xFF0052FF),
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isActive ? const Color(0xFF0052FF) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isActive ? const Color(0xFF0052FF) : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // ── Main Swiper Content ──────────────────────────────────────────────
        Expanded(
          child: _isLoading
              ? const LaunchPadLoading(message: 'Loading profiles...')
              : Stack(
                  children: [
                    _deck.isEmpty
                        ? _buildEmptyState()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  '${_deck.length} profiles left',
                                  style: const TextStyle(
                                    fontFamily: 'Geist',
                                    fontSize: 12,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SafeArea(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 0,
                                        minHeight: 0,
                                      ),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          if (constraints.maxWidth <= 0 || constraints.maxHeight <= 0) {
                                            return const SizedBox.shrink();
                                          }
                                          return CardSwiper(
                                            controller: _controller,
                                            cardsCount: _deck.length,
                                            onSwipe: _onSwipe,
                                            numberOfCardsDisplayed: _deck.length.clamp(1, 3),
                                            backCardOffset: const Offset(0, 16),
                                            scale: 0.94,
                                            padding: EdgeInsets.zero,
                                            cardBuilder: (context, index, percentX, percentY) {
                                              if (index < 0 || index >= _deck.length) {
                                                return const SizedBox.shrink();
                                              }
                                              return _buildCard(_deck[index], theme);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildActionButton(
                                      icon: Icons.close,
                                      color: theme.colorScheme.error,
                                      size: 60,
                                      onTap: _passCard,
                                      label: 'Skip',
                                    ),
                                    Transform.translate(
                                      offset: const Offset(0, -10),
                                      child: _buildActionButton(
                                        icon: Icons.star_rounded,
                                        color: const Color(0xFFF59E0B),
                                        size: 50,
                                        onTap: _superLike,
                                        label: 'Save',
                                      ),
                                    ),
                                    _buildActionButton(
                                      icon: Icons.handshake_outlined,
                                      color: const Color(0xFF0052FF),
                                      size: 60,
                                      onTap: _connectCard,
                                      label: 'Connect',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    if (_showMatchOverlay && _lastMatch != null)
                      _buildMatchOverlay(_lastMatch!),
                  ],
                ),
        ),
      ],
    );
  }
}
