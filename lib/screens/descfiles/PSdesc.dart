import 'package:flutter/material.dart';
import 'package:hod_app/screens/descfiles/wsdesc.dart';

class PSDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const PSDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Professional Society Activity Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            utility.buildDetailRow(
                "Society Name", details["societyname"] ?? "N/A", context),
            utility.buildDetailRow(
                "Date", details["activitydate"] ?? "N/A", context),
            utility.buildDetailRow(
                "Activity Type", details["activitytype"] ?? "N/A", context),
            utility.buildDetailRow(
                "Event Type", details["eventtype"] ?? "N/A", context),
            utility.buildDetailRow("Number of Days",
                details["numberofdays"]?.toString() ?? "N/A", context),
            utility.buildDetailRow("GPS Photos/Videos",
                details["gpsphotosvideos"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details['gpsphotosvideosname'] ?? "Document"),
            utility.buildDetailRow("Budget Sanctioned",
                details["budgetsanctioned"]?.toString() ?? "N/A", context),
            utility.buildDetailRow(
                "Report", details["eventreport"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details['eventreportname'] ?? "Document"),
            utility.buildDetailRow(
                "Organizers", details["organizers"] ?? "N/A", context),
            utility.buildDetailRow(
                "Conveners", details["conveners"] ?? "N/A", context),
            utility.buildDetailRow(
                "Feedback", details["feedback"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details['feedbackname'] ?? "Document"),
            utility.buildDetailRow("Participants List",
                details["participantslist"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details['participantslistname'] ?? "Document"),
            utility.buildDetailRow(
                "Certificates", details["certificates"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details['certificatesname'] ?? "Document"),
            utility.buildDetailRow("Speakers Details",
                details["speakerdetails"] ?? "N/A", context),
          ],
        ),
      ),
    );
  }
}
