class Point {
  final double x, y;

  const Point(this.x, this.y);
  Point.origin() : x = 0, y = 0;

  factory Point.fromJson(Map<String, double> json) =>
      Point(json['x'] ?? 0, json['y'] ?? 0);
}

class Person {
  String name;
  int age;

  Person(this.name, this.age);
}

class Rectangle {
  final double width;
  final double height;

  Rectangle(this.width, this.height)
      : assert(width > 0, 'Width must be positive'),
        assert(height > 0, 'Height must be positive');
}

class Temperature {
  double _celsius = 0.0;

  double get celsius => _celsius;
  set celsius(double value) {
    if (value < -273.15) {
      throw ArgumentError('Temperature cannot fall below absolute zero');
    }
    _celsius = value;
  }

  double get fahrenheit => (_celsius * 9 / 5) + 32;
}

class UserDTO {
  final int id;
  final String username;
  final String email;

  const UserDTO({
    required this.id,
    required this.username,
    required this.email,
  });
}

void main() {
  const p1 = Point(1, 2);
  final p2 = Point.origin();
  final p3 = Point.fromJson({'x': 3.0, 'y': 4.0});
  print('Points: (${p1.x}, ${p1.y}), (${p2.x}, ${p2.y}), (${p3.x}, ${p3.y})');

  final person = Person('Alice', 21);
  print('Person: name=${person.name}, age=${person.age}');

  final rect = Rectangle(10.0, 5.0);
  print('Rectangle: ${rect.width} x ${rect.height}');

  final temp = Temperature();
  temp.celsius = 25.0;
  print('${temp.celsius}°C = ${temp.fahrenheit}°F');

  const user = UserDTO(id: 1, username: 'john_doe', email: 'john@example.com');
  print('UserDTO: ${user.username} (${user.email})');
}
