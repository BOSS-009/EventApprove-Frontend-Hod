import 'package:flutter/material.dart';
import 'package:hod_app/screens/descfiles/wsdesc.dart';

class IVDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const IVDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Industrial Visit Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          utility.buildDetailRow(
              "Visit Title", details["visittitle"] ?? "N/A", context),
          utility.buildDetailRow(
              "Date of Visit", details["visitdate"] ?? "N/A", context),
          utility.buildDetailRow(
              "Name of the company", details["companyname"] ?? "N/A", context),
          utility.buildDetailRow(
              "Total Days", details["numdays"]?.toString() ?? "N/A", context),
          utility.buildDetailRow(
              "Organizers", details["organizers"] ?? "N/A", context),
          utility.buildDetailRow("Participants List",
              details["participantslist"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['participantslistname']),
          utility.buildDetailRow(
              "Industry Type", details["industrytype"] ?? "N/A", context),
          utility.buildDetailRow(
              "Conveners", details["conveners"] ?? "N/A", context),
          utility.buildDetailRow(
              "GPS Photos/Videos", details["gpsmedia"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['gpsmedianame'] ?? ""),
          utility.buildDetailRow(
              "Budget", details["budget"]?.toString() ?? "N/A", context),
          utility.buildDetailRow("Report", details["report"] ?? "N/A", context,
              isDocumentType: true, documentName: details['reportname'] ?? ""),
          utility.buildDetailRow("Feedback from Participants",
              details["feedback"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['feedbackname'] ?? ""),
          utility.buildDetailRow(
              "Certificates", details["certificates"] ?? "N/A", context,
              isDocumentType: true,
              documentName: details['certificatesname'] ?? ""),
          utility.buildDetailRow(
              "Speakers", details["speakersdetails"] ?? "N/A", context),
        ]),
      ),
    );
  }
}
