import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_client/src/services/s3_service.dart';

class ImageFromS3 extends StatefulWidget {
  // propsをconstructorで定義
  final String? imagePath;
  ImageFromS3({Key? key, this.imagePath}) : super(key: key);

  @override
  _ImageFromS3State createState() => _ImageFromS3State();
}

class _ImageFromS3State extends State<ImageFromS3> {
  Future<Image>? imageFuture;

  String get profileBucket => dotenv.env['PROFILE_BUCKET']!;

  @override
  void initState() {
    super.initState();
    // S3から画像を取得
    final s3Service = S3Service();
    imageFuture = s3Service.getImage(
        profileBucket, widget.imagePath ?? 'default-dog-img.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Image>(
          future: imageFuture, // 初期化時に作られたS3から取得した画像を渡す
          builder: (context, snapshot) {
            print("=====");
            print(snapshot.hasData);
            print("=====");

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // フェッチ中はローディング表示
            } else if (snapshot.hasError) {
              // Get object length
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // FIXME: 大きさ調節
              return SizedBox(
                height: 200,
                child: snapshot.data,
              );
            } else {
              return const Text('データが取得できていません');
            }
          },
        ),
      ),
    );
  }
}
