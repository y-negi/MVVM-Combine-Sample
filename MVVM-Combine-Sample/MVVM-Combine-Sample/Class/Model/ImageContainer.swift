//
//  ImageContainer.swift
//  MVVM-Combine-Sample
//
//  Created by 根岸 裕太 on 2020/09/13.
//  Copyright © 2020 根岸 裕太. All rights reserved.
//

import UIKit

final class ImageContainer: ObservableObject {

    @Published var image = UIImage(named: "noimage")!

    init(for resource: URL?) {
        guard let resource = resource else { return }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: resource, completionHandler: { [weak self] data, _, _ in
            guard let imageData = data,
                let networkImage = UIImage(data: imageData) else {
                return
            }

            DispatchQueue.main.async {
                self?.image = networkImage
            }
            session.invalidateAndCancel()
        })
        task.resume()
    }
}
