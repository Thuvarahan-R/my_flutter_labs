import 'package:flutter/material.dart';

class Lab3RecipePage extends StatelessWidget {
  const Lab3RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 3 - Recipe Layout')),
       body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "BROWSE CATEGORIES",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            const Text("BY MEAT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                RecipeImage(label: 'Beef', path: 'images/beef.jpg'),
                RecipeImage(label: 'Chicken', path: 'images/chicken.jpg'),
                RecipeImage(label: 'Pork', path: 'images/pork.jpg'),
                RecipeImage(label: 'Seafood', path: 'images/seafood.jpg'),
              ],
            ),

            const SizedBox(height: 30),

            const Text("BY COURSE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                RecipeImage(label: 'Main Dishes', path: 'images/main_dishes.jpg', alignBottom: true),
                RecipeImage(label: 'Salad Recipes', path: 'images/salad.jpg', alignBottom: true),
                RecipeImage(label: 'Side Dishes', path: 'images/side_dishes.jpg', alignBottom: true),
                RecipeImage(label: 'Crockpot', path: 'images/crockpot.jpg', alignBottom: true),
              ],
            ),

            const SizedBox(height: 20),

            const Text("BY DESSERT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                RecipeImage(label: 'Ice Cream', path: 'images/Icecream.jpg', alignBottom: true),
                RecipeImage(label: 'Brownies', path: 'images/Brownies.jpg', alignBottom: true),
                RecipeImage(label: 'Pies', path: 'images/Pies.jpg', alignBottom: true),
                RecipeImage(label: 'Cookies', path: 'images/Cookies.jpg', alignBottom: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  final String label;
  final String path;
  final bool alignBottom;

  const RecipeImage({
    super.key,
    required this.label,
    required this.path,
    this.alignBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignBottom ? Alignment.bottomCenter : Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(path),
          radius: 45,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          color: Colors.black54,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
