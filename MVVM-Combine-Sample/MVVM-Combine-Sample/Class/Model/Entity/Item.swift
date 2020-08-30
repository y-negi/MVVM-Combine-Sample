//
//  Item.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/08/30.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import Foundation

struct Item: Identifiable {
    let id: String
    let title: String
    let userImageURL: URL?

    init(response: ItemsResponse) {
        self.id = response.id
        self.title = response.title
        self.userImageURL = URL(string: response.user.profileImageUrl ?? "")
    }
}
