import 'dart:typed_data';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';

class DataFilterService {
  List<Map<String, dynamic>> filterConferences(
    List<Map<String, dynamic>> conferences, {
    DateTime? startDate,
    DateTime? endDate,
    String searchQuery = "",
  }) {
    List<String> ignoredFields = [
      "brochure",
      "gpsmedia",
      "report",
      "feedback",
      "participantslist",
      "certificates",
      "expenditurereport",
      "document",
      "gpsphoto",
      "proof",
      "certificateproof",
      "gpsphotosvideos",
      "eventreport",
    ];

    return conferences.where((conference) {
      // Skip ignored fields in each conference
      final filteredConference = Map.from(conference);
      ignoredFields.forEach((ignoredField) {
        filteredConference.remove(ignoredField);
      });

      final publicationDate = DateTime.parse(conference['created_date']);
      final isWithinDateRange =
          (startDate == null || publicationDate.isAfter(startDate)) &&
              (endDate == null || publicationDate.isBefore(endDate));

      // Filter based on the remaining fields, excluding ignored ones.
      final matchesQuery = filteredConference.values.any((value) =>
          value.toString().toLowerCase().contains(searchQuery.toLowerCase()));

      return isWithinDateRange && matchesQuery;
    }).toList();
  }

  Future<void> downloadConferencesAsExcelSyncfusion(
      List<Map<String, dynamic>> conferences,
      List<String> ignoredFields,
      String filename) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    // Add headers to the first row.
    if (conferences.isNotEmpty) {
      final headers = conferences.first.keys
          .where((key) => !ignoredFields.contains(key))
          .toList();

      for (int i = 0; i < headers.length; i++) {
        sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
      }

      // Add data rows.
      for (int rowIndex = 0; rowIndex < conferences.length; rowIndex++) {
        final row = conferences[rowIndex];
        int columnIndex = 0;

        for (final key in headers) {
          columnIndex++;
          final cellValue = row[key]?.toString() ?? '';
          sheet.getRangeByIndex(rowIndex + 2, columnIndex).setText(cellValue);
        }
      }
    }

    // Save the workbook as bytes.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Save the file locally using FileSaver.
    try {
      await FileSaver.instance.saveFile(
        name: filename,
        bytes: Uint8List.fromList(bytes),
        ext: 'xlsx',
        mimeType: MimeType.other, // Use MimeType.other.
        customMimeType:
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', // Provide custom MIME type for Excel.
      );
    } catch (e) {
      debugPrint("Error saving file: $e");
    }
  }

  AppBar buildAppBar(
      BuildContext context,
      TextEditingController searchController,
      String searchQuery,
      Function(String) onSearchChanged,
      DateTime? startDate,
      DateTime? endDate,
      VoidCallback applyFilters,
      VoidCallback clearFilters,
      {required VoidCallback openDatePicker,
      required List<Map<String, dynamic>> conferences,
      required filename,
      required VoidCallback onRefresh}) {
    // Added onRefresh parameter

    List<String> ignoredFields = [
      "brochure",
      "gpsmedia",
      "report",
      "feedback",
      "participantslist",
      "certificates",
      "expenditurereport",
      "document",
      "gpsphoto",
      "proof",
      "certificateproof",
      "gpsphotosvideos",
      "eventreport",
    ];

    // Filter conferences based on the current filters.
    final filteredConferences = filterConferences(
      conferences,
      startDate: startDate,
      endDate: endDate,
      searchQuery: searchQuery,
    );

    return AppBar(
      title: Column(
        children: [
          Text(filename),
          if (filteredConferences.length != conferences.length)
            Text(
              "Filtered Results: ${filteredConferences.length}",
              style: const TextStyle(fontSize: 14),
            ),
        ],
      ),
      backgroundColor: const Color(0xffcc9f1f),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 16),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 14),
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    onSearchChanged(value); // Pass the updated value
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.date_range, color: Colors.black),
                onPressed: openDatePicker,
              ),
              IconButton(
                icon: const Icon(Icons.download, color: Colors.black),
                onPressed: () {
                  downloadConferencesAsExcelSyncfusion(
                      conferences, ignoredFields, filename);
                },
              ),
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.black),
                onPressed: clearFilters,
              ),
              IconButton(
                icon: const Icon(Icons.refresh,
                    color: Colors.black), // Added refresh button
                onPressed: onRefresh, // Call the onRefresh function
              ),
            ],
          ),
        ),
      ],
    );
  }
}
