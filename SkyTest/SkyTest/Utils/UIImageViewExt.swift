//
//  UIImageViewExt.swift
//  SkyTest
//
//  Created by Milena Pereira de Araujo on 14/04/21.
//  Copyright © 2021 Milena. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
