import 'package:json_annotation/json_annotation.dart';

part 'coin_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Coin {
  @JsonKey(defaultValue: 0)
  final double quantity;
  @JsonKey(defaultValue: 0)
  final double price;

  Coin(this.quantity, this.price);

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
