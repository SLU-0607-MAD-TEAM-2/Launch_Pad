enum Role { founder, developer, designer, creative, marketer, operator }

enum ExperienceLevel { entry, intermediate, senior, lead }

Role? roleFromString(String s) {
  for (final r in Role.values) {
    if (r.name == s) return r;
  }
  return null;
}

ExperienceLevel levelFromString(String level) {
  return ExperienceLevel.values.firstWhere(
    (e) => e.name == level,
    orElse: () => ExperienceLevel.entry,
  );
}
