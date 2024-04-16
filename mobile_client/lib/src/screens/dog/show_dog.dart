import 'package:flutter/material.dart';
import 'package:mobile_client/src/models/dog.dart';
import 'package:mobile_client/src/widgets/dog/dog_detail_container.dart';
import 'package:mobile_client/src/widgets/image_from_s3.dart';

// 渡ってきたdogを表示させる。
class DogShowPage extends StatelessWidget {
  final Dog dog;
  DogShowPage({Key? key, required this.dog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${dog.nickname}の詳細'),
        ),
        body: Column(
          children: [
            Text(dog.nickname),
            SizedBox(
              height: 200,
              child: ImageFromS3(
                  imagePath: dog.profileImagePath ?? "default-dog-img.png"),
            ),
            Flexible(
              child: DogContainer(dog: dog),
            )
          ],
        ));
  }
}
