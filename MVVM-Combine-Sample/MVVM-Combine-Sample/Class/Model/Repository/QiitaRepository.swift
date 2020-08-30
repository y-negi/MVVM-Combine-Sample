//
//  QiitaRepository.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/08/30.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import Foundation
import Combine
import CombineMoya
import Moya

final class QiitaRepository {

    private let provider: MoyaProvider<QiitaAPI>

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init

    init(provider: MoyaProvider<QiitaAPI>) {
        self.provider = provider
    }

    // MARK: - Public Func

    /// 記事一覧を取得
    /// - Returns: 記事一覧 or エラー
    func fetchItems() -> Future<[ItemsResponse], Error> {
        Future<[ItemsResponse], Error> { promise in
            self.provider
                .requestPublisher(.items)
                .map([ItemsResponse].self)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                },
                      receiveValue: { response in
                        promise(.success(response))
                })
                .store(in: &self.cancellables)
        }
    }

}
