import 'package:json_annotation/json_annotation.dart';

part 'coin_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Coin {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: 0)
  final int quantity;
  @JsonKey(defaultValue: 0)
  final double price;

  Coin({required this.id, required this.quantity, required this.price});

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
