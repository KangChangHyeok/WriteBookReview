//
//  File.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/09.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    convenience init(rgb: CGFloat) {
        self.init(red: rgb/255, green: rgb/255, blue: rgb/255, alpha: 1)
    }
}
