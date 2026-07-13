import 'package:flutter/material.dart';
import '../../utils/design_colors.dart';
import '../../models/user_profile.dart';
import '../../services/firestore_service.dart';
import 'chat_screen.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  final _firestore = FirestoreService();
  List<UserProfile>? _matchedUsers;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final all = _firestore.getUsers();
    setState(() => _matchedUsers = all.take(5).toList());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text('Messages', style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: DesignColors.textPrimary,
            )),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Chat with your matches', style: TextStyle(
              fontSize: 13, color: DesignColors.textSecondary,
            )),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _matchedUsers == null
                ? const Center(child: CircularProgressIndicator())
                : _matchedUsers!.isEmpty
                    ? _buildEmpty()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _matchedUsers!.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, color: DesignColors.border),
                        itemBuilder: (_, i) => _MessageTile(
                          user: _matchedUsers![i],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ChatScreen(userId: _matchedUsers![i].id, userName: _matchedUsers![i].name)),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.forum_outlined, size: 64, color: DesignColors.textSecondary.withValues(alpha: 0.4)),
          const SizedBox(height: 16),
          const Text('No messages yet', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
          )),
          const SizedBox(height: 8),
          const Text('Match with someone to start chatting', style: TextStyle(
            fontSize: 14, color: DesignColors.textSecondary,
          )),
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onTap;

  const _MessageTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    DesignColors.roleColors[user.role.name] ?? DesignColors.primary,
                    (DesignColors.roleColors[user.role.name] ?? DesignColors.primary).withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                DesignColors.roleIcons[user.role.name] ?? Icons.person,
                color: Colors.white, size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(user.name, style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
                      )),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: (DesignColors.roleColors[user.role.name] ?? DesignColors.primary).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          DesignColors.roleLabels[user.role.name] ?? user.role.name,
                          style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500,
                            color: DesignColors.roleColors[user.role.name] ?? DesignColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(user.headline ?? '', style: const TextStyle(
                    fontSize: 12, color: DesignColors.textSecondary,
                  ), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(
                color: DesignColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
