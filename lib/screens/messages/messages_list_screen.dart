import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../providers/chat_provider.dart';
import '../../providers/matches_provider.dart';
import 'chat_screen.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;
  bool _hasLoadedOnce = false;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    if (!mounted) return;
    context.read<ChatProvider>().startListeningToConversations();
    context.read<MatchesProvider>().loadMatches();
    if (!_hasLoadedOnce && mounted) {
      _hasLoadedOnce = true;
      _staggerController.forward();
    }
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return DateFormat('h:mm a').format(time);
    if (diff.inDays < 7) return DateFormat('EEE').format(time);
    return DateFormat('MMM d').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const SizedBox(),
        title: Text(
          'Your Matches',
          style: theme.textTheme.titleMedium?.copyWith(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
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
        child: Consumer2<ChatProvider, MatchesProvider>(
          builder: (context, chatProvider, matchesProvider, _) {
            final conversations = chatProvider.conversations;
            final matchedUsers = matchesProvider.matchedUsers;
            final isLoading = chatProvider.isLoading;

            // Always show mock conversations as fallback (combine with real)
            final displayConversations = [..._getMockConversations(), ...conversations];

            // Always show mock matched users as fallback
            final displayMatches = matchedUsers.isNotEmpty
                ? matchedUsers
                : _getMockMatchedUsers();

            if (isLoading && !_hasLoadedOnce) {
              return _buildShimmerLoading(theme);
            }

            return Column(
              children: [
                // ── New Matches (Horizontal Row) ──
                Container(
                  constraints: const BoxConstraints(minHeight: 110),
                  color: theme.colorScheme.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NEW MATCHES',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: displayMatches.length,
                          itemBuilder: (context, i) {
                            final user = displayMatches[i];
                            final userName = _getUserName(user);
                            final userAvatar = _getUserAvatar(user);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                      name: userName,
                                      avatar: userAvatar,
                                      userId: _getUserId(user),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundImage: userAvatar.isNotEmpty
                                              ? NetworkImage(userAvatar)
                                              : null,
                                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                          child: userAvatar.isEmpty
                                              ? Text(
                                                  userName.isNotEmpty ? userName[0] : '?',
                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                )
                                              : null,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF10B981),
                                              shape: BoxShape.circle,
                                              border: Border.fromBorderSide(
                                                BorderSide(color: Colors.white, width: 2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      userName.split(' ').first,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Inter',
                                        color: theme.colorScheme.onSurface,
                                      ),
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

                // ── Conversations List ──
                Expanded(
                  child: displayConversations.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 48,
                                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No conversations yet',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Match with someone to start chatting!',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          itemCount: displayConversations.length,
                          separatorBuilder: (context, index) => Divider(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
                            indent: 84,
                            endIndent: 20,
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            final chat = displayConversations[index];
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
                                    backgroundImage: chat['avatar']?.toString().isNotEmpty == true
                                        ? NetworkImage(chat['avatar'])
                                        : null,
                                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                    child: chat['avatar']?.toString().isEmpty != false
                                        ? Text(
                                            (chat['name'] as String?)?.isNotEmpty == true
                                                ? (chat['name'] as String)[0]
                                                : '?',
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          )
                                        : null,
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          chat['name'] ?? 'Unknown',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _formatTime(chat['lastTime'] as DateTime?),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      chat['lastMessage'] ?? 'No messages yet',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                          name: chat['name'] ?? 'Unknown',
                                          avatar: chat['avatar'] ?? '',
                                          userId: chat['userId'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest,
      highlightColor: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(height: 110, color: theme.colorScheme.surfaceContainerHighest),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (_, i) => Container(
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getMockConversations() {
    return [
      {
        'userId': 'p1',
        'name': 'Sarah Chen',
        'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
        'role': 'developer',
        'lastMessage': 'Hey! Welcome to LaunchPad! I saw you just joined.',
        'lastTime': DateTime.now().subtract(const Duration(minutes: 5)),
      },
      {
        'userId': 'p2',
        'name': 'Marcus Johnson',
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
        'role': 'founder',
        'lastMessage': 'Would love to discuss the EdTech project further!',
        'lastTime': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'userId': 'p3',
        'name': 'Emily Rodriguez',
        'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=150&q=80',
        'role': 'designer',
        'lastMessage': 'Your design system work is impressive!',
        'lastTime': DateTime.now().subtract(const Duration(days: 1)),
      },
    ];
  }

  List<Map<String, dynamic>> _getMockMatchedUsers() {
    return [
      {
        'id': 'p1',
        'name': 'Sarah Chen',
        'avatarUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
      },
      {
        'id': 'p2',
        'name': 'Marcus Johnson',
        'avatarUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
      },
      {
        'id': 'p3',
        'name': 'Emily Rodriguez',
        'avatarUrl': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=150&q=80',
      },
      {
        'id': 'p5',
        'name': 'Aisha Patel',
        'avatarUrl': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80',
      },
    ];
  }

  String _getUserName(dynamic user) {
    if (user is Map<String, dynamic>) return user['name'] ?? 'Unknown';
    return user.name ?? 'Unknown';
  }

  String _getUserAvatar(dynamic user) {
    if (user is Map<String, dynamic>) return user['avatarUrl'] ?? '';
    return user.avatarUrl ?? '';
  }

  String _getUserId(dynamic user) {
    if (user is Map<String, dynamic>) return user['id'] ?? '';
    return user.id ?? '';
  }
}
