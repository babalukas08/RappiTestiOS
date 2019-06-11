//
//  SummaryCell.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit

class SummaryCell: UICollectionViewCell {
    
    @IBOutlet weak public var titleLabel: Heading!
    @IBOutlet weak public var releaseLabel: Heading!
    
    @IBInspectable public var title: String = "" {
        didSet {
            self.titleLabel.isHidden = title.isEmpty
            self.titleLabel.text = title
        }
    }
    
    @IBInspectable public var releaseL: String = "" {
        didSet {
            self.releaseLabel.isHidden = releaseL.isEmpty
            self.releaseLabel.text = releaseL
        }
    }
    
    lazy var itemModel: DataListModel = {
        return DataListModel()
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure<T>(model: T) {
        if let video = model as? DataListModel {
            self.itemModel = video
            self.releaseL = self.itemModel.date
            self.title = self.itemModel.overview
        }
    }

}
