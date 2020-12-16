import 'package:Meal_app/models/meal.dart';
import 'package:Meal_app/widget/meal_item.dart';
import 'package:flutter/material.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayedMeal;
  var _loadInitData = false;

  @override
  void initState() {
    //...

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final routeArg =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArg['title'];
      final categoryId = routeArg['id'];
      displayedMeal = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadInitData = true;
    }

    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeal.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeal[index].id,
            title: displayedMeal[index].title,
            imgUrl: displayedMeal[index].imgUrl,
            duration: displayedMeal[index].duration,
            complexity: displayedMeal[index].complexity,
            affordability: displayedMeal[index].affordability,
            
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
