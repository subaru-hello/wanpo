import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // title: Text('プライバシーポリシー'),
      //     ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle('プライバシーポリシー'),
            _buildSectionContent('当社は、お客様から以下の情報を取得します：'),
            _buildList([
              '氏名(ニックネームやペンネームも含む)',
              '性別',
              'メールアドレス',
              '写真や動画',
              'クレジットカード、銀行口座、電子マネー等のお客様の決済手段に関する情報',
              '外部サービスでお客様が利用するID、その他外部サービスのプライバシー設定によりお客様が連携先に開示を認めた情報',
              'Cookie(クッキー)を用いて生成された識別情報',
              'OSが生成するID、端末の種類、端末識別子等のお客様が利用するOSや端末に関する情報',
              '当社ウェブサイトの滞在時間、入力履歴、購買履歴等の当社ウェブサイトにおけるお客様の行動履歴',
              '当社アプリの起動時間、入力履歴、購買履歴等の当社アプリの利用履歴',
              'お客様の位置情報',
              '歩数や犬の状態などのヘルス情報',
            ]),
            _buildSectionTitle('お客様の情報を利用する目的'),
            _buildSectionContent('当社は、お客様から取得した情報を、以下の目的のために利用します：'),
            _buildList([
              '当社サービスに関する登録の受付、お客様の本人確認、認証のため',
              'お客様の当社サービスの利用履歴を管理するため',
              '利用料金の決済のため',
              '当社サービスにおけるお客様の行動履歴を分析し、当社サービスの維持改善に役立てるため',
              '広告の配信、表示及び効果測定のため',
              'お客様の趣味嗜好にあわせたターゲティング広告を表示するため',
              '当社のサービスに関するご案内をするため',
              '提携する事業者・サービスのご案内をお送りするため',
              'お客様からのお問い合わせに対応するため',
              '当社の規約や法令に違反する行為に対応するため',
              '当社サービスの変更、提供中止、終了、契約解除をご連絡するため',
              '当社規約の変更等を通知するため',
              '以上の他、当社サービスの提供、維持、保護及び改善のため',
            ]),
            _buildSectionTitle('安全管理のために講じた措置'),
            _buildSectionContent(
                '当社が、お客様から取得した情報に関して安全管理のために講じた措置につきましては、末尾記載のお問い合わせ先にご連絡をいただきましたら、法令の定めに従い個別にご回答させていただきます。'),
            _buildSectionTitle('第三者提供'),
            _buildSectionContent(
                '当社は、お客様から取得する情報のうち、個人データに該当するものついては、あらかじめお客様の同意を得ずに、第三者に提供しません。但し、次の場合は除きます：'),
            _buildList([
              '個人データの取扱いを外部に委託する場合',
              '当社や当社サービスが買収された場合',
              '事業パートナーと共同利用する場合',
              'その他、法律によって合法的に第三者提供が許されている場合',
            ]),
            _buildSectionTitle('アクセス解析ツール'),
            _buildSectionContent(
                '当社は、お客様のアクセス解析のために、「Googleアナリティクス」を利用しています。詳しくは以下からご確認ください。'),
            _buildLink(
                'https://marketingplatform.google.com/about/analytics/terms/jp/'),
            _buildSectionTitle('広告の配信'),
            _buildSectionContent(
                '当社は、Google及びそのパートナーの提供する広告を設置しています。詳しくは以下のページをご覧ください。'),
            _buildLink('https://policies.google.com/technologies/ads'),
            _buildSectionTitle('プライバシーポリシーの変更'),
            _buildSectionContent(
                '当社は、必要に応じて、このプライバシーポリシーの内容を変更します。この場合、変更後のプライバシーポリシーの施行時期と内容を適切な方法により周知または通知します。'),
            _buildSectionTitle('お問い合わせ'),
            _buildSectionContent(
                'お客様の情報の開示、情報の訂正、利用停止、削除をご希望の場合は、以下のメールアドレスにご連絡ください。'),
            _buildLink('withbichon@gmail.com'),
            _buildSectionTitle('事業者の氏名'),
            _buildSectionContent('Subaru Nakano'),
            _buildSectionTitle('事業者の住所'),
            _buildSectionContent('東京都'),
            _buildSectionContent('2024年02月21日 制定'),
          ],
        ),
      ),
    );
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

  Widget _buildSectionContent(String text) {
    return Text(text);
  }

  Widget _buildList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Text('・$item')).toList(),
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
