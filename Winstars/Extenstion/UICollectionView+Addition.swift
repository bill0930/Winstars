//
//  UICollectionView+Addition.swift
//  Winstars
//
//  Created by CHAN CHI YU on 17/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation
import UIKit
extension UIScrollView {
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
    
}
