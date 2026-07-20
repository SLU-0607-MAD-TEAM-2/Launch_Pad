import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'chat_screen.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _simulateLoading();
  }

  void _simulateLoading() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _staggerController.forward();
      }
    });
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock new matches for horizontal 'stories' style view
    final List<Map<String, String>> mockNewMatches = [
      {
        'name': 'Sarah',
        'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFh5trnSnCFje0UizScieerRck6hzY-r1PDGtKoytA-N9v15OiocuwHxhPXt4Q0VSzq5k8eNUxB1E6v5tcFh5RhnqevKQFwMzSldymAignJk6vtB7O0hpZI8tQ6F6zh0RaVI-ZNy4QS3N46o2eUcgwzmf5_Y4i7svkGQ1qKBb9xtXbe-9l_0ZPWyicshcA_3ssArnW5HftQM-OLUNCOuf3an2paWe9PtStJLqRolwKoCihXRBuPLDS',
      },
      {
        'name': 'Jordan',
        'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80',
      },
      {
        'name': 'David',
        'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVTNE7i1d7R63TidA_TGD1Xsv7J-bN4fDDPZGNsVLjNrO1wYb83Ru0NlaOaq50GEv2Wo_yXfrjWK5zaorgscL4Cogfn316DtwWb3qQvUUw-ApbOL35DHpVPcdscqdUbembaru4tsNScdoPlUELHsoAMlcVwosltBSyrSU2jjiSwkdCKuSXV3f_Cb0rRi-b2b4BKiKZ4kUxxCPyBZU3vNO4_3-kn2N-P6CzbThAWTP5zYdYceNzuJWm',
      },
      {
        'name': 'Alex',
        'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4skV-RUHrptUgB-jYVUXr7eBX_tsRh-jjIoGY4mctFCwhDyEsnOQGpkoqTv_-5P4-9ZKIthgTkcJ972ZK5tYxlGByLtxC_IyEDiESep-Rc0tS03IS9dYB3QpmugAu_TydUxuN5V0cELWm3sDzngqBLCEaZN2-xpgSDt5JtpfcAz1bYdbl_Oh6fD9wzNkCNTXWJEmPPdkHkRPghWfhKHItZiHCuw4s2OkopdEKKUnTLYb6qZoqwZT6',
      },
    ];

    final List<Map<String, dynamic>> mockConversations = [
      {
        'name': 'Jordan Miller',
        'role': 'Technical Lead',
        'message': 'Hey! Are you still interested in joining HEALTHAI?',
        'time': '10:42 AM',
        'unread': true,
        'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80',
      },
      {
        'name': 'David Chen',
        'role': 'Product Lead',
        'message': "Loved your portfolio. Let's schedule a call tomorrow.",
        'time': 'Yesterday',
        'unread': true,
        'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVTNE7i1d7R63TidA_TGD1Xsv7J-bN4fDDPZGNsVLjNrO1wYb83Ru0NlaOaq50GEv2Wo_yXfrjWK5zaorgscL4Cogfn316DtwWb3qQvUUw-ApbOL35DHpVPcdscqdUbembaru4tsNScdoPlUELHsoAMlcVwosltBSyrSU2jjiSwkdCKuSXV3f_Cb0rRi-b2b4BKiKZ4kUxxCPyBZU3vNO4_3-kn2N-P6CzbThAWTP5zYdYceNzuJWm',
      },
      {
        'name': 'Sarah Jenkins',
        'role': 'Co-Founder',
        'message': 'We just launched our pre-seed round! Let\'s sync up.',
        'time': '2 days ago',
        'unread': false,
        'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFh5trnSnCFje0UizScieerRck6hzY-r1PDGtKoytA-N9v15OiocuwHxhPXt4Q0VSzq5k8eNUxB1E6v5tcFh5RhnqevKQFwMzSldymAignJk6vtB7O0hpZI8tQ6F6zh0RaVI-ZNy4QS3N46o2eUcgwzmf5_Y4i7svkGQ1qKBb9xtXbe-9l_0ZPWyicshcA_3ssArnW5HftQM-OLUNCOuf3an2paWe9PtStJLqRolwKoCihXRBuPLDS',
      },
      {
        'name': 'Alex',
        'role': 'UI/UX Designer',
        'message': 'Can you review the latest Figma prototypes?',
        'time': '1 week ago',
        'unread': false,
        'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4skV-RUHrptUgB-jYVUXr7eBX_tsRh-jjIoGY4mctFCwhDyEsnOQGpkoqTv_-5P4-9ZKIthgTkcJ972ZK5tYxlGByLtxC_IyEDiESep-Rc0tS03IS9dYB3QpmugAu_TydUxuN5V0cELWm3sDzngqBLCEaZN2-xpgSDt5JtpfcAz1bYdbl_Oh6fD9wzNkCNTXWJEmPPdkHkRPghWfhKHItZiHCuw4s2OkopdEKKUnTLYb6qZoqwZT6',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Your Matches',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        height: 110,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (_, i) => Container(
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  // ── New Matches (Horizontal Row) ─────────────────────────────────
                  Container(
                    height: 110,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'New Matches',
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xFF64748B),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mockNewMatches.length,
                            itemBuilder: (context, i) {
                              final match = mockNewMatches[i];
                              return GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Opening conversation with ${match['name']}...'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                  Future.delayed(const Duration(milliseconds: 600), () {
                                    if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ChatScreen(
                                            name: match['name']!,
                                            avatar: match['avatar']!,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundImage: NetworkImage(match['avatar']!),
                                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 14,
                                              height: 14,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF0052FF), // Blue Online Indicator
                                                shape: BoxShape.circle,
                                                border: Border.fromBorderSide(
                                                  BorderSide(color: Colors.white, width: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Subtle divider
                  Container(
                    height: 1.0,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                  ),

                  // ── Conversations List ───────────────────────────────────────────
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: mockConversations.length,
                      separatorBuilder: (context, index) => Divider(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
                        indent: 84,
                        endIndent: 20,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final chat = mockConversations[index];
                        final delay = (index * 60) / 800;
                        final slideAnimation = Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _staggerController,
                          curve: Interval(delay, (delay + 0.4).clamp(0.0, 1.0), curve: Curves.easeOutCubic),
                        ));
                        final fadeAnimation = Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(CurvedAnimation(
                          parent: _staggerController,
                          curve: Interval(delay, (delay + 0.4).clamp(0.0, 1.0), curve: Curves.easeOut),
                        ));

                        return SlideTransition(
                          position: slideAnimation,
                          child: FadeTransition(
                            opacity: fadeAnimation,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(chat['avatar']),
                                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    chat['name'],
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: chat['unread'] ? FontWeight.bold : FontWeight.w600,
                                      fontSize: 16,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  Text(
                                    chat['time'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chat['message'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: chat['unread'] ? FontWeight.w500 : FontWeight.normal,
                                          color: chat['unread'] ? const Color(0xFF0F172A) : theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    if (chat['unread'])
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF0052FF),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Opening conversation with ${chat['name']}...'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                                Future.delayed(const Duration(milliseconds: 600), () {
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          name: chat['name'],
                                          avatar: chat['avatar'],
                                        ),
                                      ),
                                    );
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
