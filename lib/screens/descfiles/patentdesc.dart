import 'package:flutter/material.dart';
import 'package:hod_app/screens/utility.dart';
import 'package:url_launcher/url_launcher.dart';

Utility utility = Utility();

class PatentDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const PatentDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patent Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            utility.buildDetailRow("Application Number", details["applicationnumber"]!, context),
            utility.buildDetailRow("Patent Number", details["patentnumber"]!, context),
            utility.buildDetailRow("Title", details["title"]!, context),
            utility.buildDetailRow("Inventor(s)", details["inventors"]!, context),
            utility.buildDetailRow("Patentee Name", details["patenteename"]!, context),
            utility.buildDetailRow("Filing Date", details["filingdate"]!, context),
            utility.buildDetailRow("Status", details["status"]!, context),
            utility.buildDetailRow("Patent Country", details["patentcountry"]!, context),
            utility.buildDetailRow("Publication/Granted Date", details["publicationdate"]!, context),
            utility.buildDetailRow("Abstract", details["abstract"]!, context),
            _buildClickableLink("Patent URL", details["url"]!),
            utility.buildDetailRow("Attached Document", details["document"]!, context,
                isDocumentType: true, documentName: details['documentname']),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableLink(String label, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () async {
                final Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Text(
                url,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
