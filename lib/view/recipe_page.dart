import 'package:download_recipe_in_pdf/controller/recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipePage extends StatelessWidget {
  final RecipeController controller = Get.put(RecipeController());

  final String recipeTitle = "Delicious Pancakes";
  final String recipeContent = """
  Ingredients:
  - 1 cup flour
  - 2 tbsp sugar
  - 1 tsp baking powder
  - 1/2 tsp baking soda
  - 1/4 tsp salt
  - 1 cup milk
  - 1 egg
  - 2 tbsp melted butter
  
  Instructions:
  1. In a bowl, mix all dry ingredients.
  2. In another bowl, whisk the egg, milk, and melted butter.
  3. Pour the wet ingredients into the dry and mix until combined.
  4. Heat a non-stick pan over medium heat and cook pancakes until golden brown.
  5. Serve with syrup and enjoy!
  """;

  RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipeTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(recipeContent, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () async {
                await controller.downloadRecipeAsPDF(
                    recipeTitle, recipeContent);
              },
              icon: const Icon(Icons.download),
              label: const Text('Download Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
