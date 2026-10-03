import 'dart:math';

abstract class PaymentProcessor {
  void process(double amount);
}

class CreditCardProcessor implements PaymentProcessor {
  @override
  void process(double amount) => print('Paid \$$amount via Credit Card');
}

class CryptoProcessor implements PaymentProcessor {
  @override
  void process(double amount) => print('Paid \$$amount via Crypto Wallet');
}

void checkout(PaymentProcessor p, double amt) => p.process(amt);

abstract class Shape {
  double area();
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => pi * radius * radius;
}

class Rectangle extends Shape {
  final double width, height;
  Rectangle(this.width, this.height);

  @override
  double area() => width * height;
}

void describeObject(Object obj) {
  if (obj is String) {
    print('String value: ${obj.toUpperCase()} (length: ${obj.length})');
  } else if (obj is int) {
    print('Integer doubled: ${obj * 2}');
  } else {
    final str = obj as dynamic;
    print('Generic object: $str');
  }
}

class Repository<T> {
  final List<T> _items = [];

  void add(T item) => _items.add(item);
  List<T> getAll() => List.unmodifiable(_items);
}

sealed class NetworkResult {}

class Success extends NetworkResult {
  final String data;
  Success(this.data);
}

class Failure extends NetworkResult {
  final String error;
  Failure(this.error);
}

String handleResult(NetworkResult result) => switch (result) {
      Success(data: final d) => 'Data received: $d',
      Failure(error: final err) => 'Error occurred: $err',
    };

void main() {
  checkout(CreditCardProcessor(), 99.99);
  checkout(CryptoProcessor(), 45.00);

  final List<Shape> shapes = [Circle(3.0), Rectangle(4.0, 5.0)];
  for (final shape in shapes) {
    print('${shape.runtimeType} area: ${shape.area().toStringAsFixed(2)}');
  }

  describeObject('hello dart');
  describeObject(42);

  final stringRepo = Repository<String>();
  stringRepo.add('Item 1');
  stringRepo.add('Item 2');
  print('String repo items: ${stringRepo.getAll()}');

  print(handleResult(Success('User Profile JSON')));
  print(handleResult(Failure('404 Not Found')));
}
