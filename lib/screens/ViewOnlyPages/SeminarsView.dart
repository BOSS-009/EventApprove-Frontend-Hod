import 'package:flutter/material.dart';
import 'package:hod_app/screens/appbar.dart';
import 'package:hod_app/screens/repository.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../descfiles/seminardesc.dart';

class SeminarsView extends StatefulWidget {
  const SeminarsView({super.key});

  @override
  State<SeminarsView> createState() => _SeminarsViewState();
}

class _SeminarsViewState extends State<SeminarsView> {
  Repository repository = Repository();
  final DataFilterService _filterService = DataFilterService();
  List<Map<String, dynamic>> filteredConferences = [];
  DateTime? startDate;
  DateTime? endDate;
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> seminars = [];

  Future<void> fetchEvent() async {
    final _conf = await repository.fetchEvents('seminar');
    setState(() {
      seminars = _conf;
      filteredConferences = _conf;
    });
  }

  void applyFilters() {
    setState(() {
      filteredConferences = _filterService.filterConferences(
        seminars,
        startDate: startDate,
        endDate: endDate,
        searchQuery: searchQuery,
      );
    });
  }

  void clearFilters() {
    setState(() {
      startDate = null;
      endDate = null;
      searchQuery = "";
      _searchController.clear();
      filteredConferences = List.from(seminars); // Reset to original data
    });
  }

  Future<void> updateConference(int conferenceId, bool status) async {
    await repository.updateEventApproval(conferenceId, status);
    fetchEvent();
  }

  Future<void> deleteConference(int masterId) async {
    await repository.deleteEvent(masterId);
    fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _filterService.buildAppBar(
        context,
        _searchController,
        searchQuery,
        (value) {
          setState(() {
            searchQuery = value;
            applyFilters();
          });
        },
        startDate,
        endDate,
        applyFilters,
        clearFilters,
        openDatePicker: openDatePicker,
        conferences: seminars,
        filename: 'Seminars',
        onRefresh: fetchEvent
      ),
      body: ListView.builder(
        itemCount: filteredConferences.length,
        itemBuilder: (context, index) {
          final seminar = filteredConferences[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                seminar["seminartitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Text("Mode: ${seminar["mode"]}"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Faculty: ${seminar['username']}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (seminar['approval'] == true) ...[
                    const Icon(Icons.check, color: Colors.green),
                    const SizedBox(width: 4),
                    const Text(
                      "Approved",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ] else if (seminar['approval'] == false) ...[
                    const Icon(Icons.close, color: Colors.red),
                    const SizedBox(width: 4),
                    const Text(
                      "Rejected",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ] else ...[
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        updateConference(seminar['master_id'], false);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        updateConference(seminar['master_id'], true);
                      },
                    ),
                  ],
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      deleteConference(seminar['master_id']);
                    },
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeminarDesc(details: seminar),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void openDatePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Date Range'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 300,
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  setState(() {
                    startDate = args.value.startDate;
                    endDate = args.value.endDate;
                  });
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                applyFilters();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Apply',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
