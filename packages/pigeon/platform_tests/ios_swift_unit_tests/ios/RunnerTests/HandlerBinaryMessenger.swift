//
//  HandlerBinaryMessenger.swift
//  RunnerTests
//
//  Created by Ailton Vieira on 01/03/22.
//  Copyright © 2022 The Flutter Authors. All rights reserved.
//

import Foundation
import Flutter

typealias HandlerBinaryMessengerHandler = ([Any?])-> Any

class HandlerBinaryMessenger: NSObject, FlutterBinaryMessenger {
    let codec: FlutterMessageCodec
    let handler: HandlerBinaryMessengerHandler
    private var count = 0
    
    init(codec: FlutterMessageCodec, handler: @escaping HandlerBinaryMessengerHandler) {
        self.codec = codec
        self.handler = handler
        super.init()
    }
    
    func send(onChannel channel: String, message: Data?) {}
    
    func send(onChannel channel: String, message: Data?, binaryReply callback: FlutterBinaryReply? = nil) {
        guard let args = codec.decode(message) as? [Any?] else {
               callback?(nil)
               return
        }
        
        let result = self.handler(args)
        callback?(codec.encode(result))
    }
    
    func setMessageHandlerOnChannel(_ channel: String, binaryMessageHandler handler: FlutterBinaryMessageHandler? = nil) -> FlutterBinaryMessengerConnection {
        self.count += 1
        return .init(self.count)
    }
    
    func cleanUpConnection(_ connection: FlutterBinaryMessengerConnection) {}
}
