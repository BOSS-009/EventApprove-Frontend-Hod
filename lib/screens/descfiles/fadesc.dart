import 'package:flutter/material.dart';
import 'package:hod_app/screens/descfiles/wsdesc.dart';

class FADesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const FADesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievement Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          utility.buildDetailRow(
              "Faculty Name", details["facultyname"] ?? "N/A", context),
          utility.buildDetailRow(
              "Designation", details["designation"] ?? "N/A", context),
          utility.buildDetailRow("Date of Achievement",
              details["achievementdate"] ?? "N/A", context),
          utility.buildDetailRow(
              "Recognition", details["recognition"] ?? "N/A", context),
          utility.buildDetailRow(
              "Event Name", details["eventname"] ?? "N/A", context),
          utility.buildDetailRow(
              "Award Name", details["awardname"] ?? "N/A", context),
          utility.buildDetailRow("Awarding Organization",
              details["awardingorganization"] ?? "N/A", context),
          utility.buildDetailRow(
              "GPS Photo", details["gpsphoto"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['gpsphotoname'] ?? "document"),
          utility.buildDetailRow("Report", details["report"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['reportname'] ?? "document"),
          utility.buildDetailRow("Proof", details["proof"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['proofname'] ?? "document"),
          utility.buildDetailRow(
              "Certificates", details["certificateproof"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['certificateproofname'] ?? "document"),
        ]),
      ),
    );
  }
}
