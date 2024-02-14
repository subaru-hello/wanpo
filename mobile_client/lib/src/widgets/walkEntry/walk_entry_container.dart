import 'package:flutter/material.dart';
import 'package:mobile_client/src/models/walk_entry.dart';
import 'package:intl/intl.dart';

class WalkEntryContainer extends StatelessWidget {
  const WalkEntryContainer({
    super.key,
    required this.walkEntry,
  });
  final WalkEntry walkEntry;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF55C500), // ← 背景色を指定
            borderRadius: BorderRadius.all(
              Radius.circular(32), // ← 角丸を設定
            ),
          ),
          child: Column(
            children: [
              Text(
                walkEntry.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat('yyyy/MM/dd').format(walkEntry.createdAt),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text('Excrements:'),
              Column(
                children: walkEntry.excrements
                    .map((excrement) => Text(
                          'Type: ${excrement.type}, Count: ${excrement.count.toString()}',
                        ))
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
