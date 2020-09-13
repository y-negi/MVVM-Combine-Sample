//
//  Item.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/08/30.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import Foundation

struct Item: Identifiable, Equatable {
    let id: String
    let title: String
    let userImageURL: URL?

    init(id: String, title: String, userImageURL: URL?) {
        self.id = id
        self.title = title
        self.userImageURL = userImageURL
    }

    init(response: ItemsResponse) {
        self.id = response.id
        self.title = response.title
        self.userImageURL = URL(string: response.user.profileImageUrl ?? "")
    }
}
