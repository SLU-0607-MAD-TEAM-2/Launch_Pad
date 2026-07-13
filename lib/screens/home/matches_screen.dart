import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/matches_provider.dart';
import '../../theme/theme.dart';
import '../messages/chat_screen.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MatchesProvider>().loadMatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    final matchesProv = context.watch<MatchesProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('Your Matches', style: AppTypography.displaySmall),
              const SizedBox(height: 20),
              Expanded(
                child: matchesProv.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border, size: 64, color: AppColor.textSecondary.withValues(alpha: 0.3)),
                            const SizedBox(height: 16),
                            Text('No matches yet', style: AppTypography.titleMedium),
                            Text('Keep swiping!', style: AppTypography.bodyMedium.copyWith(color: AppColor.textSecondary)),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: matchesProv.matches.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, color: AppColor.stroke),
                        itemBuilder: (context, i) {
                          final match = matchesProv.matches[i];
                          final user = matchesProv.getUserById(match.matchedUserId);
                          if (user == null) return const SizedBox.shrink();
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: AppColor.primary.withValues(alpha: 0.15),
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600),
                              ),
                            ),
                            title: Text(user.name, style: AppTypography.titleSmall),
                            subtitle: Text(user.headline ?? user.role.name, style: AppTypography.bodySmall),
                            trailing: Icon(Icons.arrow_forward_ios, size: 14, color: AppColor.textSecondary),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ChatScreen(userId: user.id, userName: user.name)),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
