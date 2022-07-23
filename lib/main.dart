import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool?> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool?> _filterData) {
    setState(() {
      _filters = _filterData;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        } else if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) {
    final int existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    print(existingIndex);
    if (existingIndex >= 0) {
      // setState(() {
      _favoriteMeals.removeAt(existingIndex);
      // });
    } else {
      // setState(() {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      // });
    }
  }

  bool isMealFavorites(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => TabsScreen(_favoriteMeals),
        '${CategoryMealScreen.routeName}': (BuildContext context) =>
            CategoryMealScreen(_availableMeal),
        '${MealDetailsScreen.routeName}': (BuildContext context) =>
            MealDetailsScreen(_toggleFavorites, isMealFavorites),
        '${FiltersScreen.routeName}': (BuildContext context) =>
            FiltersScreen(_filters, _setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal App'),
      ),
      body: CategoriesScreen(),
    );
  }
}
