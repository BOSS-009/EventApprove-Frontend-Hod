import 'package:flutter/material.dart';
import 'package:hod_app/screens/utility.dart';
import 'package:url_launcher/url_launcher.dart';

Utility utility = Utility();

class BCDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const BCDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Chapter Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Authors with Affiliations", details["authors"]!),
            _buildDetailRow("Paper Title", details["papertitle"]!),
            _buildDetailRow("Abstract", details["abstract"]!),
            _buildDetailRow("Journal Name", details["journalname"]!),
            _buildDetailRow("Publication Level", details["publicationlevel"]!),
            _buildDetailRow("Publication Date", details["publicationdate"]!),
            _buildDetailRow("Publisher", details["publisher"]!),
            _buildDetailRow("DOI", details["doi"]!),
            _buildLinkRow("Proof Link", details["prooflink"]!),
            _buildDetailRow("Scopus ID/WoS ID/ORCID ID", details["identifier"].toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                utility.viewDocument(
                  details['document'],
                  details["documentname"] ?? 'Document',
                  context,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Document downloaded successfully!"),
                  ),
                );
              },
              child: const Text("Download Document"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkRow(String label, String url) {
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
