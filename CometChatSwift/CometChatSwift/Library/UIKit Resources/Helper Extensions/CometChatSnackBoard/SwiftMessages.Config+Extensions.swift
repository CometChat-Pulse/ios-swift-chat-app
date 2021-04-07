//
//  CometChatSnackBoard.Config+Extensions.swift
//  CometChatSnackBoard
//
//  Created by Timothy Moose on 12/26/20.
//  Copyright © 2020 SwiftKick Mobile. All rights reserved.
//

import UIKit

extension CometChatSnackBoard.Config {
    var windowLevel: UIWindow.Level? {
        switch presentationContext {
        case .window(let level): return level
        case .windowScene(_, let level): return level
        default: return nil
        }
    }

    @available (iOS 13.0, *)
    var windowScene: UIWindowScene? {
        switch presentationContext {
        case .windowScene(let scene, _): return scene
        default:
            #if CometChatSnackBoard_APP_EXTENSIONS
            return nil
            #else
            return UIWindow.keyWindow?.windowScene
            #endif
        }
    }

    var shouldBecomeKeyWindow: Bool {
        if let becomeKeyWindow = becomeKeyWindow { return becomeKeyWindow }
        switch dimMode {
        case .gray, .color, .blur:
            // Should become key window in modal presentation style
            // for proper VoiceOver handling.
            return true
        case .none:
            return false
        }
    }
}