class StartupProject {
  final String id;
  final String name;
  final String snippet;
  final String description;
  final String domain;
  final List<String> tags;
  final String equity;
  final String duration;
  final String location;
  final List<String> seekingRoles;
  final String imageUrl;

  const StartupProject({
    required this.id,
    required this.name,
    required this.snippet,
    required this.description,
    required this.domain,
    required this.tags,
    required this.equity,
    required this.duration,
    required this.location,
    required this.seekingRoles,
    required this.imageUrl,
  });
}

const List<StartupProject> mockProjects = [
  StartupProject(
    id: 'healthai',
    name: 'HEALTHAI',
    snippet: 'AI health diagnosis platform. Connects patients with preliminary diagnostic analysis.',
    description: 'HealthAI leverages advanced deep learning models to analyze medical scans and symptoms, providing patients and clinicians with reliable preliminary reports. Our mission is to accelerate diagnostics in underserved regions.',
    domain: 'AI',
    tags: ['AI', 'HealthTech', 'Remote'],
    equity: '10% Equity',
    duration: '3 Months',
    location: 'Remote',
    seekingRoles: ['Flutter Dev', 'UI Designer', 'ML Engineer'],
    imageUrl: 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=500&q=80',
  ),
  StartupProject(
    id: 'shopflow',
    name: 'SHOPFLOW',
    snippet: 'E-commerce workflow orchestrator. Simplifies store integrations.',
    description: 'ShopFlow is an all-in-one automation tool for multi-channel e-commerce merchants. We streamline orders, shipping, and inventory updates across platforms like Shopify, WooCommerce, and Amazon using real-time synchronization.',
    domain: 'FinTech',
    tags: ['E-Commerce', 'FinTech', 'On-site'],
    equity: '8% Equity',
    duration: '6 Months',
    location: 'On-site',
    seekingRoles: ['Backend Dev', 'UI Designer'],
    imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=500&q=80',
  ),
  StartupProject(
    id: 'cryptoquest',
    name: 'CRYPTOQUEST',
    snippet: 'Gamified blockchain education. Earn crypto while learning decentralized finance.',
    description: 'CryptoQuest is a learn-to-earn Web3 platform where users complete interactive quests to understand blockchain fundamentals, smart contracts, and DeFi. Earn token rewards backed by our educational partners.',
    domain: 'FinTech',
    tags: ['AI', 'FinTech', 'Remote'],
    equity: '12% Equity',
    duration: '4 Months',
    location: 'Remote',
    seekingRoles: ['Flutter Dev', 'Blockchain Dev'],
    imageUrl: 'https://images.unsplash.com/photo-1621761191319-c6fb62004040?auto=format&fit=crop&w=500&q=80',
  ),
  StartupProject(
    id: 'edupay',
    name: 'EDUPAY',
    snippet: 'Micro-payment school financing solutions for students.',
    description: 'EduPay makes it easy for families to manage educational expenses with micro-loans and modular payment schedules. We partner with universities to allow student payment installment handling in real-time.',
    domain: 'FinTech',
    tags: ['FinTech', 'EdTech', 'Remote'],
    equity: '10% Equity',
    duration: '3 Months',
    location: 'Remote',
    seekingRoles: ['Flutter Dev', 'UI Designer'],
    imageUrl: 'https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=500&q=80',
  ),
];
