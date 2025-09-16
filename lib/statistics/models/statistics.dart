class TaskOverview {
  final int completed;
  final int done;
  final int inProgress;
  final int pending;
  final int overdue;

  TaskOverview({
    required this.completed,
    required this.done,
    required this.inProgress,
    required this.pending,
    required this.overdue,
  });

  factory TaskOverview.fromJson(Map<String, dynamic> json) {
    final details = json['details'] as Map<String, dynamic>? ?? {};
    return TaskOverview(
      completed: details['COMPLETED'] ?? 0,
      done: details['DONE'] ?? 0,
      inProgress: details['IN_PROGRESS'] ?? 0,
      pending: details['PENDING'] ?? 0,
      overdue: details['OVERDUE'] ?? 0,
    );
  }
}

class TaskDistributionEntry {
  final String memberName;
  final int taskCount;
  final List<String> taskTitles;

  TaskDistributionEntry({
    required this.memberName,
    required this.taskCount,
    required this.taskTitles,
  });

  factory TaskDistributionEntry.fromJson(Map<String, dynamic> json) {
    return TaskDistributionEntry(
      memberName: json['memberName'] ?? '',
      taskCount: json['taskCount'] ?? 0,
      taskTitles: (json['taskTitles'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class TaskDistribution {
  final int totalTasks;
  final List<TaskDistributionEntry> entries;

  TaskDistribution({
    required this.totalTasks,
    required this.entries,
  });

  factory TaskDistribution.fromJson(Map<String, dynamic> json) {
    final details = json['details'] as Map<String, dynamic>? ?? {};
    final List<TaskDistributionEntry> entries = [];
    details.forEach((key, value) {
      entries.add(TaskDistributionEntry.fromJson(value));
    });
    return TaskDistribution(
      totalTasks: json['value'] ?? 0,
      entries: entries,
    );
  }
}

class RescheduledTasks {
  final int rescheduled;
  final int notRescheduled;

  RescheduledTasks({
    required this.rescheduled,
    required this.notRescheduled,
  });

  factory RescheduledTasks.fromJson(Map<String, dynamic> json) {
    final details = json['details'] as Map<String, dynamic>? ?? {};
    final total = details['total'] ?? 0;
    final rescheduled = details['rescheduled'] ?? 0;
    return RescheduledTasks(
      rescheduled: rescheduled,
      notRescheduled: total - rescheduled,
    );
  }
}

class AvgCompletionTime {
  final double avgDays;

  AvgCompletionTime({required this.avgDays});

  factory AvgCompletionTime.fromJson(Map<String, dynamic> json) {
    return AvgCompletionTime(
      avgDays: (json['value'] ?? 0).toDouble(),
    );
  }
}

class MemberStatistics {
  final TaskOverview overview;
  final TaskDistribution distribution;
  final RescheduledTasks rescheduledTasks;
  final AvgCompletionTime avgCompletionTime;

  MemberStatistics({
    required this.overview,
    required this.distribution,
    required this.rescheduledTasks,
    required this.avgCompletionTime,
  });
}
