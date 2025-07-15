// Import Flutter material design library
import 'package:flutter/material.dart';

// Define a stateful widget for the Lab 6 Shopping List Page
class Lab6ShoppingListPage extends StatefulWidget {
  const Lab6ShoppingListPage({super.key}); // Constructor with optional key

  // Create mutable state for this widget
  @override
  State<Lab6ShoppingListPage> createState() => _Lab6ShoppingListPageState();
}

// State class that holds the UI and logic
class _Lab6ShoppingListPageState extends State<Lab6ShoppingListPage> {
  // Controller to get text input for item name
  final TextEditingController _itemController = TextEditingController();

  // Controller to get text input for item quantity
  final TextEditingController _quantityController = TextEditingController();

  // List of items; each item is a Map with 'name' and 'qty'
  final List<Map<String, String>> _shoppingList = [];

  // Main build method to render the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a custom background color
      appBar: AppBar(
        title: const Text('Lab 6 - Shopping List'), // Title of the page
        backgroundColor: Colors.deepPurple[200], // Light purple color
      ),

      // Main content area with padding
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around all sides

        // Column to arrange widgets vertically
        child: Column(
          children: [
            // Row containing two text fields and a button
            Row(
              children: [
                // TextField for item name input
                Expanded(
                  flex: 2, // Takes 2/3 of the horizontal space
                  child: TextField(
                    controller: _itemController, // Connects to item input
                    decoration: const InputDecoration(
                      labelText: 'Type the item here', // Label inside box
                      border: OutlineInputBorder(), // Draw border box
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between inputs

                // TextField for quantity input
                Expanded(
                  flex: 1, // Takes 1/3 of the horizontal space
                  child: TextField(
                    controller: _quantityController, // Connects to quantity input
                    decoration: const InputDecoration(
                      labelText: 'Type the quantity here', // Label inside box
                      border: OutlineInputBorder(), // Draw border box
                    ),
                    keyboardType: TextInputType.number, // Show number keyboard
                  ),
                ),
                const SizedBox(width: 10), // Space before button

                // Button to add item and quantity to list
                ElevatedButton(
                  onPressed: _addItem, // Trigger addItem function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[100], // Button color
                    foregroundColor: Colors.deepPurple[900], // Text color
                  ),
                  child: const Text('Add'), // Text on button
                ),
              ],
            ),

            const SizedBox(height: 20), // Space before the list

            // If the list is empty, show a message
            _shoppingList.isEmpty
                ? const Text(
              'There are no items in the list', // Message when list is empty
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
            // Otherwise, show the list using ListView.builder
                : Expanded(
              child: ListView.builder(
                itemCount: _shoppingList.length, // Total items
                itemBuilder: (context, index) {
                  final item = _shoppingList[index]; // Get item

                  // Each row is clickable and responds to long-press
                  return GestureDetector(
                    onLongPress: () => _confirmDelete(index), // Show delete dialog
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0), // Row padding
                      child: Center(
                        child: Text(
                          '${index + 1}: ${item["name"]}  quantity: ${item["qty"]}', // Display item
                          style: const TextStyle(fontSize: 16), // Font size
                          textAlign: TextAlign.center, // Center align text
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to add a new item to the list
  void _addItem() {
    String name = _itemController.text.trim(); // Get trimmed item name
    String qty = _quantityController.text.trim(); // Get trimmed quantity

    // Only add if both fields are not empty
    if (name.isNotEmpty && qty.isNotEmpty) {
      setState(() {
        _shoppingList.add({'name': name, 'qty': qty}); // Add item to list
        _itemController.clear(); // Clear item field
        _quantityController.clear(); // Clear quantity field
      });
    }
  }

  // Function to confirm item deletion via dialog
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete item?'), // Dialog title
        content: Text(
            'Do you want to delete "${_shoppingList[index]["name"]}" from the list?'), // Dialog message

        // Buttons for Yes and No
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog (No)
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _shoppingList.removeAt(index); // Delete the item
              });
              Navigator.pop(context); // Close dialog
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
