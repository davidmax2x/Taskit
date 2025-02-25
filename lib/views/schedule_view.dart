import 'package:flutter/material.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Providers/ScheduleProvider.dart';
import 'package:taskit/models/schedule_model.dart';
import 'package:taskit/Components/RegularTextField.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  List<Schedule> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filterEventsByDate(selectedDate);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            _showAddEventDialog(context, selectedDate);
          },
          icon: Icon(LucideIcons.plus,
              color: Theme.of(context).colorScheme.onPrimary),
          label: Text('Add Event',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Schedule',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.2),
                    child: Icon(
                      LucideIcons.user,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.8),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: HorizontalWeekCalendar(
                          showNavigationButtons: false,
                          initialDate: DateTime.now(),
                          minDate: DateTime(2000),
                          maxDate: DateTime(2030),
                          activeBackgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          monthColor: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(15),
                          activeTextColor:
                              Theme.of(context).colorScheme.primary,
                          inactiveTextColor: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.7),
                          onDateChange: (date) {
                            setState(() {
                              selectedDate = date;
                              _filterEventsByDate(date);
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                collapseMode: CollapseMode.pin,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchTextController,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    decoration: InputDecoration(
                      hintText: 'Search events...',
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(
                        LucideIcons.search,
                        color: Theme.of(context).colorScheme.primary,
                        size: 22,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      suffixIcon: searchTextController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                LucideIcons.x,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              onPressed: () {
                                searchTextController.clear();
                                context
                                    .read<ScheduleProvider>()
                                    .updateSearchQuery('');
                                _filterEventsByDate(selectedDate);
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final event = filteredEvents[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            event.title[0].toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                        title: Text(
                          event.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.description,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              event.time.isNotEmpty
                                  ? event.time
                                  : 'No time set',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: Icon(LucideIcons.ellipsisVertical,
                              color: Theme.of(context).colorScheme.onSurface),
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showEditEventDialog(context, event);
                            } else if (value == 'delete') {
                              _deleteEvent(event.id);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: ListTile(
                                leading: Icon(LucideIcons.pencil,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                title: const Text('Edit'),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(LucideIcons.trash,
                                    color: Theme.of(context).colorScheme.error),
                                title: const Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          _showEditEventDialog(context, event);
                        },
                      ),
                    ),
                  );
                },
                childCount: filteredEvents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterEventsByDate(DateTime date) {
    final allEvents = context.read<ScheduleProvider>().schedules;
    setState(() {
      filteredEvents = allEvents.where((event) => event.date == date).toList();
    });
  }

// Dialogue box
  void _showAddEventDialog(BuildContext context, DateTime selectedDate) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    TimeOfDay? selectedTime;
    bool addReminder = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 3,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              title: const Text('Add Event'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RegularTextField(
                    hint: 'Title',
                    controller: titleController,
                  ),
                  const SizedBox(height: 8),
                  RegularTextField(
                    hint: 'Description',
                    controller: descriptionController,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Select Time',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(LucideIcons.alarmClock),
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null && picked != selectedTime) {
                            setState(() {
                              selectedTime = picked;
                              timeController.text =
                                  selectedTime!.format(context);
                            });
                          }
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    title: const Text('Add Reminder'),
                    value: addReminder,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    checkboxShape: const RoundedRectangleBorder(),
                    onChanged: (bool? value) {
                      setState(() {
                        addReminder = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                  ),
                  onPressed: () {
                    // Save the event with default status 'Pending'
                    context.read<ScheduleProvider>().addSchedule(Schedule(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate,
                        day: selectedDate.day.toString(),
                        time: selectedTime?.format(context) ?? '',
                        status: 'Pending')); // Close the Schedule constructor
                    _filterEventsByDate(
                        selectedDate); // Update the filtered list
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Edit dialogue box
  void _showEditEventDialog(BuildContext context, Schedule event) {
    final TextEditingController titleController =
        TextEditingController(text: event.title);
    final TextEditingController descriptionController =
        TextEditingController(text: event.description);
    final TextEditingController timeController = TextEditingController(
      text: event.time,
    );
    TimeOfDay? selectedTime = event.time != ''
        ? TimeOfDay(
            hour: int.parse(event.time.split(':')[0]),
            minute: int.parse(event.time.split(':')[1].split(' ')[0]))
        : null;
    bool addReminder = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text('Edit Event'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RegularTextField(
                    hint: 'Title',
                    controller: titleController,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    textAlign: TextAlign.center,
                    controller: timeController,
                    readOnly: true,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Select Time',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: selectedTime ?? TimeOfDay.now(),
                          );
                          if (picked != null && picked != selectedTime) {
                            setState(() {
                              selectedTime = picked;
                              timeController.text =
                                  selectedTime!.format(context);
                            });
                          }
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    maxLines: 4, // Make the description field taller
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    title: const Text('Add Reminder'),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: addReminder,
                    onChanged: (bool? value) {
                      setState(() {
                        addReminder = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.secondary),
                  ),
                  onPressed: () {
                    // Update the event
                    context.read<ScheduleProvider>().updateSchedule(
                        int.parse(event.id),
                        Schedule(
                          id: event.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: event.date,
                          time: selectedTime?.format(context) ?? '',
                          day: event.day,
                          status: 'Pending',
                          reminder: addReminder,
                        ));
                    _filterEventsByDate(event.date); // Update the filtered list
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteEvent(String eventId) {
    context.read<ScheduleProvider>().deleteSchedule(int.parse(eventId));
    _filterEventsByDate(selectedDate); // Refresh the list after deletion
  }
}
