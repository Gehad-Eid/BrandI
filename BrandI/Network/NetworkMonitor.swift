//
//  NetworkMonitor.swift
//  BrandI
//
//  Created by Gehad Eid on 20/11/2024.
//


import Foundation
import Network

class NetworkMonitor: ObservableObject {
    @Published var isConnectedToWiFi: Bool = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")

    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnectedToWiFi = path.usesInterfaceType(.wifi) && path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func checkWiFiConnection(completion: @escaping () -> Void) {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnectedToWiFi = path.usesInterfaceType(.wifi) && path.status == .satisfied
                completion()
            }
        }
    }
    
    deinit {
        monitor.cancel()
    }
}

