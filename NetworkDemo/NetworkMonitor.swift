//
//  NetworkMonitor.swift
//  NetworkDemo
//
//  Created by Sam Meech-Ward on 2021-07-19.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    enum ConnectionStatus {
        case connected(isExpensive: Bool, isConstrained: Bool)
        case disconnected
        case unknown
    }
    @Published var connectionStatus: ConnectionStatus = .unknown
    
    init() {
        monitor.pathUpdateHandler = pathUpdate
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    func pathUpdate(path: NWPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.connectionStatus = self.status(path: path)
        }
    }
    
    private func status(path: NWPath) -> ConnectionStatus {
        switch path.status {
        case .satisfied:
            return .connected(isExpensive: path.isConstrained, isConstrained: path.isExpensive)
        case .unsatisfied:
            return .disconnected
        case .requiresConnection:
            return .unknown
        @unknown default:
            return .unknown
        }
    }
}
