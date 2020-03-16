//
//  NavigationController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 16/3/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad() 

  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return topViewController?.preferredStatusBarStyle ?? .default
  }
  
}
