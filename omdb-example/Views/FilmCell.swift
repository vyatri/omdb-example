//
//  FilmCell.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 01/12/18.
//  Copyright © 2018 Vyatri. All rights reserved.
//

import UIKit

class FilmCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func prepareForReuse() {
        imageView.image = UIImage()
        titleLabel.text = ""
        yearLabel.text = ""
        categoryLabel.text = ""
    }
}
