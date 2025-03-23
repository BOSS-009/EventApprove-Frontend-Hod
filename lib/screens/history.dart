import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'event.dart'; // Import EventScreen

class HistoryScreen extends StatefulWidget {
  final List<Map<String, String>> events;

  const HistoryScreen({super.key, required this.events});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime? selectedDate;
  List<Map<String, String>> filteredEvents = [];

  void _filterEvents(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    setState(() {
      filteredEvents = widget.events.where((event) {
        return event['date'] == formattedDate;
      }).toList();
    });
  }

  Future<void> _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    setState(() {
      selectedDate = pickedDate;
    });
    _filterEvents(pickedDate);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event History"),
        backgroundColor: const Color(0xff2f3652),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showDatePicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2196F3),
              ),
              child: const Text("Select Date"),
            ),
            const SizedBox(height: 20),
            if (selectedDate != null)
              Text(
                "Events on ${DateFormat('yyyy-MM-dd').format(selectedDate!)}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(event['title'] ?? 'Event'),
                      subtitle: Text(
                        "${event['type']} by ${event['faculty']} at ${event['venue']}",
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventScreen(
                                eventDetails: event,
                              ),
                            ),
                          );
                        },
                        child: const Text("More Info"),
                      ),
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
