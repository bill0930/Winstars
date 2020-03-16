//
//  UIView+Additions.swift
//  Winstars
//
//  Created by CHAN CHI YU on 17/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
  
  func smoothRoundCorners(to radius: CGFloat) {
    let maskLayer = CAShapeLayer()
    maskLayer.path = UIBezierPath(
      roundedRect: bounds,
      cornerRadius: radius
    ).cgPath
    
    layer.mask = maskLayer
  }
  
}
