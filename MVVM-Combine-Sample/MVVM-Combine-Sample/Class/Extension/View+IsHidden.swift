//
//  View+IsHidden.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/09/06.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import SwiftUI

extension View {

    /// 引数に応じてhiddenを適用
    /// - Parameter hidden: 非表示にするか
    /// - Returns: 適用後のView
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }

}
