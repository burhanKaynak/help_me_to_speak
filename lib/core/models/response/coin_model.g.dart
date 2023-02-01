// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) => Coin(
      (json['quantity'] as num?)?.toDouble() ?? 0,
      (json['price'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'price': instance.price,
    };
