import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hod_app/screens/utility.dart';

Utility utility = Utility();

class EventDesc extends StatefulWidget {
  final Map<String, dynamic> details;

  const EventDesc({super.key, required this.details});

  @override
  State<EventDesc> createState() => _EventDescState();
}

class _EventDescState extends State<EventDesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conference Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Paper Title", widget.details["papertitle"]!),
            _buildDetailRow("Abstract", widget.details["abstract"]!),
            _buildDetailRow(
                "Conference Name", widget.details["conferencename"]!),
            _buildDetailRow(
                "Publication Level", widget.details["publicationlevel"]!),
            _buildDetailRow(
                "Publication Date", widget.details["publicationdate"]!),
            _buildDetailRow("Publisher", widget.details["publisher"]!),
            _buildDetailRow("DOI, ISBN", widget.details["doiisbn"]!),
            _buildClickableLink("Proof Link", widget.details["prooflink"]!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final base64Document = widget.details["document"]!;
                utility.viewDocument(
                  base64Document,
                  widget.details["documentname"] ?? 'unknowndoc.pdf',
                  context,
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
            child: InkWell(
              onTap: () async {
                final Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cannot open the link")),
                  );
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
