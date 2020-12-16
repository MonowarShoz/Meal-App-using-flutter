//import 'dart:ui';

import 'package:Meal_app/dummy_data.dart';
import 'package:Meal_app/screens/categories_Screen.dart';
import 'package:Meal_app/screens/category_meals_screen.dart';

import 'package:Meal_app/screens/meal_detail_screen.dart';
import 'package:Meal_app/screens/set_filter.dart';
import 'package:Meal_app/screens/tab_screen.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];

  void _filterSet(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _selFav(String mealId) {
    final eIndex = _favMeals.indexWhere((meal) => meal.id == mealId);
    if (eIndex >= 0) {
      setState(() {
        _favMeals.removeAt(eIndex);
      });
    } else {
      setState(() {
        _favMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isFav(String id) {
    return _favMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.dark().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        primarySwatch: Colors.blue,
        accentColor: Colors.yellow,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        //'/': (ctx) => CategoriesScreen(),
        '/': (ctx) => TabScreen(_favMeals),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_selFav,_isFav),
        SetFilter.routeName: (ctx) => SetFilter(_filters, _filterSet),
      },

      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(
      //     builder: (ctx) => CategoriesScreen(),
      //   );
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
