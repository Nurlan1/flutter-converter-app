# Flutter Converter App

## Overview
The Flutter Converter App is a simple application that allows users to convert between different measurement units, such as metric and imperial. Users can select a unit to convert from and a unit to convert to, and the app will display the converted value.

## Features
- User-friendly interface for selecting measurement units.
- Supports conversions between various units, including:
  - Miles to Kilometers
  - Kilograms to Pounds
  - And more!

## Getting Started

### Prerequisites
- Flutter SDK installed on your machine.
- An IDE such as Android Studio or Visual Studio Code.

### Installation
1. Clone the repository:
   ```
   git clone https://github.com/yourusername/flutter-converter-app.git
   ```
2. Navigate to the project directory:
   ```
   cd flutter-converter-app
   ```
3. Install the dependencies:
   ```
   flutter pub get
   ```

### Running the App
To run the app, use the following command:
```
flutter run
```

## Project Structure
- `lib/main.dart`: Entry point of the application.
- `lib/screens/home_screen.dart`: Home screen with navigation to the converter.
- `lib/screens/converter_screen.dart`: Screen for performing conversions.
- `lib/models/unit.dart`: Model representing a measurement unit.
- `lib/services/conversion_service.dart`: Service for handling unit conversions.
- `lib/widgets/unit_selector.dart`: Widget for selecting units.
- `lib/widgets/result_display.dart`: Widget for displaying conversion results.
- `lib/utils/conversions.dart`: Utility functions for conversions.
- `test/widget_test.dart`: Widget tests for the application.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.