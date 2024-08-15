// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon, do not edit directly.
// See also: https://pub.dev/packages/pigeon

#ifndef PIGEON_MESSAGES_G_H_
#define PIGEON_MESSAGES_G_H_
#include <flutter/basic_message_channel.h>
#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/standard_message_codec.h>

#include <map>
#include <optional>
#include <string>

namespace pigeon_example {

// Generated class from Pigeon.

class FlutterError {
 public:
  explicit FlutterError(const std::string& code) : code_(code) {}
  explicit FlutterError(const std::string& code, const std::string& message)
      : code_(code), message_(message) {}
  explicit FlutterError(const std::string& code, const std::string& message,
                        const flutter::EncodableValue& details)
      : code_(code), message_(message), details_(details) {}

  const std::string& code() const { return code_; }
  const std::string& message() const { return message_; }
  const flutter::EncodableValue& details() const { return details_; }

 private:
  std::string code_;
  std::string message_;
  flutter::EncodableValue details_;
};

template <class T>
class ErrorOr {
 public:
  ErrorOr(const T& rhs) : v_(rhs) {}
  ErrorOr(const T&& rhs) : v_(std::move(rhs)) {}
  ErrorOr(const FlutterError& rhs) : v_(rhs) {}
  ErrorOr(const FlutterError&& rhs) : v_(std::move(rhs)) {}

  bool has_error() const { return std::holds_alternative<FlutterError>(v_); }
  const T& value() const { return std::get<T>(v_); };
  const FlutterError& error() const { return std::get<FlutterError>(v_); };

 private:
  friend class ExampleHostApi;
  friend class MessageFlutterApi;
  ErrorOr() = default;
  T TakeValue() && { return std::get<T>(std::move(v_)); }

  std::variant<T, FlutterError> v_;
};

enum class Code { kOne = 0, kTwo = 1 };

// Generated class from Pigeon that represents data sent in messages.
class MessageData {
 public:
  // Constructs an object setting all non-nullable fields.
  explicit MessageData(const Code& code, const flutter::EncodableMap& data);

  // Constructs an object setting all fields.
  explicit MessageData(const std::string* name, const std::string* description,
                       const Code& code, const flutter::EncodableMap& data);

  const std::string* name() const;
  void set_name(const std::string_view* value_arg);
  void set_name(std::string_view value_arg);

  const std::string* description() const;
  void set_description(const std::string_view* value_arg);
  void set_description(std::string_view value_arg);

  const Code& code() const;
  void set_code(const Code& value_arg);

  const flutter::EncodableMap& data() const;
  void set_data(const flutter::EncodableMap& value_arg);

 private:
  static MessageData FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class ExampleHostApi;
  friend class MessageFlutterApi;
  friend class PigeonInternalCodecSerializer;
  std::optional<std::string> name_;
  std::optional<std::string> description_;
  Code code_;
  flutter::EncodableMap data_;
};

class PigeonInternalCodecSerializer : public flutter::StandardCodecSerializer {
 public:
  PigeonInternalCodecSerializer();
  inline static PigeonInternalCodecSerializer& GetInstance() {
    static PigeonInternalCodecSerializer sInstance;
    return sInstance;
  }

  void WriteValue(const flutter::EncodableValue& value,
                  flutter::ByteStreamWriter* stream) const override;

 protected:
  flutter::EncodableValue ReadValueOfType(
      uint8_t type, flutter::ByteStreamReader* stream) const override;
};

// Generated interface from Pigeon that represents a handler of messages from
// Flutter.
class ExampleHostApi {
 public:
  ExampleHostApi(const ExampleHostApi&) = delete;
  ExampleHostApi& operator=(const ExampleHostApi&) = delete;
  virtual ~ExampleHostApi() {}
  virtual ErrorOr<std::string> GetHostLanguage() = 0;
  virtual ErrorOr<int64_t> Add(int64_t a, int64_t b) = 0;
  virtual void SendMessage(const MessageData& message,
                           std::function<void(ErrorOr<bool> reply)> result) = 0;

  // The codec used by ExampleHostApi.
  static const flutter::StandardMessageCodec& GetCodec();
  // Sets up an instance of `ExampleHostApi` to handle messages through the
  // `binary_messenger`.
  static void SetUp(flutter::BinaryMessenger* binary_messenger,
                    ExampleHostApi* api);
  static void SetUp(flutter::BinaryMessenger* binary_messenger,
                    ExampleHostApi* api,
                    const std::string& message_channel_suffix);
  static flutter::EncodableValue WrapError(std::string_view error_message);
  static flutter::EncodableValue WrapError(const FlutterError& error);

 protected:
  ExampleHostApi() = default;
};
// Generated class from Pigeon that represents Flutter messages that can be
// called from C++.
class MessageFlutterApi {
 public:
  MessageFlutterApi(flutter::BinaryMessenger* binary_messenger);
  MessageFlutterApi(flutter::BinaryMessenger* binary_messenger,
                    const std::string& message_channel_suffix);
  static const flutter::StandardMessageCodec& GetCodec();
  void FlutterMethod(const std::string* a_string,
                     std::function<void(const std::string&)>&& on_success,
                     std::function<void(const FlutterError&)>&& on_error);

 private:
  flutter::BinaryMessenger* binary_messenger_;
  std::string message_channel_suffix_;
};

}  // namespace pigeon_example
#endif  // PIGEON_MESSAGES_G_H_
