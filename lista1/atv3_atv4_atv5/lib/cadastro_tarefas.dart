import 'package:flutter/material.dart';

enum TaskPriority { baixa, media, alta }

class DailyTasksPage extends StatefulWidget {
  const DailyTasksPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DailyTasksPageState createState() => _DailyTasksPageState();
}

class _DailyTasksPageState extends State<DailyTasksPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.baixa;
  final List<_Task> _tasks = [];

  void _addTask() {
    final name = _nameController.text.trim();
    final desc = _descController.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        _tasks.add(
          _Task(name: name, description: desc, priority: _selectedPriority),
        );
        _nameController.clear();
        _descController.clear();
        _selectedPriority = TaskPriority.baixa;
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas Diárias')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome da tarefa'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Prioridade:', style: TextStyle(fontWeight: FontWeight.bold)),
                RadioGroup<TaskPriority>(
                  groupValue: _selectedPriority,
                  onChanged: (TaskPriority? value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                  child: Column(
                    children: TaskPriority.values.map((priority) {
                      return ListTile(
                        title: Text(priority.name[0].toUpperCase() + priority.name.substring(1)),
                        leading: Radio<TaskPriority>(
                          value: priority,
                          // ignore: deprecated_member_use
                          groupValue: _selectedPriority,
                          // ignore: deprecated_member_use
                          onChanged: (TaskPriority? value) {
                            setState(() {
                              _selectedPriority = value!;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Adicionar Tarefa'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.done,
                      onChanged: (val) {
                        setState(() {
                          task.done = val ?? false;
                        });
                      },
                    ),
                    title: Text(task.name),
                    subtitle: Text(
                      '${task.description}\nPrioridade: ${task.priority.name[0].toUpperCase() + task.priority.name.substring(1)}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeTask(index),
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
}

class _Task {
  String name;
  String description;
  TaskPriority priority;
  bool done = false;
  _Task({
    required this.name,
    required this.description,
    required this.priority,
  });
}