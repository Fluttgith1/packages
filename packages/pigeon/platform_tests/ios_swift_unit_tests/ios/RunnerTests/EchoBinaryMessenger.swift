// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Foundation
import Flutter

class EchoBinaryMessenger: NSObject, FlutterBinaryMessenger {
  let codec: FlutterMessageCodec
  private(set) var count = 0
  var defaultReturn: Any?
  
  init(codec: FlutterMessageCodec) {
    self.codec = codec
    super.init()
  }
  
  func send(onChannel channel: String, message: Data?) {
    // Method not implemented because this messenger is just for echoing
  }
  
  func send(
    onChannel channel: String,
    message: Data?,
    binaryReply callback: FlutterBinaryReply? = nil
  ) {
    guard
      let args = codec.decode(message) as? [Any?],
      args.count > 0,
      let firstArg = args[0],
      firstArg is NSNull == false
    else {
      if let value = defaultReturn {
        callback?(codec.encode(value))
      } else {
        callback?(nil)
      }
      return
    }
    
    callback?(codec.encode(firstArg))
  }
  
  func setMessageHandlerOnChannel(
    _ channel: String, binaryMessageHandler handler:
    FlutterBinaryMessageHandler? = nil
  ) -> FlutterBinaryMessengerConnection {
    self.count += 1
    return .init(self.count)
  }
  
  func cleanUpConnection(_ connection: FlutterBinaryMessengerConnection) {
    // Method not implemented because this messenger is just for echoing    
  }
}
