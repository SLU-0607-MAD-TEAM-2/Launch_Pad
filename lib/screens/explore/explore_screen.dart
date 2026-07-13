import 'package:flutter/material.dart';
import '../../utils/design_colors.dart';
import '../../models/startup_project.dart';
import '../../services/firestore_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _firestore = FirestoreService();
  List<StartupProject>? _projects;
  String _filter = 'All';

  static const _categories = ['All', 'Tech', 'Design', 'Health', 'Fintech', 'Social'];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final all = _firestore.getProjects();
    setState(() => _projects = all);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.background,
      appBar: AppBar(
        backgroundColor: DesignColors.background,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [DesignColors.primary, DesignColors.secondary],
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(Icons.rocket_launch, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            const Text('Explore', style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: DesignColors.textPrimary,
            )),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text('Find startup projects to join', style: TextStyle(
              fontSize: 13, color: DesignColors.textSecondary,
            )),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _categories.map((c) {
                final selected = _filter == c;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? DesignColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? DesignColors.primary : DesignColors.border,
                        ),
                      ),
                      child: Text(c, style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500,
                        color: selected ? Colors.white : DesignColors.textSecondary,
                      )),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _projects == null
                ? const Center(child: CircularProgressIndicator())
                : _projects!.isEmpty
                    ? const Center(child: Text('No projects found'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _projects!.length,
                        itemBuilder: (_, i) => _ProjectCard(project: _projects![i]),
                      ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final StartupProject project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10, offset: const Offset(0, 2),
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: DesignColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.group, color: DesignColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.title, style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
                    )),
                    const SizedBox(height: 2),
                    Text(project.stage, style: TextStyle(
                      fontSize: 12, color: DesignColors.stageColors[project.stage] ?? DesignColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: DesignColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${project.rolesNeeded.length} open', style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600, color: DesignColors.primary,
                )),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(project.description, style: TextStyle(
            fontSize: 13, color: DesignColors.textSecondary.withValues(alpha: 0.8), height: 1.4,
          ), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: project.rolesNeeded.map((r) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: DesignColors.roleColors[r]?.withValues(alpha: 0.1) ?? DesignColors.lightGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(r, style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w500,
                color: DesignColors.roleColors[r] ?? DesignColors.textSecondary,
              )),
            )).toList(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity, height: 40,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
