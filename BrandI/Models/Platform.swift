//
//  Platform.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//


import SwiftUI

enum Platform: String, Codable, Hashable, CaseIterable {
    case instagram = "Instagram"
    case twitter = "Twitter"
    case linkedin = "LinkedIn"
    case tiktok = "TikTok"
    case siri = "Siri"
    
    
    // Get the correct icon image based on the platform and color scheme
    func iconName(for colorScheme: ColorScheme) -> String {
        switch (self, colorScheme) {
        case (.instagram, .light): return "Intagram icon Dark"
        case (.instagram, .dark): return "Intagram icon Light"

        case (.twitter, .light): return "X icon Dark"
        case (.twitter, .dark): return "X icon Light"
        case (.linkedin, .light): return "Linkedin icon Dark"
        case (.linkedin, .dark): return "Linkedin icon Light"
        case (.tiktok, .light): return "Tiktok icon Dark"
        case (.tiktok, .dark): return "Tiktok icon Light"
        case (.siri, .light): return "SiriIcon"
        case (.siri, .dark): return "SiriIcon"
        }
    }
    
//    // Get raw string values
//    static func rawValues(from platforms: [Platform]) -> [String] {
//        return platforms.map { $0.rawValue }
//    }
}

