//
//  UICollectionView+Extensions.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 02/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionView {
    func reloadDataSmoothly() {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { () -> Void in
            UIView.setAnimationsEnabled(true)
        }
        
        reloadData()
        
        CATransaction.commit()
    }
}
