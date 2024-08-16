// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v21.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import, no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:in_app_purchase_storekit/src/messages2.g.dart';


class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is SK2SubscriptionOfferMessage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else     if (value is SK2SubscriptionPeriodMessage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else     if (value is SK2SubscriptionInfoMessage) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else     if (value is SK2ProductMessage) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else     if (value is SK2PriceLocaleMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else     if (value is SK2TransactionMessage) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else     if (value is SK2ProductPurchaseOptionsMessage) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else     if (value is SK2ProductTypeMessage) {
      buffer.putUint8(136);
      writeValue(buffer, value.index);
    } else     if (value is SK2SubscriptionOfferTypeMessage) {
      buffer.putUint8(137);
      writeValue(buffer, value.index);
    } else     if (value is SK2SubscriptionOfferPaymentModeMessage) {
      buffer.putUint8(138);
      writeValue(buffer, value.index);
    } else     if (value is SK2SubscriptionPeriodUnitMessage) {
      buffer.putUint8(139);
      writeValue(buffer, value.index);
    } else     if (value is SK2ProductPurchaseResultMessage) {
      buffer.putUint8(140);
      writeValue(buffer, value.index);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129: 
        return SK2SubscriptionOfferMessage.decode(readValue(buffer)!);
      case 130: 
        return SK2SubscriptionPeriodMessage.decode(readValue(buffer)!);
      case 131: 
        return SK2SubscriptionInfoMessage.decode(readValue(buffer)!);
      case 132: 
        return SK2ProductMessage.decode(readValue(buffer)!);
      case 133: 
        return SK2PriceLocaleMessage.decode(readValue(buffer)!);
      case 134: 
        return SK2TransactionMessage.decode(readValue(buffer)!);
      case 135: 
        return SK2ProductPurchaseOptionsMessage.decode(readValue(buffer)!);
      case 136: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : SK2ProductTypeMessage.values[value];
      case 137: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : SK2SubscriptionOfferTypeMessage.values[value];
      case 138: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : SK2SubscriptionOfferPaymentModeMessage.values[value];
      case 139: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : SK2SubscriptionPeriodUnitMessage.values[value];
      case 140: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : SK2ProductPurchaseResultMessage.values[value];
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
