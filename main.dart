import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter Widgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: MainMenuScreen(
        onThemeChanged: toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

// MAIN MENU TO ACCESS ALL 9 TASKS
class MainMenuScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const MainMenuScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'title': 'Task 1: Selection Controls', 'screen': Task1Screen(onThemeChanged: onThemeChanged, isDarkMode: isDarkMode)},
      {'title': 'Task 2: Input Fields & Validation', 'screen': const Task2Screen()},
      {'title': 'Task 3: Buttons & Counter Actions', 'screen': const Task3Screen()},
      {'title': 'Task 4: Indicators & SnackBar Feedback', 'screen': const Task4Screen()},
      {'title': 'Task 5: Dialogs & Bottom Sheet Modals', 'screen': const Task5Screen()},
      {'title': 'Task 6: Sliders & Date Picker', 'screen': const Task6Screen()},
      {'title': 'Task 7: Scrollable List & Dismissible', 'screen': const Task7Screen()},
      {'title': 'Task 9: Navigation Controls (Tabs & BottomNav)', 'screen': const Task9Screen()},
      {'title': 'Task 10: Structural Containers & FAQ', 'screen': const Task10Screen()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Lab 4 Tasks')),
      body: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(tasks[index]['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => tasks[index]['screen'] as Widget),
              );
            },
          );
        },
      ),
    );
  }
}

// 3.1 TASK 1: Selection Controls (Checkbox & Switch)
class Task1Screen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const Task1Screen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  late bool _darkMode;
  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 1: Selection Controls')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Exercise 1.1: SwitchListTile for Dark Mode
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _darkMode,
              onChanged: (val) {
                setState(() => _darkMode = val);
                widget.onThemeChanged(val);
              },
            ),
            // Exercise 1.1: CheckboxListTile for "Agree to Terms"
            CheckboxListTile(
              title: const Text('Agree to Terms'),
              value: _agreedToTerms,
              onChanged: (val) {
                setState(() => _agreedToTerms = val ?? false);
              },
            ),
            const SizedBox(height: 24),
            // Exercise 1.2: ElevatedButton enabled/disabled based on Agree to Terms
            ElevatedButton(
              onPressed: _agreedToTerms
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Proceeding to next step!')),
                      );
                    }
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3.2 TASK 2: Input Fields (TextField & TextFormField)
class Task2Screen extends StatefulWidget {
  const Task2Screen({super.key});

  @override
  State<Task2Screen> createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 2: Input Fields')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Exercise 2.2: Email validation checking for @
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email containing "@"';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Exercise 2.1: Password field with obscure text toggle
              TextFormField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form Submitted Successfully!')),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 3.3 TASK 3: Buttons & Action Items
class Task3Screen extends StatefulWidget {
  const Task3Screen({super.key});

  @override
  State<Task3Screen> createState() => _Task3ScreenState();
}

class _Task3ScreenState extends State<Task3Screen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 3: Buttons & Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter Value:', style: TextStyle(fontSize: 18)),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Exercise 3.2: OutlinedButton resets counter to 0
            OutlinedButton(
              onPressed: () {
                setState(() => _counter = 0);
              },
              child: const Text('Reset Counter'),
            ),
          ],
        ),
      ),
      // Exercise 3.1: FloatingActionButton increments counter
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _counter++);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 3.4 TASK 4: Indicators & Feedback
class Task4Screen extends StatefulWidget {
  const Task4Screen({super.key});

  @override
  State<Task4Screen> createState() => _Task4ScreenState();
}

class _Task4ScreenState extends State<Task4Screen> {
  bool _isLoading = false;

  void _triggerAsyncOperation() async {
    // Exercise 4.1: Centered CircularProgressIndicator for 3 seconds
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Exercise 4.2: SnackBar with Undo action upon completion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Operation completed successfully!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Undo action
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 4: Indicators & SnackBar')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _triggerAsyncOperation,
                child: const Text('Start 3-Sec Operation'),
              ),
      ),
    );
  }
}

// 3.5 TASK 5: Dialogs & Modals
class Task5Screen extends StatelessWidget {
  const Task5Screen({super.key});

  // Exercise 5.1: AlertDialog with Cancel and Delete actions
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item deleted!')),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Exercise 5.2: Modal bottom sheet containing share options
  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share via Link'),
                onTap: () => Navigator.pop(sheetContext),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Share via Email'),
                onTap: () => Navigator.pop(sheetContext),
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Share via Message'),
                onTap: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 5: Dialogs & Modals')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showDeleteDialog(context),
              child: const Text('Show Delete Confirmation'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showShareBottomSheet(context),
              child: const Text('Show Share Bottom Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3.6 TASK 6: Sliders & Pickers
class Task6Screen extends StatefulWidget {
  const Task6Screen({super.key});

  @override
  State<Task6Screen> createState() => _Task6ScreenState();
}

class _Task6ScreenState extends State<Task6Screen> {
  double _volume = 50.0;
  DateTime? _selectedDate;

  // Exercise 6.2: Native date picker
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 6: Sliders & DatePicker')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Exercise 6.1: Custom volume slider with percentage text
            Text(
              'Volume: ${_volume.round()}%',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _volume,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (val) {
                setState(() => _volume = val);
              },
            ),
            const Divider(height: 48),
            // Exercise 6.2: Date picker button & formatted display
            Text(
              _selectedDate == null
                  ? 'No date selected'
                  : 'Selected Date: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text('Pick a Date'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3.7 TASK 7: Scrollable Collections
class Task7Screen extends StatefulWidget {
  const Task7Screen({super.key});

  @override
  State<Task7Screen> createState() => _Task7ScreenState();
}

class _Task7ScreenState extends State<Task7Screen> {
  // Exercise 7.1: Dynamic list of 20 items
  final List<String> _items = List.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 7: ListView & Dismissible')),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          // Exercise 7.2: Swipe-to-dismiss functionality
          return Dismissible(
            key: Key(item),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                _items.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$item dismissed')),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.label),
              title: Text(item),
              subtitle: const Text('Swipe left or right to dismiss'),
            ),
          );
        },
      ),
    );
  }
}

// 3.9 TASK 9: Navigation Controls (BottomNav & TabBar)
class Task9Screen extends StatefulWidget {
  const Task9Screen({super.key});

  @override
  State<Task9Screen> createState() => _Task9ScreenState();
}

class _Task9ScreenState extends State<Task9Screen> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Exercise 9.2: DefaultTabController, TabBar, TabBarView
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task 9: Navigation Controls'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Top Tab 1'),
              Tab(icon: Icon(Icons.star), text: 'Top Tab 2'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Exercise 9.1: 3-tab layout using BottomNavigationBar
            IndexedStack(
              index: _bottomNavIndex,
              children: const [
                Center(child: Text('Bottom View 1: Home View', style: TextStyle(fontSize: 18))),
                Center(child: Text('Bottom View 2: Search View', style: TextStyle(fontSize: 18))),
                Center(child: Text('Bottom View 3: Profile View', style: TextStyle(fontSize: 18))),
              ],
            ),
            const Center(child: Text('Top Tab 2 Content', style: TextStyle(fontSize: 18))),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: (index) {
            setState(() => _bottomNavIndex = index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// 3.10 TASK 10: Structural Containers (Card & ExpansionTile)
class Task10Screen extends StatelessWidget {
  const Task10Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 10: Card & ExpansionTile')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Exercise 10.1: Information card with header, subtitle, leading Icon, trailing button
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.info, size: 36, color: Colors.blue),
              title: const Text('Information Card', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('This is a subtitle describing card contents.'),
              trailing: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Card action tapped!')),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Exercise 10.2: FAQ screen using multiple ExpansionTile widgets
          const ExpansionTile(
            title: Text('What is Flutter?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Flutter is an open-source UI software development kit created by Google.'),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('How does hot reload work?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Hot reload injects updated source code files into the running Dart VM.'),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('Is Flutter cross-platform?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Yes, it compiles to iOS, Android, web, Windows, macOS, and Linux.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
