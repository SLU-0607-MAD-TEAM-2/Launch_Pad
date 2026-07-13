enum Role { founder, developer, designer, creative, marketer, operator }

enum ExperienceLevel { entry, intermediate, senior, lead }

Role? roleFromString(String s) {
  for (final r in Role.values) {
    if (r.name == s) return r;
  }
  return null;
}

ExperienceLevel levelFromString(String s) {
  for (final l in ExperienceLevel.values) {
    if (l.name == s) return ExperienceLevel.entry;
  }
  return ExperienceLevel.entry;
}
