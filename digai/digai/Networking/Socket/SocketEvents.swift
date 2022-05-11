//
//  SocketEvents.swift
//  digai
//
//  Created by Jacqueline Alves on 07/05/22.
//

import Foundation

enum SocketEvents: String, SocketEvent {
    case createRoom = "create-room"
    case joinRoom = "join-room"
    case roomUpdate = "room-update"
    case start
    case propagateStart = "propagate-start"
    case stop
    case propagateStop = "propagate-stop"
    case trackAssert = "trackAssert"
    case resume = "resume"
    case unknown
}
