abstract class Printable {
  void printData();
}

mixin TimestampLogger on Printable {
  void logWithTime() {
    print('${DateTime.now()}:');
    printData();
  }
}

class Report implements Printable with TimestampLogger {
  @override
  void printData() => print('Q3 Financial Summary');
}

abstract interface class DBConnector {
  void connect();
  void disconnect();
}

class MySQLConnector implements DBConnector {
  @override
  void connect() => print('Connected to MySQL Database.');

  @override
  void disconnect() => print('Disconnected from MySQL Database.');
}

mixin Flyable {
  void fly() => print('Flying in the sky!');
}

class Bird with Flyable {
  final String name;
  Bird(this.name);
}

mixin Walker {
  void walk() => print('Walking on land.');
}

mixin Swimmer {
  void swim() => print('Swimming in water.');
}

class Duck with Walker, Swimmer, Flyable {
  final String name;
  Duck(this.name);
}

class Device {
  final String serialNumber;
  Device(this.serialNumber);
}

mixin Rebootable on Device {
  void reboot() => print('Rebooting device $serialNumber...');
}

class Router extends Device with Rebootable {
  Router(super.serialNumber);
}

void main() {
  final report = Report();
  report.logWithTime();

  final DBConnector db = MySQLConnector();
  db.connect();
  db.disconnect();

  final eagle = Bird('Eagle');
  print('Bird: ${eagle.name}');
  eagle.fly();

  final duck = Duck('Donald');
  print('Duck: ${duck.name}');
  duck.walk();
  duck.swim();
  duck.fly();

  final router = Router('RT-99801');
  router.reboot();
}
