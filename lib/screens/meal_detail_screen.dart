import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routeName = 'meal_detail';

  final Function toggleFavorites;
  final Function isFavorites;

  MealDetailsScreen(this.toggleFavorites, this.isFavorites);

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Widget buildSectionTitle(
      {required BuildContext context, required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      height: 150,
      width: 300,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    print(mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context: context, text: 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context: context, text: 'Steps'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black38,
                      ),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.toggleFavorites(mealId);
          setState(() {});
        },
        child:
            Icon(widget.isFavorites(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
