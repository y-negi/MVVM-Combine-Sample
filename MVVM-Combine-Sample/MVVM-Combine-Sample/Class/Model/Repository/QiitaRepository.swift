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
    /// - Parameters:
    ///   - page: ページ
    ///   - perPage: 1ページの取得数
    /// - Returns: Future<記事一覧, エラー>
    func fetchItems(page: Int, perPage: Int) -> Future<[ItemsResponse], Error> {
        Future<[ItemsResponse], Error> { promise in
            self.provider
                .requestPublisher(.items(page: page, perPage: perPage))
                .map([ItemsResponse].self, using: JSONDecoder(keyDecodingStrategy: .convertFromSnakeCase))
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("QiitaAPI.fetchItems Failed!\n\(error.localizedDescription)")
                        promise(.failure(error))
                    }
                },
                      receiveValue: { response in
                        print("QiitaAPI.fetchItems Success!\n\(response)")
                        promise(.success(response))
                })
                .store(in: &self.cancellables)
        }
    }

}
