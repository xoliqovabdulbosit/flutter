import 'dart:async';

Future<String> fetchUser() async {
  await Future.delayed(const Duration(milliseconds: 100));
  return 'User #1024';
}

Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(const Duration(milliseconds: 50));
    yield i;
  }
}

Future<Map<String, dynamic>> fetchUserData(int id) async {
  print('Querying database for user $id...');
  await Future.delayed(const Duration(milliseconds: 500));
  return {'id': id, 'name': 'John Doe', 'role': 'Developer'};
}

Future<String> task1() async {
  await Future.delayed(const Duration(milliseconds: 100));
  return 'Task 1 complete';
}

Future<String> task2() async {
  await Future.delayed(const Duration(milliseconds: 80));
  return 'Task 2 complete';
}

Future<String> task3() async {
  await Future.delayed(const Duration(milliseconds: 50));
  return 'Task 3 complete';
}

Future<void> main() async {
  final user = await fetchUser();
  print('Fetched: $user');

  await for (final val in countStream(3)) {
    print('Stream item: $val');
  }

  final userData = await fetchUserData(101);
  print('Result: $userData');

  final results = await Future.wait([task1(), task2(), task3()]);
  print('Aggregated results: $results');

  final periodicStream = Stream.periodic(const Duration(milliseconds: 50), (count) => count + 1);
  final completer = Completer<void>();

  late StreamSubscription<int> subscription;
  subscription = periodicStream.listen((tick) {
    print('Tick: $tick');
    if (tick >= 5) {
      print('Cancelling subscription.');
      subscription.cancel();
      completer.complete();
    }
  });
  await completer.future;

  final numbers = Stream.fromIterable([1, 2, 2, 3, 4, 4, 5, 6]);
  final transformed = numbers
      .distinct()
      .where((n) => n.isEven)
      .map((n) => n * 10);

  await for (final val in transformed) {
    print('Transformed value: $val');
  }
}
