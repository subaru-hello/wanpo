import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text("お問い合わせ先")),
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('公式インスタグラム'),
          FaIcon(FontAwesomeIcons.instagram),
          _buildLink("https://www.instagram.com/with_bichon"),
          _buildSectionTitle('メール'),
          Icon(Icons.email_outlined),
          _buildLink("withbichon@gmail.com")
        ],
      ),
    ));
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLink(String urlString) {
    final urlStr =
        urlString.contains("@gmail.com") ? 'mailto:$urlString' : urlString;
    final url = Uri.parse(urlStr);
    print(url);
    return InkWell(
      child: Text(
        urlString,
        style:
            TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
      ),
      onTap: () => _launchInBrowser(url),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
