import 'package:flutter/material.dart';

class RecipeDetailsPage extends StatelessWidget {
  final dynamic recipe;

  RecipeDetailsPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Recipe App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            recipe['strMealThumb'] != null
                ? Image.network(
                    recipe['strMealThumb'],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Text('Failed to load image');
                    },
                  )
                : SizedBox.shrink(),
            SizedBox(height: 16.0),
            Text(
              recipe['strMeal'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            for (int i = 1; i <= 20; i++)
              recipe['strIngredient$i'] != null
                  ? Text(
                      '- ${recipe['strIngredient$i']} ${recipe['strMeasure$i']}')
                  : SizedBox.shrink(),
            SizedBox(height: 16.0),
            Text(
              'Instructions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(recipe['strInstructions']),
          ],
        ),
      ),
    );
  }
}
