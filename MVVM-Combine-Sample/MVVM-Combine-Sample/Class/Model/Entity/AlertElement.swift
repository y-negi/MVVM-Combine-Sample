//
//  AlertElement.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/09/05.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import Foundation

struct AlertElement {
    enum AlertButtonType {
        case `default`(title: String, action: (() -> Void)? = nil)
        case cancel(title: String? = nil, action: (() -> Void)? = nil)
        case destructive(title: String, action: (() -> Void)?  = nil)
    }

    var isShow = false
    var title: String?
    var message: String?
    var primaryButton: AlertButtonType?
    var secondaryButton: AlertButtonType?

    mutating func toShow(title: String?, message: String?, primaryButton: AlertButtonType? = nil, secondaryButton: AlertButtonType? = nil) {
        self.isShow = true
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
}
