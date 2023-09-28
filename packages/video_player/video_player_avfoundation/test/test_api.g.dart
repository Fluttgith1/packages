// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:video_player_avfoundation/src/messages.g.dart';

class _TestHostVideoPlayerApiCodec extends StandardMessageCodec {
  const _TestHostVideoPlayerApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ClearCacheMessageResponse) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is CreateMessage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is IsCacheSupportedMessage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is IsSupportedMessageResponse) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is LoopingMessage) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is MixWithOthersMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is PlaybackSpeedMessage) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is PositionMessage) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is TextureMessage) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is VolumeMessage) {
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
        return ClearCacheMessageResponse.decode(readValue(buffer)!);
      case 129:
        return CreateMessage.decode(readValue(buffer)!);
      case 130:
        return IsCacheSupportedMessage.decode(readValue(buffer)!);
      case 131:
        return IsSupportedMessageResponse.decode(readValue(buffer)!);
      case 132:
        return LoopingMessage.decode(readValue(buffer)!);
      case 133:
        return MixWithOthersMessage.decode(readValue(buffer)!);
      case 134:
        return PlaybackSpeedMessage.decode(readValue(buffer)!);
      case 135:
        return PositionMessage.decode(readValue(buffer)!);
      case 136:
        return TextureMessage.decode(readValue(buffer)!);
      case 137:
        return VolumeMessage.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestHostVideoPlayerApi {
  static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding =>
      TestDefaultBinaryMessengerBinding.instance;
  static const MessageCodec<Object?> codec = _TestHostVideoPlayerApiCodec();

  void initialize();

  TextureMessage create(CreateMessage msg);

  void dispose(TextureMessage msg);

  void setLooping(LoopingMessage msg);

  ClearCacheMessageResponse clearCache();

  void setVolume(VolumeMessage msg);

  IsSupportedMessageResponse isCacheSupportedForNetworkMedia(
      IsCacheSupportedMessage msg);

  void setPlaybackSpeed(PlaybackSpeedMessage msg);

  void play(TextureMessage msg);

  PositionMessage position(TextureMessage msg);

  Future<void> seekTo(PositionMessage msg);

  void pause(TextureMessage msg);

  void setMixWithOthers(MixWithOthersMessage msg);

  static void setup(TestHostVideoPlayerApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.initialize',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          // ignore message
          api.initialize();
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.create',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.create was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CreateMessage? arg_msg = (args[0] as CreateMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.create was null, expected non-null CreateMessage.');
          final TextureMessage output = api.create(arg_msg!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.dispose',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.dispose was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final TextureMessage? arg_msg = (args[0] as TextureMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.dispose was null, expected non-null TextureMessage.');
          api.dispose(arg_msg!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setLooping',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setLooping was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final LoopingMessage? arg_msg = (args[0] as LoopingMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setLooping was null, expected non-null LoopingMessage.');
          api.setLooping(arg_msg!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.clearCache',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          // ignore message
          final ClearCacheMessageResponse output = api.clearCache();
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setVolume',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setVolume was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final VolumeMessage? arg_msg = (args[0] as VolumeMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setVolume was null, expected non-null VolumeMessage.');
          api.setVolume(arg_msg!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.isCacheSupportedForNetworkMedia',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.isCacheSupportedForNetworkMedia was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final IsCacheSupportedMessage? arg_msg =
              (args[0] as IsCacheSupportedMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.isCacheSupportedForNetworkMedia was null, expected non-null IsCacheSupportedMessage.');
          final IsSupportedMessageResponse output =
              api.isCacheSupportedForNetworkMedia(arg_msg!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setPlaybackSpeed',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setPlaybackSpeed was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PlaybackSpeedMessage? arg_msg =
              (args[0] as PlaybackSpeedMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setPlaybackSpeed was null, expected non-null PlaybackSpeedMessage.');
          api.setPlaybackSpeed(arg_msg!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.play',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.play was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final TextureMessage? arg_msg = (args[0] as TextureMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.play was null, expected non-null TextureMessage.');
          api.play(arg_msg!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.position',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.position was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final TextureMessage? arg_msg = (args[0] as TextureMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.position was null, expected non-null TextureMessage.');
          final PositionMessage output = api.position(arg_msg!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.seekTo',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.seekTo was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PositionMessage? arg_msg = (args[0] as PositionMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.seekTo was null, expected non-null PositionMessage.');
          await api.seekTo(arg_msg!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.pause',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.pause was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final TextureMessage? arg_msg = (args[0] as TextureMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.pause was null, expected non-null TextureMessage.');
          api.pause(arg_msg!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setMixWithOthers',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setMixWithOthers was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final MixWithOthersMessage? arg_msg =
              (args[0] as MixWithOthersMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.setMixWithOthers was null, expected non-null MixWithOthersMessage.');
          api.setMixWithOthers(arg_msg!);
          return <Object?>[];
        });
      }
    }
  }
}
