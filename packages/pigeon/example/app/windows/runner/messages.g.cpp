// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon, do not edit directly.
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

// MessageData

MessageData::MessageData(const Code& code, const EncodableMap& data)
    : code_(code), data_(data) {}

MessageData::MessageData(const std::string* name,
                         const std::string* description, const Code& code,
                         const EncodableMap& data)
    : name_(name ? std::optional<std::string>(*name) : std::nullopt),
      description_(description ? std::optional<std::string>(*description)
                               : std::nullopt),
      code_(code),
      data_(data) {}

const std::string* MessageData::name() const {
  return name_ ? &(*name_) : nullptr;
}

void MessageData::set_name(const std::string_view* value_arg) {
  name_ = value_arg ? std::optional<std::string>(*value_arg) : std::nullopt;
}

void MessageData::set_name(std::string_view value_arg) { name_ = value_arg; }

const std::string* MessageData::description() const {
  return description_ ? &(*description_) : nullptr;
}

void MessageData::set_description(const std::string_view* value_arg) {
  description_ =
      value_arg ? std::optional<std::string>(*value_arg) : std::nullopt;
}

void MessageData::set_description(std::string_view value_arg) {
  description_ = value_arg;
}

const Code& MessageData::code() const { return code_; }

void MessageData::set_code(const Code& value_arg) { code_ = value_arg; }

const EncodableMap& MessageData::data() const { return data_; }

void MessageData::set_data(const EncodableMap& value_arg) { data_ = value_arg; }

EncodableList MessageData::ToEncodableList() const {
  EncodableList list;
  list.reserve(4);
  list.push_back(name_ ? EncodableValue(*name_) : EncodableValue());
  list.push_back(description_ ? EncodableValue(*description_)
                              : EncodableValue());
  list.push_back(EncodableValue((int)code_));
  list.push_back(EncodableValue(data_));
  return list;
}

MessageData MessageData::FromEncodableList(const EncodableList& list) {
  MessageData decoded((Code)(std::get<int32_t>(list[2])),
                      std::get<EncodableMap>(list[3]));
  auto& encodable_name = list[0];
  if (!encodable_name.IsNull()) {
    decoded.set_name(std::get<std::string>(encodable_name));
  }
  auto& encodable_description = list[1];
  if (!encodable_description.IsNull()) {
    decoded.set_description(std::get<std::string>(encodable_description));
  }
  return decoded;
}

ExampleHostApiCodecSerializer::ExampleHostApiCodecSerializer() {}

EncodableValue ExampleHostApiCodecSerializer::ReadValueOfType(
    uint8_t type, flutter::ByteStreamReader* stream) const {
  switch (type) {
    case 128:
      return CustomEncodableValue(MessageData::FromEncodableList(
          std::get<EncodableList>(ReadValue(stream))));
    default:
      return flutter::StandardCodecSerializer::ReadValueOfType(type, stream);
  }
}

void ExampleHostApiCodecSerializer::WriteValue(
    const EncodableValue& value, flutter::ByteStreamWriter* stream) const {
  if (const CustomEncodableValue* custom_value =
          std::get_if<CustomEncodableValue>(&value)) {
    if (custom_value->type() == typeid(MessageData)) {
      stream->WriteByte(128);
      WriteValue(
          EncodableValue(
              std::any_cast<MessageData>(*custom_value).ToEncodableList()),
          stream);
      return;
    }
  }
  flutter::StandardCodecSerializer::WriteValue(value, stream);
}

/// The codec used by ExampleHostApi.
const flutter::StandardMessageCodec& ExampleHostApi::GetCodec() {
  return flutter::StandardMessageCodec::GetInstance(
      &ExampleHostApiCodecSerializer::GetInstance());
}

// Sets up an instance of `ExampleHostApi` to handle messages through the
// `binary_messenger`.
void ExampleHostApi::SetUp(flutter::BinaryMessenger* binary_messenger,
                           ExampleHostApi* api) {
  {
    auto channel = std::make_unique<BasicMessageChannel<>>(
        binary_messenger,
        "dev.flutter.pigeon.pigeon_example_package.ExampleHostApi."
        "getHostLanguage",
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
  {
    auto channel = std::make_unique<BasicMessageChannel<>>(
        binary_messenger,
        "dev.flutter.pigeon.pigeon_example_package.ExampleHostApi.add",
        &GetCodec());
    if (api != nullptr) {
      channel->SetMessageHandler(
          [api](const EncodableValue& message,
                const flutter::MessageReply<EncodableValue>& reply) {
            try {
              const auto& args = std::get<EncodableList>(message);
              const auto& encodable_a_arg = args.at(0);
              if (encodable_a_arg.IsNull()) {
                reply(WrapError("a_arg unexpectedly null."));
                return;
              }
              const int64_t a_arg = encodable_a_arg.LongValue();
              const auto& encodable_b_arg = args.at(1);
              if (encodable_b_arg.IsNull()) {
                reply(WrapError("b_arg unexpectedly null."));
                return;
              }
              const int64_t b_arg = encodable_b_arg.LongValue();
              ErrorOr<int64_t> output = api->Add(a_arg, b_arg);
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
  {
    auto channel = std::make_unique<BasicMessageChannel<>>(
        binary_messenger,
        "dev.flutter.pigeon.pigeon_example_package.ExampleHostApi.sendMessage",
        &GetCodec());
    if (api != nullptr) {
      channel->SetMessageHandler(
          [api](const EncodableValue& message,
                const flutter::MessageReply<EncodableValue>& reply) {
            try {
              const auto& args = std::get<EncodableList>(message);
              const auto& encodable_message_arg = args.at(0);
              if (encodable_message_arg.IsNull()) {
                reply(WrapError("message_arg unexpectedly null."));
                return;
              }
              const auto& message_arg = std::any_cast<const MessageData&>(
                  std::get<CustomEncodableValue>(encodable_message_arg));
              api->SendMessage(message_arg, [reply](ErrorOr<bool>&& output) {
                if (output.has_error()) {
                  reply(WrapError(output.error()));
                  return;
                }
                EncodableList wrapped;
                wrapped.push_back(
                    EncodableValue(std::move(output).TakeValue()));
                reply(EncodableValue(std::move(wrapped)));
              });
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

// Generated class from Pigeon that represents Flutter messages that can be
// called from C++.
MessageFlutterApi::MessageFlutterApi(flutter::BinaryMessenger* binary_messenger)
    : binary_messenger_(binary_messenger) {}

const flutter::StandardMessageCodec& MessageFlutterApi::GetCodec() {
  return flutter::StandardMessageCodec::GetInstance(
      &flutter::StandardCodecSerializer::GetInstance());
}

void MessageFlutterApi::FlutterMethod(
    const std::string* a_string_arg,
    std::function<void(const std::string&)>&& on_success,
    std::function<void(const FlutterError&)>&& on_error) {
  auto channel = std::make_unique<BasicMessageChannel<>>(
      binary_messenger_,
      "dev.flutter.pigeon.pigeon_example_package.MessageFlutterApi."
      "flutterMethod",
      &GetCodec());
  EncodableValue encoded_api_arguments = EncodableValue(EncodableList{
      a_string_arg ? EncodableValue(*a_string_arg) : EncodableValue(),
  });
  channel->Send(
      encoded_api_arguments,
      [on_success = std::move(on_success), on_error = std::move(on_error)](
          const uint8_t* reply, size_t reply_size) {
        std::unique_ptr<EncodableValue> response =
            GetCodec().DecodeMessage(reply, reply_size);
        const auto& encodable_return_value = *response;
        const auto& return_value =
            std::get<std::string>(encodable_return_value);
        on_success(return_value);
      });
}

}  // namespace pigeon_example
