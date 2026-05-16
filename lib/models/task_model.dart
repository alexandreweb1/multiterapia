import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { pending, completed }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String instructions;
  final String? link;
  final String therapistId;
  final String patientId;
  final String patientName;
  final TaskStatus status;
  final DateTime scheduledAt;
  final DateTime? completedAt;
  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.instructions,
    this.link,
    required this.therapistId,
    required this.patientId,
    required this.patientName,
    required this.status,
    required this.scheduledAt,
    this.completedAt,
    required this.createdAt,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      instructions: data['instructions'] as String? ?? '',
      link: data['link'] as String?,
      therapistId: data['therapistId'] as String? ?? '',
      patientId: data['patientId'] as String? ?? '',
      patientName: data['patientName'] as String? ?? '',
      status: data['status'] == 'completed' ? TaskStatus.completed : TaskStatus.pending,
      scheduledAt: (data['scheduledAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'title': title,
        'description': description,
        'instructions': instructions,
        'link': link,
        'therapistId': therapistId,
        'patientId': patientId,
        'patientName': patientName,
        'status': status == TaskStatus.completed ? 'completed' : 'pending',
        'scheduledAt': Timestamp.fromDate(scheduledAt),
        'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  TaskModel copyWith({TaskStatus? status, DateTime? completedAt}) => TaskModel(
        id: id,
        title: title,
        description: description,
        instructions: instructions,
        link: link,
        therapistId: therapistId,
        patientId: patientId,
        patientName: patientName,
        status: status ?? this.status,
        scheduledAt: scheduledAt,
        completedAt: completedAt ?? this.completedAt,
        createdAt: createdAt,
      );
}
