//
//  NetworkMonitoring.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import Network
import UIKit

final class NetworkMonitoring {
    
    // Public
    static var isConnection: Bool {
        if _isConnection {
            print("Internet Connection Is Active.")
        } else {
            print("No Internet Connection.")
        }
        return _isConnection
    }
    
    // Private
    private static weak var alert: UIViewController?
    private static let queue = DispatchQueue.global()
    private static var isAlertPresented: Bool { alert != nil }
    
    static let nwMonitor = {
        let nwMonitor = NWPathMonitor()
        nwMonitor.start(queue: queue)
        nwMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                _isConnection = path.status == .satisfied
            }
        }
        return nwMonitor
    }()
    
    private static var _isConnection: Bool = nwMonitor.currentPath.status == .satisfied {
        didSet {
            if !_isConnection {
                print("No internet connection.")
                self.showDisconnectionAlert()
            } else {
                print("Internet connection is active.")
                if isAlertPresented {
                    alert?.dismiss(animated: true)
                }
            }
        }
    }
    
    deinit {
        NetworkMonitoring.nwMonitor.cancel()
    }
    
    private static func showDisconnectionAlert() {
        guard !isAlertPresented else { return }
        
        let alert = UIViewController()
        
        let view = TitleSubtitleAlertView(
            titleText: "Connection is lost",
            subtitleText: "Please check your Internet connection and try again."
        )
        
        alert.view.addSubview(view)
        view.autoPinEdgesToSuperView()
        alert.modalPresentationStyle = .overCurrentContext
        
        SceneDelegate.shared?.window?.topViewController?.present(alert, animated: true)
        
        self.alert = alert
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
