class Vehicle {
  final String brand;
  Vehicle(this.brand);

  void start() => print('$brand starting...');
}

class ElectricCar extends Vehicle {
  final int batteryCapacity;
  ElectricCar(String brand, this.batteryCapacity) : super(brand);

  @override
  void start() {
    super.start();
    print('Battery level: $batteryCapacity kWh');
  }
}

class Animal {
  void makeSound() => print('Some generic animal sound');
}

class Dog extends Animal {
  @override
  void makeSound() => print('Woof! Woof!');
}

class SuperVehicle {
  final String brand;
  SuperVehicle(this.brand);
}

class SuperElectricCar extends SuperVehicle {
  final int batteryCapacity;
  SuperElectricCar(super.brand, this.batteryCapacity);
}

class Shape {
  String get name => 'Shape';
}

class Polygon extends Shape {
  final int sides;
  Polygon(this.sides);

  @override
  String get name => 'Polygon with $sides sides';
}

class Triangle extends Polygon {
  Triangle() : super(3);

  @override
  String get name => 'Triangle';
}

abstract class Appliance {
  final String brand;
  Appliance(this.brand);

  void turnOn();
  void turnOff() => print('$brand appliance powered off.');
}

class Microwave extends Appliance {
  Microwave(super.brand);

  @override
  void turnOn() => print('$brand microwave heating food.');
}

void main() {
  final car = ElectricCar('Tesla', 75);
  car.start();

  final Animal pet = Dog();
  pet.makeSound();

  final auto = SuperElectricCar('Tesla Model 3', 82);
  print('Brand: ${auto.brand}, Battery: ${auto.batteryCapacity} kWh');

  final tri = Triangle();
  print('Shape name: ${tri.name}, sides: ${tri.sides}');

  final microwave = Microwave('Panasonic');
  microwave.turnOn();
  microwave.turnOff();
}
