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
        ZStack {
            NavigationView {
                List(self.viewModel.items) { item in
                    ItemListRow(item: item)
                        .onAppear {
                            self.viewModel.rowWillAppear(item: item)
                    }
                }
                .navigationBarTitle("記事一覧")
            }
            .alert(isPresented: self.$viewModel.alertElement.isShow) {
                Alert(alertElement: self.viewModel.alertElement)
            }

            LoadingIndicatorView(isLoading: self.viewModel.isLoading)
        }
        .onAppear(perform: self.viewModel.bodyWillAppear)
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
