//
//  Platform.swift
//  Challange1
//
//  Created by Gehad Eid on 26/10/2024.
//


import SwiftUI

enum Platform: String, Codable, CaseIterable {
    case instagram = "Instagram"
    case facebook = "Facebook"
    case twitter = "Twitter"
    case linkedin = "LinkedIn"
    case snapchat = "Snapchat"
    case tiktok = "TikTok"
    
    // Get the correct icon image based on the platform and color scheme
    func iconName(for colorScheme: ColorScheme) -> String {
        switch (self, colorScheme) {
        case (.instagram, .dark): return "InstagramIconDark"
        case (.instagram, .light): return "InstagramIconLight"
        case (.facebook, .dark): return "FacebookIconDark"
        case (.facebook, .light): return "FacebookIconLight"
        case (.twitter, .dark): return "TwitterIconDark"
        case (.twitter, .light): return "TwitterIconLight"
        case (.linkedin, .dark): return "LinkedInIconDark"
        case (.linkedin, .light): return "LinkedInIconLight"
        case (.snapchat, .dark): return "SnapchatIconDark"
        case (.snapchat, .light): return "SnapchatIconLight"
        case (.tiktok, .dark): return "TikTokIconDark"
        case (.tiktok, .light): return "TikTokIconLight"
        }
    }
    
//    // Get raw string values
//    static func rawValues(from platforms: [Platform]) -> [String] {
//        return platforms.map { $0.rawValue }
//    }
}

