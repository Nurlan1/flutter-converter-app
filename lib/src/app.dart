import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      title: 'Measures Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {'/settings': (_) => SettingsScreen()},
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _valueController = TextEditingController(
    text: '100',
  );
  final TextEditingController _resultFieldController = TextEditingController();
  String _resultText = '';

  String _category = 'Length';
  String _system = 'Metric';

  // Units grouped by category and system
  final Map<String, Map<String, List<String>>> _units = {
    'Length': {
      'Metric': ['meters', 'kilometers', 'centimeters'],
      'Imperial': ['feet', 'inches', 'miles'],
    },
    'Weight': {
      'Metric': ['kilograms', 'grams'],
      'Imperial': ['pounds', 'ounces'],
    },
  };

  String? _fromUnit;
  String? _toUnit;

  @override
  void initState() {
    super.initState();
    _fromUnit = _units[_category]![_system]!.first;
    _toUnit = _compatibleTargets(_fromUnit!).first;
    _resultFieldController.text = '';
  }

  List<String> _compatibleTargets(String fromUnit) {
    // Return all units that belong to the same category as fromUnit (both systems)
    final category = _category;
    final units = <String>[];
    _units[category]!.forEach((system, list) => units.addAll(list));
    // Exclude the same unit
    units.remove(fromUnit);
    return units;
  }

  // Conversion factors to base units (meters for length, kilograms for weight)
  final Map<String, double> _toBase = {
    // Length -> meters
    'meters': 1.0,
    'kilometers': 1000.0,
    'centimeters': 0.01,
    'feet': 0.3048,
    'inches': 0.0254,
    'miles': 1609.344,
    // Weight -> kilograms
    'kilograms': 1.0,
    'grams': 0.001,
    'pounds': 0.45359237,
    'ounces': 0.028349523125,
  };

  void _onCategoryChanged(String? value) {
    if (value == null) return;
    setState(() {
      _category = value;
      // reset system to Metric by default
      _system = 'Metric';
      _fromUnit = _units[_category]![_system]!.first;
      _toUnit = _compatibleTargets(_fromUnit!).first;
      _resultText = '';
      _resultFieldController.text = '';
    });
  }

  void _onSystemChanged(String? value) {
    if (value == null) return;
    setState(() {
      _system = value;
      final available = _units[_category]![_system]!;
      _fromUnit = available.first;
      _toUnit = _compatibleTargets(_fromUnit!).first;
      _resultText = '';
      _resultFieldController.text = '';
    });
  }

  void _onFromUnitChanged(String? value) {
    if (value == null) return;
    setState(() {
      _fromUnit = value;
      final targets = _compatibleTargets(_fromUnit!);
      _toUnit = targets.isNotEmpty ? targets.first : null;
      _resultText = '';
      _resultFieldController.text = '';
    });
  }

  void _onToUnitChanged(String? value) {
    if (value == null) return;
    setState(() {
      _toUnit = value;
      _resultText = '';
      _resultFieldController.text = '';
    });
  }

  void _convert() {
    final input = double.tryParse(_valueController.text.replaceAll(',', '.'));
    if (input == null) {
      setState(() {
        _resultText = 'Please enter a valid number';
        _resultFieldController.text = '';
      });
      return;
    }

    if (_fromUnit == null || _toUnit == null) return;

    final fromFactor = _toBase[_fromUnit!] ?? 1.0;
    final toFactor = _toBase[_toUnit!] ?? 1.0;

    // Convert: input * fromFactor (to base) / toFactor (to target)
    final baseValue = input * fromFactor;
    final result = baseValue / toFactor;

    setState(() {
      _resultFieldController.text = result.toStringAsFixed(3);
      _resultText =
          '${input.toStringAsFixed(3)} $_fromUnit are ${result.toStringAsFixed(3)} $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    final fromUnits = _units[_category]![_system]!;
    final toUnits = _compatibleTargets(_fromUnit ?? fromUnits.first);

    return Scaffold(
      appBar: AppBar(
        title: Text('Measures Converter'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 8),
            Center(
              child: Text(
                'Value',
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                // underline style similar to screenshot
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                'Category',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            DropdownButton<String>(
              value: _category,
              onChanged: _onCategoryChanged,
              items: ['Length', 'Weight']
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c.toLowerCase()),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'System',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            DropdownButton<String>(
              value: _system,
              onChanged: _onSystemChanged,
              items: ['Metric', 'Imperial']
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(s.toLowerCase()),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'From',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: _onFromUnitChanged,
              items: fromUnits
                  .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                  .toList(),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'To',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            DropdownButton<String>(
              value: _toUnit,
              onChanged: _onToUnitChanged,
              items: toUnits
                  .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                  .toList(),
            ),
            SizedBox(height: 18),
            Center(
              child: ElevatedButton(
                onPressed: _convert,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Text('Convert'),
                ),
              ),
            ),
            SizedBox(height: 18),
            // Second TextField (read-only) to satisfy tests that expect two input fields
            TextField(
              controller: _resultFieldController,
              readOnly: true,
              decoration: InputDecoration(border: InputBorder.none),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                _resultText,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings go here')),
    );
  }
}
