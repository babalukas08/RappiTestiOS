//
//  FilterCell.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 07/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var rootView: StylableView!
    @IBOutlet weak var titleLabel: Heading!
    
    @IBInspectable public var title: String = "" {
        didSet {
            self.titleLabel.isHidden = title.isEmpty
            self.titleLabel.text = title
        }
    }
    
    @IBInspectable public var isSelect: Bool = false {
        didSet{
            self.titleLabel.styleName = isSelect ? TypographyStyle.txtHeaderGeneralFilter.rawValue : TypographyStyle.txtHeaderGeneralBlue.rawValue
            
            self.rootView.styleName = isSelect ? ViewStyleSheet.filterSelectView.rawValue : ViewStyleSheet.filterUnSelectView.rawValue
        }
    }
    
    lazy var model : GenerModel = {
       return GenerModel()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    func configureCell(data: GenerModel) {
        self.model = data
        self.title = self.model.name
        self.isSelect = self.model.isSelect
    }

}
