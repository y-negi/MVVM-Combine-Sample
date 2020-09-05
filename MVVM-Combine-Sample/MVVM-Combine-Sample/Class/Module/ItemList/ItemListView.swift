//
//  ItemListView.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/08/30.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import SwiftUI
import Moya

struct ItemListView: View {
    @ObservedObject private var viewModel: ItemListViewModel

    init(isStub: Bool = false) {
        self.viewModel = ItemListViewModel(
            qiitaRepository: QiitaRepository(
                provider: MoyaProvider<QiitaAPI>(
                    stubClosure: isStub ? MoyaProvider.delayedStub(2) : MoyaProvider.neverStub
                )
            )
        )
    }

    var body: some View {
        NavigationView {
            List(self.viewModel.items) { item in
                ItemListRow(item: item)
            }
            .navigationBarTitle("記事一覧")
        }
        .onAppear(perform: self.viewModel.bodyWillAppear)
        .alert(isPresented: self.$viewModel.alertElement.isShow) {
            Alert(alertElement: self.viewModel.alertElement)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
