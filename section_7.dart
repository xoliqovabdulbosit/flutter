enum Planet {
  mercury(mass: 3.3e23),
  venus(mass: 4.87e24),
  earth(mass: 5.97e24);

  final double mass;
  const Planet({required this.mass});

  bool get isHabitable => this == Planet.earth;
}

enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

enum Status { initial, loading, success, failure }

String getStatusMessage(Status status) => switch (status) {
      Status.initial => 'Ready to start',
      Status.loading => 'Loading data...',
      Status.success => 'Operation completed successfully!',
      Status.failure => 'An error occurred.',
    };

abstract interface class Describable {
  String describe();
}

enum Priority implements Describable {
  low(1),
  medium(2),
  high(3);

  final int level;
  const Priority(this.level);

  @override
  String describe() => 'Priority: $name with level $level';
}

enum Role { admin, editor, viewer }

Role? parseRole(String rawValue) {
  try {
    return Role.values.byName(rawValue);
  } on ArgumentError {
    print('Invalid role name: $rawValue');
    return null;
  }
}

void main() {
  for (final planet in Planet.values) {
    print('${planet.name}: mass=${planet.mass}, habitable=${planet.isHabitable}');
  }

  for (final day in Day.values) {
    print('Day: ${day.name}');
  }

  print('Status loading: ${getStatusMessage(Status.loading)}');
  print('Status success: ${getStatusMessage(Status.success)}');

  print(Priority.high.describe());

  print('Parsed "admin": ${parseRole('admin')}');
  print('Parsed "unknown": ${parseRole('unknown')}');
}
