import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
// import 'package:flutter/services.dart'; // i import this to lock the orientations

//always use this approach  and don't use theme data use .copyWith()
const kColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.white,
  onPrimary: Color(0xFF1E88E5),
  secondary: Color(0xFF1E88E5),
  onSecondary: Color(0xFF000000),
  background: Colors.white,
  onBackground: Color(0xFF1E88E5),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF1E88E5),
  error: Color(0xFFB00020),
  onError: Colors.white,
  onPrimaryContainer: Colors.black,
  primaryContainer: Color(0xFF1E88E5),
  surfaceContainer: Color(0xFF0D47A1),
);
var kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.black,
  onPrimary: Color(0xFF1E88E5),
  secondary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFF1E88E5),
  background: Colors.black,
  onBackground: Color(0xFF1E88E5),
  surface: Colors.black,
  onSurface: Color(0xFF1E88E5),
  error: Color(0xFFB00020),
  onError: Colors.black,
  onPrimaryContainer: Colors.black,
  primaryContainer: Color(0xFF1E88E5),
  surfaceContainer: Color(0xFF0D47A1),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); used for stop landscape UI mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.onPrimary,
              foregroundColor: kDarkColorScheme.primary,
            ),
          ),
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.primary,

            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            // i can use this the using theme.of(context)......
            color: kDarkColorScheme.onPrimary,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: kDarkColorScheme.onPrimary,
              // color: kColorScheme.onSecondaryContainer,
            ),
            labelMedium: TextStyle(color: kDarkColorScheme.onPrimary),
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: kDarkColorScheme.primary,
            headerForegroundColor: kDarkColorScheme.onPrimary,
            headerHelpStyle: TextStyle(color: kDarkColorScheme.onPrimary),
            weekdayStyle: TextStyle(color: kDarkColorScheme.onPrimary),
            dayForegroundColor: MaterialStatePropertyAll(
              kDarkColorScheme.onPrimary,
            ),
            todayForegroundColor: MaterialStatePropertyAll(
              kDarkColorScheme.onPrimary,
            ),
            yearStyle: TextStyle(color: kDarkColorScheme.onPrimary),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: kDarkColorScheme.onPrimary),
              hintStyle: TextStyle(color: kDarkColorScheme.onPrimary),
            ),
            cancelButtonStyle: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                kDarkColorScheme.onPrimary,
              ),
            ),
            confirmButtonStyle: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                kDarkColorScheme.onPrimary,
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(
                kDarkColorScheme.inversePrimary,
              ),
            ),
          ),
          scaffoldBackgroundColor: kDarkColorScheme.primary,
          snackBarTheme: SnackBarThemeData().copyWith(
            backgroundColor: kDarkColorScheme.secondary,
            actionBackgroundColor: kDarkColorScheme.onSecondary,
            actionTextColor: kDarkColorScheme.primary,
          ),
          iconTheme: IconThemeData(color: kDarkColorScheme.onPrimary),
          dialogTheme: DialogThemeData(
            backgroundColor: kDarkColorScheme.onPrimary,
          ),

          //----------------------------- ----------------------------------------------------------
        ),
        theme: ThemeData.light().copyWith(
          colorScheme: kColorScheme,

          // scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primary,
              foregroundColor: kColorScheme.onPrimary,
            ),
          ),
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.primary,

            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            // i can use this the using theme.of(context)......
            color: kColorScheme.onPrimary,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: kColorScheme.onPrimary,
              // color: kColorScheme.onSecondaryContainer,
            ),
            labelMedium: TextStyle(color: kColorScheme.onPrimary),
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: kColorScheme.primary,
            headerForegroundColor: kColorScheme.onPrimary,
            headerHelpStyle: TextStyle(color: kColorScheme.onPrimary),
            weekdayStyle: TextStyle(color: kColorScheme.onPrimary),
            dayForegroundColor: MaterialStatePropertyAll(kColorScheme.onPrimary),
            todayForegroundColor: MaterialStatePropertyAll(
              kColorScheme.onPrimary,
            ),
            yearStyle: TextStyle(color: kColorScheme.onPrimary),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: kColorScheme.onPrimary),
              hintStyle: TextStyle(color: kColorScheme.onPrimary),
            ),
            cancelButtonStyle: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(kColorScheme.onPrimary),
            ),
            confirmButtonStyle: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(kColorScheme.onPrimary),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(kColorScheme.onPrimary),
            ),
          ),
          scaffoldBackgroundColor: kColorScheme.primary,
          snackBarTheme: SnackBarThemeData().copyWith(
            backgroundColor: kColorScheme.secondary,
            actionBackgroundColor: kColorScheme.onSecondary,
            actionTextColor: kColorScheme.primary,
          ),
          dropdownMenuTheme: DropdownMenuThemeData(
            textStyle: TextStyle(
              backgroundColor: kDarkColorScheme.primary,
              color: kDarkColorScheme.onPrimary,
            ),
          ),
        ),

        themeMode: ThemeMode.system,
        home: const Expenses(),
      ),
    );
  // });


}
