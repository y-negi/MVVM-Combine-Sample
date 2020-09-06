//
//  ItemListRow.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/09/05.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import SwiftUI

struct ItemListRow: View {
    private let item: Item

    init(item: Item) {
        self.item = item
    }

    var body: some View {
        HStack {
            Text(self.item.title)
                .bold()
        }
    }
}

struct ItemListRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemListRow(item: Item(id: "1", title: "title", userImageURL: nil))
    }
}
