import 'package:mobile_client/src/constants/excrement/excrement_type.dart';
import 'package:mobile_client/src/models/walk_entry.dart';

class Excrement {
  String id;
  int? count;
  ExcrementType type;
  ExcrementSize size;
  ExcrementVolume volume;
  String? excramentImagePath;
  String walkEntryId;
  WalkEntry walkEntry;

  Excrement({
    required this.id,
    this.count,
    required this.type,
    required this.size,
    required this.volume,
    this.excramentImagePath,
    required this.walkEntryId,
    required this.walkEntry,
  });

  factory Excrement.fromJson(Map<String, dynamic> json) {
    return Excrement(
      id: json['id'] ?? '',
      count: json['count'] ?? 0,
      type: json['type'] ?? ExcrementType.pipi,
      size: json['size'] ?? ExcrementSize.short,
      volume: json['volume'] ?? ExcrementVolume.drop,
      excramentImagePath: json['excramentImagePath'],
      walkEntryId: json['walkEntryId'] ?? '',
      walkEntry: WalkEntry.fromJson(json['walkEntry']),
    );
  }
}
