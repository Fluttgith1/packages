// Autogenerated from Pigeon (v16.0.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import, no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:in_app_purchase_storekit/src/messages.g.dart';

class _TestInAppPurchaseApiCodec extends StandardMessageCodec {
  const _TestInAppPurchaseApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is SKErrorMessage) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is SKPaymentDiscountMessage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is SKPaymentMessage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is SKPaymentTransactionMessage) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is SKPriceLocaleMessage) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is SKProductDiscountMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is SKProductMessage) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is SKProductResponseMessage) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is SKProductSubscriptionPeriodMessage) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is SKStorefrontMessage) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return SKErrorMessage.decode(readValue(buffer)!);
      case 129: 
        return SKPaymentDiscountMessage.decode(readValue(buffer)!);
      case 130: 
        return SKPaymentMessage.decode(readValue(buffer)!);
      case 131: 
        return SKPaymentTransactionMessage.decode(readValue(buffer)!);
      case 132: 
        return SKPriceLocaleMessage.decode(readValue(buffer)!);
      case 133: 
        return SKProductDiscountMessage.decode(readValue(buffer)!);
      case 134: 
        return SKProductMessage.decode(readValue(buffer)!);
      case 135: 
        return SKProductResponseMessage.decode(readValue(buffer)!);
      case 136: 
        return SKProductSubscriptionPeriodMessage.decode(readValue(buffer)!);
      case 137: 
        return SKStorefrontMessage.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestInAppPurchaseApi {
  static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding => TestDefaultBinaryMessengerBinding.instance;
  static const MessageCodec<Object?> pigeonChannelCodec = _TestInAppPurchaseApiCodec();

  /// Returns if the current device is able to make payments
  bool canMakePayments();

  List<SKPaymentTransactionMessage?> transactions();

  SKStorefrontMessage storefront();

  void addPayment(Map<String?, Object?> paymentMap);

  SKProductResponseMessage startProductRequest(List<String?> productIdentifiers);

  static void setup(TestInAppPurchaseApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.canMakePayments', pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, (Object? message) async {
          try {
            final bool output = api.canMakePayments();
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.transactions', pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, (Object? message) async {
          try {
            final List<SKPaymentTransactionMessage?> output = api.transactions();
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.storefront', pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, (Object? message) async {
          try {
            final SKStorefrontMessage output = api.storefront();
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.addPayment', pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, (Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.addPayment was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final Map<String?, Object?>? arg_paymentMap = (args[0] as Map<Object?, Object?>?)?.cast<String?, Object?>();
          assert(arg_paymentMap != null,
              'Argument for dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.addPayment was null, expected non-null Map<String?, Object?>.');
          try {
            api.addPayment(arg_paymentMap!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.startProductRequest', pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(__pigeon_channel, (Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.startProductRequest was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final List<String?>? arg_productIdentifiers = (args[0] as List<Object?>?)?.cast<String?>();
          assert(arg_productIdentifiers != null,
              'Argument for dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchaseAPI.startProductRequest was null, expected non-null List<String?>.');
          try {
            final SKProductResponseMessage output = api.startProductRequest(arg_productIdentifiers!);
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
