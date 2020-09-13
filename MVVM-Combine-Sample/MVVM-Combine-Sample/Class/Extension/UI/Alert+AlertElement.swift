//
//  Alert+AlertElement.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/09/05.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import SwiftUI

extension Alert {

    /// AlertElementを利用してinitialize
    /// - Parameter alertElement: AlertElement
    init(alertElement: AlertElement) {
        let toButton = { (type: AlertElement.AlertButtonType) -> Alert.Button in
            switch type {
            case .default(let title, let action):
                return .default(Text(title), action: action ?? {})
            case .cancel(let title, let action):
                if let title = title {
                    return .cancel(Text(title), action: action ?? {})
                } else {
                    return .cancel(action ?? {})
                }
            case .destructive(let title, let action):
                return .destructive(Text(title), action: action ?? {})
            }
        }

        if let primaryButton = alertElement.primaryButton,
            let secondaryButton = alertElement.secondaryButton {
                self.init(title: Text(alertElement.title ?? ""),
                          message: alertElement.message != nil ? Text(alertElement.message!) : nil,
                          primaryButton: toButton(primaryButton),
                          secondaryButton: toButton(secondaryButton))
        } else if let primaryButton = alertElement.primaryButton {
            self.init(title: Text(alertElement.title ?? ""),
                      message: alertElement.message != nil ? Text(alertElement.message!) : nil,
                      dismissButton: toButton(primaryButton))
        } else {
            self.init(title: Text(alertElement.title ?? ""),
                      message: alertElement.message != nil ? Text(alertElement.message!) : nil)
        }
    }

}
