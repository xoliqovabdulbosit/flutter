class BankAccount {
  double balance;

  BankAccount(double initialDeposit) : balance = initialDeposit {
    if (initialDeposit < 0) {
      throw ArgumentError('Deposit cannot be negative');
    }
  }
}

class ValidationUtils {
  static bool validateEmail(String email) {
    if (!email.contains('@')) {
      throw FormatException('Invalid email address: $email');
    }
    return true;
  }
}

class Calculator {
  int add(int a, int b) => a + b;
}

abstract class Greeter {
  void greet();
}

class FriendlyGreeter extends Greeter {
  @override
  void greet() => print('Hello there!');

  @deprecated
  void oldGreet() => print('Old hello!');
}

void main() {
  print('--- Problem 5.1 ---');
  final account = BankAccount(100.0);
  print('Account balance: \$${account.balance}');

  print('\n--- Problem 5.2 ---');
  const double radius = 5.0;
  const double pi = 3.14159265359;
  final double area = pi * radius * radius;
  print('Area of circle: $area');

  print('\n--- Problem 5.3 ---');
  print('Validation result: ${ValidationUtils.validateEmail("test@example.com")}');

  print('\n--- Problem 5.4 ---');
  print('Addition: ${Calculator().add(10, 5)}');

  print('\n--- Problem 5.5 ---');
  final greeter = FriendlyGreeter();
  greeter.greet();
}
