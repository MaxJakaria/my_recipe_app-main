import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_recipe_app/RecipeDetailsPage.dart';

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<dynamic> recipes = [];

  Future<void> fetchRecipes() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=%'));

    if (response.statusCode == 200) {
      setState(() {
        recipes = json.decode(response.body)['meals'];
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipe App'), // Set the title here too
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          // Calculate a color based on the index
          Color? color = index % 2 == 0
              ? Color.fromARGB(255, 232, 229, 224)
              : Colors.grey[300];

          return Column(
            children: [
              Container(
                color: color ?? Colors.transparent, // Handle nullable Color
                child: ListTile(
                  title: Text(recipes[index]['strMeal']),
                  leading: recipes[index]['strMealThumb'] != null
                      ? Expanded(
                          child: Image.network(
                            recipes[index]['strMealThumb'],
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox.fromSize(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailsPage(recipe: recipes[index]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 3), // Adding spacing between list items
            ],
          );
        },
      ),
    );
  }
}
