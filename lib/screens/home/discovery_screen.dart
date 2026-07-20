import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../swipe/swipe_screen.dart';
import '../../models/startup_project.dart';
import '../explore/project_details_screen.dart';
import 'main_shell.dart';

/// DiscoveryScreen — the main Home tab.
/// Hosts a segmented toggle between:
///   - 'Swipe Match' → embeds the [SwipeScreen] card deck
///   - 'Explore Feed' → shows a searchable/filterable project & founder feed
class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  // Toggle between the two sub-views
  String _currentView = 'Swipe Match';

  // Explore feed filter state
  String _selectedSkill = 'All';
  String _selectedIndustry = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter chip options
  final List<String> _skillsList = ['All', 'Flutter', 'Python', 'Figma', 'Swift'];
  final List<String> _industriesList = ['All', 'HealthTech', 'SaaS', 'FinTech', 'Web3'];

  // Static mock projects for Explore Feed
  static const List<StartupProject> _projects = [
    StartupProject(
      id: 'healthai',
      name: 'HEALTHAI',
      snippet: 'AI-driven patient diagnostics and personalized care recommendations.',
      description: 'HealthAI leverages machine learning to provide real-time diagnostic insights, streamlining clinical workflows and improving patient outcomes at scale.',
      domain: 'HealthTech',
      tags: ['HealthTech', 'Python', 'Remote'],
      equity: '8% Equity',
      duration: '9 Months',
      location: 'Remote',
      seekingRoles: ['Flutter Dev', 'ML Engineer'],
      imageUrl: 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=500&q=80',
    ),
    StartupProject(
      id: 'finflow',
      name: 'FINFLOW',
      snippet: 'Next-gen expense management and financial forecasting for SMBs.',
      description: 'FinFlow replaces bloated ERP tools with a lightweight, real-time financial co-pilot built for small and medium businesses.',
      domain: 'FinTech',
      tags: ['FinTech', 'SaaS', 'Flutter'],
      equity: '6% Equity',
      duration: '12 Months',
      location: 'Hybrid',
      seekingRoles: ['Full-Stack Dev', 'Product Designer'],
      imageUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&w=500&q=80',
    ),
    StartupProject(
      id: 'solaris',
      name: 'SOLARIS PROTOCOL',
      snippet: 'A decentralized energy grid optimization platform using ZK proofs.',
      description: 'Solaris Protocol routes solar assets using zero-knowledge proofs to create a fully verifiable and transparent decentralized energy market.',
      domain: 'Web3',
      tags: ['Web3', 'Energy', 'Remote'],
      equity: '10% Equity',
      duration: '6 Months',
      location: 'Remote',
      seekingRoles: ['Flutter Dev', 'Web3 Dev'],
      imageUrl: 'https://images.unsplash.com/photo-1509391366360-2e959784a276?auto=format&fit=crop&w=500&q=80',
    ),
    StartupProject(
      id: 'designflow',
      name: 'DESIGNFLOW',
      snippet: 'Collaborative Figma-native design-to-code pipeline for design systems.',
      description: 'DesignFlow bridges the gap between design and engineering by auto-generating production-ready Flutter and React components from Figma frames.',
      domain: 'SaaS',
      tags: ['SaaS', 'Figma', 'Flutter'],
      equity: '5% Equity',
      duration: '8 Months',
      location: 'Remote',
      seekingRoles: ['Figma Expert', 'Flutter Dev'],
      imageUrl: 'https://images.unsplash.com/photo-1558655146-d09347e92766?auto=format&fit=crop&w=500&q=80',
    ),
  ];

  // Mock founders for the Founders section
  static const List<Map<String, String>> _founders = [
    {
      'name': 'Alex Rivera',
      'role': 'UI/UX Designer',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4skV-RUHrptUgB-jYVUXr7eBX_tsRh-jjIoGY4mctFCwhDyEsnOQGpkoqTv_-5P4-9ZKIthgTkcJ972ZK5tYxlGByLtxC_IyEDiESep-Rc0tS03IS9dYB3QpmugAu_TydUxuN5V0cELWm3sDzngqBLCEaZN2-xpgSDt5JtpfcAz1bYdbl_Oh6fD9wzNkCNTXWJEmPPdkHkRPghWfhKHItZiHCuw4s2OkopdEKKUnTLYb6qZoqwZT6',
    },
    {
      'name': 'Jordan Miller',
      'role': 'Technical Lead',
      'img': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80',
    },
    {
      'name': 'Sarah Jenkins',
      'role': 'Co-Founder',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFh5trnSnCFje0UizScieerRck6hzY-r1PDGtKoytA-N9v15OiocuwHxhPXt4Q0VSzq5k8eNUxB1E6v5tcFh5RhnqevKQFwMzSldymAignJk6vtB7O0hpZI8tQ6F6zh0RaVI-ZNy4QS3N46o2eUcgwzmf5_Y4i7svkGQ1qKBb9xtXbe-9l_0ZPWyicshcA_3ssArnW5HftQM-OLUNCOuf3an2paWe9PtStJLqRolwKoCihXRBuPLDS',
    },
    {
      'name': 'David Chen',
      'role': 'Product Lead',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVTNE7i1d7R63TidA_TGD1Xsv7J-bN4fDDPZGNsVLjNrO1wYb83Ru0NlaOaq50GEv2Wo_yXfrjWK5zaorgscL4Cogfn316DtwWb3qQvUUw-ApbOL35DHpVPcdscqdUbembaru4tsNScdoPlUELHsoAMlcVwosltBSyrSU2jjiSwkdCKuSXV3f_Cb0rRi-b2b4BKiKZ4kUxxCPyBZU3vNO4_3-kn2N-P6CzbThAWTP5zYdYceNzuJWm',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Returns filtered projects based on active skill/industry chips and search
  List<StartupProject> get _filteredProjects {
    return _projects.where((p) {
      final matchesSkill = _selectedSkill == 'All' || p.tags.contains(_selectedSkill);
      final matchesIndustry = _selectedIndustry == 'All' || p.tags.contains(_selectedIndustry);
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.snippet.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSkill && matchesIndustry && matchesSearch;
    }).toList();
  }

  // ── Filter bottom sheet ──────────────────────────────────────────────────────
  void _showFilterBottomSheet() {
    String selectedRole = 'All';
    bool remoteOnly = false;
    String selectedAvailability = 'All';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Filters',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 24),
              // Role filter
              const Text(
                'ROLE',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['All', 'Founder', 'Developer', 'Designer'].map((role) {
                  final isSelected = selectedRole == role;
                  return ChoiceChip(
                    label: Text(role),
                    selected: isSelected,
                    onSelected: (_) => setSheetState(() => selectedRole = role),
                    selectedColor: const Color(0xFF0052FF),
                    backgroundColor: const Color(0xFFF8F9FC),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF0F172A),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF0052FF) : const Color(0xFFE2E8F0),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Remote only toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Remote Only',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Switch(
                    value: remoteOnly,
                    onChanged: (val) => setSheetState(() => remoteOnly = val),
                    activeTrackColor: const Color(0xFF0052FF).withValues(alpha: 0.5),
                    activeThumbColor: const Color(0xFF0052FF),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Availability filter
              const Text(
                'AVAILABILITY',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['All', 'Immediate', 'Part-time', 'Weekends'].map((avail) {
                  final isSelected = selectedAvailability == avail;
                  return ChoiceChip(
                    label: Text(avail),
                    selected: isSelected,
                    onSelected: (_) => setSheetState(() => selectedAvailability = avail),
                    selectedColor: const Color(0xFF0052FF),
                    backgroundColor: const Color(0xFFF8F9FC),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF0F172A),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF0052FF) : const Color(0xFFE2E8F0),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              const Spacer(),
              // Apply button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0052FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Filters applied: $selectedRole, Remote: $remoteOnly, $selectedAvailability'),
                        backgroundColor: const Color(0xFF0052FF),
                      ),
                    );
                  },
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Founder tap dialog ──────────────────────────────────────────────────────
  void _showFounderDialog(Map<String, String> founder) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 48, backgroundImage: NetworkImage(founder['img']!)),
              const SizedBox(height: 14),
              Text(
                founder['name']!,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEDFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  founder['role']!,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF0052FF),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Experienced builder passionate about rapid UI delivery and clean code architecture. Open to working as a co-founder in high-growth startups.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Color(0xFF475569),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Close'),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.chat_bubble_outline, size: 16),
                    label: const Text('Message'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      // Switch to Messages tab
                      context.findAncestorStateOfType<MainShellState>()?.setSelectedIndex(1);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Filter chip ─────────────────────────────────────────────────────────────
  Widget _buildFilterChip(String label, String current, ValueChanged<String> onTap, Color accent) {
    final isActive = label == current;
    return GestureDetector(
      onTap: () => onTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? accent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? accent : const Color(0xFFE2E8F0)),
          boxShadow: isActive
              ? [BoxShadow(color: accent.withValues(alpha: 0.2), blurRadius: 6, offset: const Offset(0, 2))]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }

  // ── Project card ────────────────────────────────────────────────────────────
  Widget _buildProjectCard(StartupProject project, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProjectDetailsScreen(project: project)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project cover image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                project.imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 140,
                  color: const Color(0xFFEAEDFF),
                  child: const Center(child: Icon(Icons.rocket_launch, color: Color(0xFF0052FF), size: 48)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Domain tag + equity badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAEDFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          project.domain,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0052FF),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          project.equity,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Project name
                  Text(
                    project.name,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.snippet,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Info row: duration + location
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(
                        project.duration,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(
                        project.location,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Apply button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0052FF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProjectDetailsScreen(project: project)),
                        );
                      },
                      child: const Text(
                        'View & Apply',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Explore Feed view ────────────────────────────────────────────────────────
  Widget _buildExploreFeed(ThemeData theme) {
    final filtered = _filteredProjects;

    return SingleChildScrollView(
      key: const ValueKey('explore_feed'),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Search founders, projects...',
                      hintStyle: TextStyle(color: Color(0xFFADB5BD), fontSize: 14),
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
                      setState(() => _searchQuery = '');
                    },
                    child: const Icon(Icons.close, color: Color(0xFF94A3B8), size: 18),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Filter button
          GestureDetector(
            onTap: _showFilterBottomSheet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF0052FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.setting_4, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Filters',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // SKILLS filter chips
          const Text(
            'SKILLS',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF94A3B8),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _skillsList.length,
              itemBuilder: (_, i) => _buildFilterChip(
                _skillsList[i],
                _selectedSkill,
                (v) => setState(() => _selectedSkill = v),
                const Color(0xFF0052FF),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // INDUSTRIES filter chips
          const Text(
            'INDUSTRIES',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF94A3B8),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _industriesList.length,
              itemBuilder: (_, i) => _buildFilterChip(
                _industriesList[i],
                _selectedIndustry,
                (v) => setState(() => _selectedIndustry = v),
                const Color(0xFF7C3AED),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Founders section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Founders',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0052FF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Horizontal founders avatar list
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _founders.length,
              itemBuilder: (_, i) {
                final f = _founders[i];
                return GestureDetector(
                  onTap: () => _showFounderDialog(f),
                  child: Container(
                    width: 72,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(f['img']!),
                          backgroundColor: const Color(0xFFEAEDFF),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          f['name']!.split(' ').first,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // New Projects section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New Projects',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '${filtered.length} found',
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Project cards or empty state
          if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  children: [
                    const Icon(Icons.search_off, size: 48, color: Color(0xFFCBD5E1)),
                    const SizedBox(height: 12),
                    const Text(
                      'No projects match your filters.',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => setState(() {
                        _selectedSkill = 'All';
                        _selectedIndustry = 'All';
                        _searchController.clear();
                        _searchQuery = '';
                      }),
                      child: const Text('Clear filters'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...filtered.map((p) => _buildProjectCard(p, theme)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            // Tappable logo — navigates to login (reset)
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
              child: Image.asset(
                'assets/images/logo.png',
                height: 28,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.rocket_launch,
                  color: Color(0xFF0052FF),
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'LAUNCHPAD',
              style: theme.textTheme.titleMedium?.copyWith(
                fontFamily: 'Geist',
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.primary,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        actions: [
          // Notification bell with badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Iconsax.notification, color: Color(0xFF475569), size: 22),
                onPressed: () {},
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Segmented Toggle ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: ['Swipe Match', 'Explore Feed'].map((label) {
                    final isSelected = _currentView == label;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _currentView = label),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected ? theme.colorScheme.surface : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isSelected
                                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            label,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontFamily: 'Geist',
                              fontWeight: FontWeight.bold,
                              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // ── Sub-view ────────────────────────────────────────────────────
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _currentView == 'Swipe Match'
                    ? const SwipeScreen() // ← dedicated SwipeScreen widget
                    : _buildExploreFeed(theme),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
