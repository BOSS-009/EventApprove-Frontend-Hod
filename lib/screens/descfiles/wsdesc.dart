import 'package:flutter/material.dart';
import 'package:hod_app/screens/utility.dart';

Utility utility = Utility();

class WSDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const WSDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workshop Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            utility.buildDetailRow(
              "Workshop Title",
              details["workshoptitle"] ?? "Not provided",
              context,
            ),
            utility.buildDetailRow(
              "Mode",
              details["mode"] ?? "Not provided",
              context,
            ),
            if (details["brochure"] != null)
              utility.buildDetailRow(
                "Brochure",
                details["brochure"]!,
                context,
                isDocumentType: true,
                documentName: details["brochurename"] ?? "Document",
              ),
            utility.buildDetailRow(
              "Date",
              details["dates"] ?? "Not provided",
              context,
            ),
            utility.buildDetailRow(
              "Number of Days",
              details["days"] ?? "Not provided",
              context,
            ),
            if (details["gpsmedia"] != null)
              utility.buildDetailRow(
                "GPS Photos",
                details["gpsmedia"]!,
                context,
                isDocumentType: true,
                documentName: details["gpsmedianame"] ?? "Document",
              ),
            if (details["report"] != null)
              utility.buildDetailRow(
                "Report",
                details["report"]!,
                context,
                isDocumentType: true,
                documentName: details["reportname"] ?? "Document",
              ),
            utility.buildDetailRow(
              "Organizers",
              details["organizers"] ?? "Not provided",
              context,
            ),
            utility.buildDetailRow(
              "Conveners",
              details["conveners"] ?? "Not provided",
              context,
            ),
            if (details["feedback"] != null)
              utility.buildDetailRow(
                "Feedback",
                details["feedback"]!,
                context,
                isDocumentType: true,
                documentName: details["feedbackname"] ?? "Document",
              ),
            if (details["participantslist"] != null)
              utility.buildDetailRow(
                "Participants List",
                details["participantslist"]!,
                context,
                isDocumentType: true,
                documentName: details["participantslistname"] ?? "Document",
              ),
            if (details["certificates"] != null)
              utility.buildDetailRow(
                "Certificates",
                details["certificates"]!,
                context,
                isDocumentType: true,
                documentName: details["certificatesname"] ?? "Document",
              ),
            utility.buildDetailRow(
              "Amount Sanctioned",
              details["sanctionedamount"] ?? "Not provided",
              context,
            ),
            utility.buildDetailRow(
              "Faculty Receiving Sanctioned Amount",
              details["facultyreceivingamount"] ?? "Not provided",
              context,
            ),
            if (details["expenditurereport"] != null)
              utility.buildDetailRow(
                "Expenditure Report with Receipts",
                details["expenditurereport"]!,
                context,
                isDocumentType: true,
                documentName: details["expenditurereportname"] ?? "Document",
              ),
            utility.buildDetailRow(
              "Details of Speakers/Resource Persons",
              details["speakersdetails"] ?? "Not provided",
              context,
            ),
          ])),
    );
  }
}
