//
//  SocketIOManager.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-02.
//

import Foundation
import SocketIO


class SocketIOManager: ObservableObject {
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    @Published var receivedMessage: String = ""
    @Published var word:String = ""
    @Published var count: Int = 0

    
    init() {
        // Setup the manager with the server URL and configuration
        manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
        socket = manager?.defaultSocket
        
        // Setup handlers
        setupSocketEvents()
        
        // Establish connection
        socket?.connect()
    }
    
    private func setupSocketEvents() {
        socket?.on(clientEvent: .connect) { [weak self] data, ack in
            print("Socket connected")
            self?.handleConnectionChange(connected: true)
        }

        socket?.on(clientEvent: .disconnect) { [weak self] data, ack in
            print("Socket disconnected")
            self?.handleConnectionChange(connected: false)
        }
        
        socket?.on("newMessage") {[weak self] data, ack in
            if let msg = data[0] as? String {
                print("Received message: \(msg)")
                DispatchQueue.main.async {
                    self?.receivedMessage = msg
                }

            }
            
        }
        
        socket?.on("word") {[weak self] data, ack in
            if let msg = data[0] as? String {
                print("Received word: \(msg)")
                DispatchQueue.main.async {
                    self?.word = msg
                }

            }
            
        }
        
        
        socket?.on("countUpdated") { [weak self] data, ack in
                if let newCount = data[0] as? Int {
                    DispatchQueue.main.async {
                        self?.count = newCount
                    }
                }
            }
    }
    
    
    func sendMessage(message: String) {
        socket?.emit("message", message)
    }
    
    func incrementCount() {
          count += 1
          socket?.emit("increment", count)
      }
    
    func shareWord(word: String) {
        socket?.emit("word", word)
    }
    
    private func handleConnectionChange(connected: Bool) {
        // Update connection status if you are tracking it
    }
    
    deinit {
        socket?.disconnect()
    }
}
