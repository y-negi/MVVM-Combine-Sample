//
//  ItemListViewModel.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/08/30.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import Foundation
import Combine

final class ItemListViewModel: ObservableObject {

    @Published var items: [Item] = []
    @Published var alertElement = AlertElement()
    @Published var isLoading = false

    private let qiitaRepository: QiitaRepository

    private let itemsPerPage = 20

    private var cancellables: Set<AnyCancellable> = []
    private var currentPage = 1

    // MARK: - Init

    init(qiitaRepository: QiitaRepository) {
        self.qiitaRepository = qiitaRepository
    }

    // MARK: - Public Func

    /// 画面表示時
    func bodyWillAppear() {
        if self.items.isEmpty {
            self.fetchItems()
        }
    }

    /// 行表示時
    /// - Parameter item: 表示された記事
    func rowWillAppear(item: Item) {
        if self.items.last == item, !self.isLoading {
            self.currentPage += 1
            self.fetchItems()
        }
    }

}

// MARK: - Private Func

private extension ItemListViewModel {

    /// 記事一覧を取得
    func fetchItems() {
        self.isLoading = true

        self.qiitaRepository.fetchItems(page: self.currentPage, perPage: self.itemsPerPage)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                self.isLoading = false

                if case .failure(let error) = completion {
                    self.alertElement.toShow(title: "ERROR",
                                             message: error.localizedDescription,
                                             primaryButton: .default(title: "Retry", action: self.bodyWillAppear),
                                             secondaryButton: .cancel())
                }
                },
                  receiveValue: { [weak self] response in
                    guard let self = self else { return }

                    self.isLoading = false

                    let responseItems = response.map { Item(response: $0) }
                    let notIncludedItems = responseItems.filter { item -> Bool in
                        !self.items.contains(where: { $0.id == item.id })
                    }
                    self.items.append(contentsOf: notIncludedItems)
            })
            .store(in: &self.cancellables)
    }

}
