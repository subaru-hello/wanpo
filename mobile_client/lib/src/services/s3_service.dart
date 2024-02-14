import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:minio_new/minio.dart';
import 'dart:typed_data';

class S3Service {
  late final Minio minio;

  // Adjust the constructor to automatically configure the service
  S3Service() {
    final accessKey = dotenv.env['AWS_ACCESS_KEY']!;
    final secretKey = dotenv.env['AWS_SECRET_KEY']!;
    const endPoint = 's3-ap-northeast-1.amazonaws.com';
    const region = 'ap-northeast-1';
    minio = Minio(
        endPoint: endPoint,
        accessKey: accessKey,
        secretKey: secretKey,
        region: region);
  }

// S3からkeyが一致するobjectを取得
  Future<Image> getImage(String bucketName, String path) async {
    final stream = await minio.getObject(bucketName, path);

    final List<int> memory = [];
    await for (var value in stream) {
      memory.addAll(value);
    }
    return Image.memory(
      Uint8List.fromList(memory),
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }

  // APIから帰ってきたPresigned Urlを使ってS3へファイルアップロード
  Future<void> uploadToS3(
      Stream<Uint8List> file, String bucketName, String objectName) async {
    try {
      await minio.putObject(
        bucketName,
        objectName,
        file,
      );
      print('File uploaded successfully');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }
}
