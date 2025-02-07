import 'package:flutter/material.dart';
import 'package:taskit/Edit%20pages/Edit_schedule.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Providers/schedule_provider.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule List'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditSchedule()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ScheduleProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: provider.schedules.length,
            itemBuilder: (context, index) {
              final schedule = provider.schedules[index];
              return Card(
                color: Theme.of(context).colorScheme.surface,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(schedule.title),
                  subtitle: Text('${schedule.description}\n${schedule.date}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      provider.removeSchedule(index);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditSchedule(
                          scheduleToEdit: schedule,
                          scheduleIndex: index,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
