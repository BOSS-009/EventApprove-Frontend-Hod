import 'package:flutter/material.dart';
import 'package:hod_app/screens/descfiles/wsdesc.dart';

class SADesc extends StatefulWidget {
  final Map<String, dynamic> details;

  const SADesc({super.key, required this.details});

  @override
  State<SADesc> createState() => _SADescState();
}

class _SADescState extends State<SADesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Achievement Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            utility.buildDetailRow("Names of Students",
                widget.details["studentnames"] ?? "N/A", context),
            utility.buildDetailRow(
                "USNs", widget.details["usns"] ?? "N/A", context),
            utility.buildDetailRow("Year of Study",
                widget.details["yearofstudy"] ?? "N/A", context),
            utility.buildDetailRow(
                "Event Type", widget.details["eventtype"] ?? "N/A", context),
            utility.buildDetailRow(
                "Event Title", widget.details["eventtitle"] ?? "N/A", context),
            utility.buildDetailRow("Date of Achievement",
                widget.details["achievementdate"] ?? "N/A", context),
            utility.buildDetailRow("Company/Organization",
                widget.details["companyorganization"] ?? "N/A", context),
            utility.buildDetailRow(
                "Recognition", widget.details["recognition"] ?? "N/A", context),
            utility.buildDetailRow("Certificate Proof",
                widget.details["certificateproof"] ?? "N/A", context,
                isDocumentType: true,
                documentName:
                    widget.details['certificateproofname'] ?? "Document"),
            utility.buildDetailRow(
                "GPS Photo", widget.details["gpsphoto"] ?? "N/A", context,
                isDocumentType: true,
                documentName: widget.details['gpsphotoname'] ?? "Document"),
            utility.buildDetailRow(
                "Report", widget.details["report"] ?? "N/A", context,
                isDocumentType: true,
                documentName: widget.details['reportname'] ?? "Document"),
          ],
        ),
      ),
    );
  }
}
