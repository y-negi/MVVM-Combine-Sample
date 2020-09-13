//
//  JSONDecoder+KeyDecodingStrategyInit.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/09/13.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import Foundation

extension JSONDecoder {

    convenience init(keyDecodingStrategy: KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
    }

}
