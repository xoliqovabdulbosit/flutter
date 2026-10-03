class InsufficientFundsException implements Exception {
  final double required;
  InsufficientFundsException(this.required);

  @override
  String toString() => 'InsufficientFundsException: Missing \$$required';
}

void withdraw(double amount, double balance) {
  if (amount > balance) {
    throw InsufficientFundsException(amount - balance);
  }
}

int divideIntegers(int a, int b) {
  try {
    return a ~/ b;
  } on UnsupportedError catch (e) {
    print('Caught integer division error: $e');
    return 0;
  }
}

void validateUsername(String? username) {
  if (username == null || username.trim().isEmpty) {
    throw ArgumentError('Username must not be null or empty.');
  }
  print('Valid username: $username');
}

void testExceptions(int code) {
  try {
    if (code == 1) {
      throw const FormatException('Bad format error');
    } else if (code == 2) {
      throw RangeError('Index out of range');
    } else {
      throw Exception('Generic unexpected error');
    }
  } on FormatException catch (e) {
    print('Handled FormatException: ${e.message}');
  } on RangeError catch (e) {
    print('Handled RangeError: ${e.message}');
  } catch (e) {
    print('Handled Generic Exception: $e');
  }
}

void causeError() {
  throw StateError('Invalid state encountered!');
}

void main() {
  try {
    withdraw(150, 100);
  } on InsufficientFundsException catch (e) {
    print('Caught custom exception: $e');
  } finally {
    print('Transaction complete.');
  }

  print('10 ~/ 2 = ${divideIntegers(10, 2)}');
  print('10 ~/ 0 = ${divideIntegers(10, 0)}');

  try {
    validateUsername('Alice');
    validateUsername('');
  } catch (e) {
    print('Caught: $e');
  }

  testExceptions(1);
  testExceptions(2);
  testExceptions(3);

  try {
    causeError();
  } catch (error, stackTrace) {
    print('Caught error: $error');
    print('First line of stack trace: ${stackTrace.toString().split('\n').first}');
  }
}
