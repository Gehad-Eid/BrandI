//
//  utilities.swift
//  Challange1
//
//  Created by Gehad Eid on 06/10/2024.
//

import Foundation
import UIKit
import SwiftUICore
import Photos

final class Utilities {
    static let shared = Utilities()
    private init() {}
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}

//Corner
struct TopCornersRoundedRectangle: Shape {
    var radius: CGFloat = 18
    var corners: UIRectCorner = [.topLeft, .topRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct BottomCornersRoundedRectangle: Shape {
    var radius: CGFloat = 18
    var corners: UIRectCorner = [.bottomLeft, .bottomRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

func checkPhotoLibraryPermission(isShowingPhotoPicker: Binding<Bool>) {
    let status = PHPhotoLibrary.authorizationStatus()
    switch status {
    case .authorized:
        // Permission granted, show the picker
                isShowingPhotoPicker.wrappedValue = true
    case .denied, .restricted, .notDetermined:
        // Request permission
        PHPhotoLibrary.requestAuthorization { newStatus in
            if newStatus == .authorized {
                DispatchQueue.main.async {
                    // Permission granted, show the picker
                            isShowingPhotoPicker.wrappedValue = true
                }
            }
        }
    default:
        print("Unknown authorization status.")
    }
}
