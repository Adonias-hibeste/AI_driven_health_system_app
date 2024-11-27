// medication_reminder_model.dart
class MedicationReminder {
  final String medicineName;
  final String dosage;
  final DateTime time; // Using DateTime for time

  MedicationReminder({
    required this.medicineName,
    required this.dosage,
    required this.time,
  });
}
