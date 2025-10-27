# Flutter Converter App

This is a simple Flutter application designed to convert values between different units. The app provides a user-friendly interface for inputting values and selecting conversion types.

## Features

- Input fields for entering values to be converted.
- Selection of various conversion types.
- Display of conversion results in a formatted manner.
- Settings screen for configuring app preferences.

## Getting Started

To run this application, ensure you have Flutter installed on your machine. Follow these steps:

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

4. Run the application:
   ```
   flutter run
   ```

## Project Structure

- `lib/main.dart`: Entry point of the application.
- `lib/src/app.dart`: Main application widget with routes and theme.
- `lib/src/models/conversion_model.dart`: Data structure for conversions.
- `lib/src/screens/home_screen.dart`: Main interface for the converter.
- `lib/src/screens/settings_screen.dart`: Configuration settings for conversions.
- `lib/src/widgets/converter_input.dart`: Input fields for conversion values.
- `lib/src/widgets/result_tile.dart`: Displays conversion results.
- `lib/src/services/conversion_service.dart`: Methods for performing conversions.
- `lib/src/utils/formatters.dart`: Utility functions for formatting values.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.