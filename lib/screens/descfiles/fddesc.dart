import 'package:flutter/material.dart';
import 'package:hod_app/screens/descfiles/wsdesc.dart';

class FDDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const FDDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FDP Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            utility.buildDetailRow(
                "FDP Title", details["fdptitle"] ?? "N/A", context),
            utility.buildDetailRow("Mode", details["mode"] ?? "N/A", context),
            utility.buildDetailRow(
                "Brochure", details["brochure"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details["brochurename"] ?? ""),
            utility.buildDetailRow("Date", details["dates"] ?? "N/A", context),
            utility.buildDetailRow("Number of Days",
                details["days"]?.toString() ?? "N/A", context),
            utility.buildDetailRow(
                "GPS Photos", details["gpsmedia"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details["gpsmedianame"] ?? ""),
            utility.buildDetailRow(
                "Report", details["report"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details["reportname"] ?? ""),
            utility.buildDetailRow(
                "Organizers", details["organizers"] ?? "N/A", context),
            utility.buildDetailRow(
                "Conveners", details["conveners"] ?? "N/A", context),
            utility.buildDetailRow(
                "Feedback", details["feedback"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details["feedbackname"] ?? ""),
            utility.buildDetailRow("Participants List",
                details["participantslist"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details["participantslistname"] ?? ""),
            utility.buildDetailRow(
                "Certificates", details["certificates"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details["certificatesname"] ?? ""),
            utility.buildDetailRow("Amount Sanctioned",
                details["sanctionedamount"]?.toString() ?? "N/A", context),
            utility.buildDetailRow(
                "Faculty Receiving Sanctioned Amount",
                details["facultyreceivingamount"]?.toString() ?? "N/A",
                context),
            utility.buildDetailRow("Expenditure Report with Receipts",
                details["expenditurereport"] ?? "N/A", context,
                isDocumentType: true,
                documentName: details["expenditurereportname"] ?? ""),
            utility.buildDetailRow("Details of Speakers/Resource Persons",
                details["speakersdetails"] ?? "N/A", context),
            utility.buildDetailRow(
                "Sponsorship", details["sponsorship"] ?? "N/A", context),
          ],
        ),
      ),
    );
  }
}
