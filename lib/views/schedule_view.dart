import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:taskit/Edit%20pages/Edit_schedule.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Providers/schedule_provider.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = TextEditingController();
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: HorizontalCalendar(
                  date: DateTime.now(),
                  initialDate: DateTime.now(),
                  onDateSelected: (date) {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: searchTextController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  hintText: 'Search Schedule...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  suffixIcon: searchTextController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchTextController.clear();
                            context
                                .read<ScheduleProvider>()
                                .updateSearchQuery('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Rebuild to show/hide clear button
                  context.read<ScheduleProvider>().updateSearchQuery(
                      value); // Use updateSearchQuery instead of setSearchQuery
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
