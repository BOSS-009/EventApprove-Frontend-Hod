// screens/event.dart
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final Map<String, String> eventDetails;

  const EventScreen({
    super.key,
    required this.eventDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Event Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff2f3652),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Title
            Text(
              eventDetails["title"] ?? "Event Title",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),

            // Event Info Card
            Card(
              color: const Color(0xfff8f9fd),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Type", eventDetails["type"]),
                    _buildInfoRow("Faculty", eventDetails["faculty"]),
                    _buildInfoRow("Venue", eventDetails["venue"]),
                    _buildInfoRow("Date", eventDetails["date"]),
                    _buildInfoRow("Time", eventDetails["time"]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description Section
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              eventDetails["description"] ??
                  "This is a detailed description of the event. Here you can explain what the event is about, the agenda, and any other relevant information attendees need to know.",
              style: const TextStyle(fontSize: 16, color: Color(0xff6c757d)),
            ),
            const SizedBox(height: 20),

            // Attachments Section
            const Text(
              "Attachments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),
            // Attached files placeholder
            Card(
              color: const Color(0xffe9ecef),
              elevation: 2,
              child: ListTile(
                leading:
                    const Icon(Icons.attach_file, color: Color(0xff333a56)),
                title: const Text("File1.pdf"),
                subtitle: const Text("PDF Document"),
                trailing: const Icon(Icons.download, color: Color(0xff2196F3)),
                onTap: () {
                  // Placeholder for file download or view action
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: const Color(0xffe9ecef),
              elevation: 2,
              child: ListTile(
                leading:
                    const Icon(Icons.attach_file, color: Color(0xff333a56)),
                title: const Text("Image.png"),
                subtitle: const Text("Image File"),
                trailing: const Icon(Icons.download, color: Color(0xff2196F3)),
                onTap: () {
                  // Placeholder for file download or view action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff333a56),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: const TextStyle(color: Color(0xff6c757d)),
            ),
          ),
        ],
      ),
    );
  }
}
