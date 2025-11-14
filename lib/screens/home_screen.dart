import 'package:flutter/material.dart';
import '../services/parse_service.dart';
import 'task_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ParseService parseService = ParseService();

  List tasks = [];
  bool loading = true;

  Future<void> loadTasks() async {
    setState(() => loading = true);
    try {
      tasks = await parseService.getTasks();
    } catch (e) {
      print("Error loading tasks: $e");
    }
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3EEFF), // soft lavender background

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE8E2FF), // pastel lavender
        title: Text(
          "Your Tasks",
          style: TextStyle(
            color: Color(0xff4B3F72),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xff4B3F72)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xffD95379)), // muted rose-pink
            onPressed: () async {
              await parseService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffC6B1F2), // pastel purple
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskEditScreen()),
          );
          loadTasks();
        },
      ),

      body: loading
          ? Center(
        child: CircularProgressIndicator(
          color: Color(0xffA68BF5),
        ),
      )
          : tasks.isEmpty
          ? Center(
        child: Text(
          "No tasks yet.\nTap + to add a new task.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff7C6C9E),
          ),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (_, i) {
          final task = tasks[i];
          return Container(
            margin: EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.08),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16),
              title: Text(
                task.get('title'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4B3F72),
                ),
              ),
              subtitle: Text(
                task.get('description'),
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff7A708E),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Color(0xffD95379)),
                onPressed: () async {
                  await parseService.deleteTask(task);
                  loadTasks();
                },
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskEditScreen(task: task),
                  ),
                );
                loadTasks();
              },
            ),
          );
        },
      ),
    );
  }
}
