import 'package:flutter/material.dart';
import '../services/parse_service.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TaskEditScreen extends StatefulWidget {
  final ParseObject? task;

  TaskEditScreen({this.task});

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleCtrl.text = widget.task!.get('title') ?? '';
      descCtrl.text = widget.task!.get('description') ?? '';
    }
  }

  save() async {
    if (widget.task == null) {
      await ParseService.createTask(titleCtrl.text, descCtrl.text);
    } else {
      await ParseService.updateTask(
        widget.task!,
        titleCtrl.text,
        descCtrl.text,
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.task == null;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFC3B1E1), // Soft Lavender
              Color(0xFFA890D3), // Pastel Purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            child: Column(
              children: [
                // Title
                Text(
                  isNew ? "Create Task" : "Edit Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  isNew ? "Add your new task details" : "Modify your task",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 40),

                // White Card
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.15),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Title Field
                      TextField(
                        controller: titleCtrl,
                        decoration: InputDecoration(
                          labelText: "Task Title",
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          prefixIcon:
                          Icon(Icons.title, color: Colors.deepPurple),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Description Field
                      TextField(
                        controller: descCtrl,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          prefixIcon: Icon(Icons.notes, color: Colors.deepPurple),
                          alignLabelWithHint: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      // Save Button
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: save,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Color(0xFFA890D3), // pastel purple
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 6,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
