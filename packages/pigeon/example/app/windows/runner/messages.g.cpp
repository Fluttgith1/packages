// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#undef _HAS_EXCEPTIONS

#include "messages.g.h"

#include <flutter/basic_message_channel.h>
#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/standard_message_codec.h>

#include <map>
#include <optional>
#include <string>

namespace pigeon_example {
using flutter::BasicMessageChannel;
using flutter::CustomEncodableValue;
using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;

/// The codec used by ExampleHostApi.
const flutter::StandardMessageCodec& ExampleHostApi::GetCodec() {
  return flutter::StandardMessageCodec::GetInstance(
      &flutter::StandardCodecSerializer::GetInstance());
}

// Sets up an instance of `ExampleHostApi` to handle messages through the
// `binary_messenger`.
void ExampleHostApi::SetUp(flutter::BinaryMessenger* binary_messenger,
                           ExampleHostApi* api) {
  {
    auto channel = std::make_unique<BasicMessageChannel<>>(
        binary_messenger, "dev.flutter.pigeon.ExampleHostApi.getHostLanguage",
        &GetCodec());
    if (api != nullptr) {
      channel->SetMessageHandler(
          [api](const EncodableValue& message,
                const flutter::MessageReply<EncodableValue>& reply) {
            try {
              ErrorOr<std::string> output = api->GetHostLanguage();
              if (output.has_error()) {
                reply(WrapError(output.error()));
                return;
              }
              EncodableList wrapped;
              wrapped.push_back(EncodableValue(std::move(output).TakeValue()));
              reply(EncodableValue(std::move(wrapped)));
            } catch (const std::exception& exception) {
              reply(WrapError(exception.what()));
            }
          });
    } else {
      channel->SetMessageHandler(nullptr);
    }
  }
}

EncodableValue ExampleHostApi::WrapError(std::string_view error_message) {
  return EncodableValue(
      EncodableList{EncodableValue(std::string(error_message)),
                    EncodableValue("Error"), EncodableValue()});
}

EncodableValue ExampleHostApi::WrapError(const FlutterError& error) {
  return EncodableValue(EncodableList{EncodableValue(error.code()),
                                      EncodableValue(error.message()),
                                      error.details()});
}

}  // namespace pigeon_example
