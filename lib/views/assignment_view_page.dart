import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:taskit/Edit%20pages/edit_assignment_page.dart';
import 'package:taskit/Providers/AssignmentProvider.dart';
import '../models/assignment_model.dart';
import '../Edit%20pages/assignment_details_page.dart';
import 'add_assignment_page.dart';

class AssignmentViewPage extends StatefulWidget {
  const AssignmentViewPage({super.key});

  @override
  State<AssignmentViewPage> createState() => _AssignmentViewPageState();
}

class _AssignmentViewPageState extends State<AssignmentViewPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssignmentProvider>(context);
    final totalAssignments = provider.assignments.length;
    final completedAssignments =
        provider.assignments.where((a) => a.isCompleted).length;
    final pendingAssignments =
        provider.assignments.where((a) => !a.isCompleted).length;
    final overdueAssignments = provider.assignments
        .where((a) => !a.isCompleted && a.dueDate.isBefore(DateTime.now()))
        .length;
    final progress =
        totalAssignments > 0 ? completedAssignments / totalAssignments : 0.0;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAssignmentPage(),
              ),
            );
          },
          child: Icon(LucideIcons.plus,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 300.0,
                toolbarHeight: 0,
                floating: false,
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 20,
                                          value: progress,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                              .withOpacity(0.2),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${(progress * 100).toStringAsFixed(0)}%',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Done',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary
                                                    .withOpacity(0.8),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildStatusTile(
                                      'Total Tasks',
                                      totalAssignments,
                                      LucideIcons.layoutGrid,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildStatusTile(
                                      'Pending',
                                      pendingAssignments,
                                      LucideIcons.clock,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildStatusTile(
                                      'Overdue',
                                      overdueAssignments,
                                      LucideIcons.circleAlert,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TabBar(
                      indicatorColor: Theme.of(context).colorScheme.onPrimary,
                      indicatorWeight: 3,
                      labelColor: Theme.of(context).colorScheme.onPrimary,
                      unselectedLabelColor: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.7),
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: 'ALL'),
                        Tab(text: 'PENDING'),
                        Tab(text: 'COMPLETED'),
                        Tab(text: 'OVERDUE'),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildAssignmentList('All'),
              _buildAssignmentList('Pending'),
              _buildAssignmentList('Completed'),
              _buildAssignmentList('Overdue'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTile(String title, int count, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 18,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentList(String category) {
    final provider = Provider.of<AssignmentProvider>(context);
    List<Assignment> assignments;

    switch (category) {
      case 'Pending':
        assignments = provider.assignments
            .where((a) => !a.isCompleted && a.dueDate.isAfter(DateTime.now()))
            .toList();
        break;
      case 'Completed':
        assignments = provider.assignments.where((a) => a.isCompleted).toList();
        break;
      case 'Overdue':
        assignments = provider.assignments
            .where((a) => !a.isCompleted && a.dueDate.isBefore(DateTime.now()))
            .toList();
        break;
      default:
        assignments = provider.assignments;
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return _buildAssignmentCard(assignment, index);
      },
    );
  }

  Widget _buildAssignmentCard(Assignment assignment, int index) {
    Color dueDateColor = _getDueDateColor(assignment.dueDate);
    String formattedDate =
        DateFormat('dd MMMM yyyy').format(assignment.dueDate);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        leading: Checkbox(
          value: assignment.isCompleted,
          onChanged: (bool? value) {
            Provider.of<AssignmentProvider>(context, listen: false)
                .toggleAssignmentStatus(index);
          },
        ),
        title: Text(
          '${assignment.courseCode}: ${assignment.title}',
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Due: $formattedDate',
              style: TextStyle(color: dueDateColor),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Priority: ${assignment.priority}',
              style: TextStyle(color: _getPriorityColor(assignment.priority)),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditAssignmentPage(
                index: index,
                assignment: assignment,
              ),
            ),
          );
        },
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Details') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignmentDetailsPage(
                    courseName: assignment.courseCode,
                    assignmentTitle: assignment.title,
                    description: assignment.description,
                    submissionMethod: assignment.submissionMethod,
                    notes: assignment.assignmentNotes,
                    dueDate: assignment.dueDate,
                    priority: assignment.priority,
                    index: index,
                  ),
                ),
              );
            } else if (value == 'Edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAssignmentPage(
                    index: index,
                    assignment: assignment,
                  ),
                ),
              );
            } else if (value == 'Delete') {
              Provider.of<AssignmentProvider>(context, listen: false)
                  .deleteAssignment(index);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Details',
              child: Text('View Details'),
            ),
            const PopupMenuItem<String>(
              value: 'Edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem<String>(
              value: 'Delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDueDateColor(DateTime dueDate) {
    final now = DateTime.now();
    if (dueDate.isBefore(now)) {
      return Colors.red; // Overdue
    } else if (dueDate.difference(now).inDays <= 3) {
      return Colors.orange; // Due soon
    } else {
      return Colors.green; // Not due soon
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
