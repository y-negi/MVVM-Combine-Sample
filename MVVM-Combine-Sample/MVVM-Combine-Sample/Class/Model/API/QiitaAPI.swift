//
//  QiitaAPI.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/08/29.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import Foundation
import Moya

enum QiitaAPI: TargetType {
    case items(page: Int, perPage: Int)
}

extension QiitaAPI {

    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2")!
    }

    var path: String {
        switch self {
        case .items: return "/items"
        }
    }

    var method: Moya.Method {
        switch self {
        case .items: return .get
        }
    }

    var sampleData: Data {
        switch self {
        case .items:
            let path = Bundle.main.path(forResource: "QiitaAPIItemsStub", ofType: "json")!
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        }
    }

    var task: Task {
        switch self {
        case .items(let page, let perPage):
            let parameters = [
                "page": page,
                "per_page": perPage
            ]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        let tokenFilePath = Bundle.main.path(forResource: "AccessToken", ofType: "text")!
        let token = (try? String(contentsOfFile: tokenFilePath)) ?? ""
        return ["Authorization": "Bearer \(token)"]
    }

}
