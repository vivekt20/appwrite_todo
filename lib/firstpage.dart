import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  @override
  State<Firstpage> createState() => _FirstPageState();
}

class _FirstPageState extends State<Firstpage> {
  TextEditingController todoController = TextEditingController();
  List<String> tasks = [];  // A list to store tasks.
  int? editingIndex;  // This will track the index of the task being edited.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: TextStyle(
              color: const Color.fromARGB(255, 33, 26, 26),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,  // Display the length of the tasks list.
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tasks[index],  // Display the task at the index.
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // Edit button
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      editingIndex = index;  // Set the index of the task being edited.
                      todoController.text = tasks[index];  // Load the task into the text field.
                    });
                    // Open the bottom sheet for editing
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildBottomSheet();
                      },
                    );
                  },
                ),
                // Delete button
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      tasks.removeAt(index);  // Remove the task from the list.
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            editingIndex = null;  // Reset editingIndex to null for adding new tasks.
          });
          // Open the bottom sheet for adding a new task
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomSheet();
            },
          );
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Helper function to build the bottom sheet (used for both adding and editing tasks)
  Widget _buildBottomSheet() {
    return Container(
      height: 250,  // Adjust height for the bottom sheet
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: todoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add or Edit Task",
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (todoController.text.isNotEmpty) {
                  setState(() {
                    if (editingIndex != null) {
                      // If we're editing an existing task
                      tasks[editingIndex!] = todoController.text;  // Update the task at editingIndex
                    } else {
                      // If we're adding a new task
                      tasks.add(todoController.text);  // Add the new task to the list
                    }
                  });
                  todoController.clear();  // Clear the input field.
                  Navigator.pop(context);  // Close the bottom sheet.
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(editingIndex == null ? "Add Task" : "Update Task"),
            ),
          ),
        ],
      ),
    );
  }
}
