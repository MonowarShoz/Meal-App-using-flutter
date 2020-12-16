import 'package:Meal_app/models/meal.dart';
import 'package:Meal_app/widget/meal_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favMeals;
  FavoriteScreen(this.favMeals);
  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
        child: Text('you have no favorite'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: favMeals[index].id,
              title: favMeals[index].title,
              imgUrl: favMeals[index].imgUrl,
              duration: favMeals[index].duration,
              complexity: favMeals[index].complexity,
              affordability: favMeals[index].affordability,
              );
        },
        itemCount: favMeals.length,
      );
    }
  }
}
