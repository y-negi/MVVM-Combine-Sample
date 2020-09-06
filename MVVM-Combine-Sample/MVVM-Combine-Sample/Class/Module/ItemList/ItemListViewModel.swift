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

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init

    init(qiitaRepository: QiitaRepository) {
        self.qiitaRepository = qiitaRepository
    }

    // MARK: - Public Func

    /// 画面表示時
    func bodyWillAppear() {
        self.isLoading = true

        self.qiitaRepository.fetchItems()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                self.isLoading = false

                if case .failure(let error) = completion {
                    self.alertElement.toShow(title: "ERROR",
                                             message: error.localizedDescription,
                                             primaryButton: .default(title: "Retry", action: self.bodyWillAppear),
                                             secondaryButton: .cancel())
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }

                self.isLoading = false

                self.items = response.map { Item(response: $0) }
            })
            .store(in: &self.cancellables)
    }

}
