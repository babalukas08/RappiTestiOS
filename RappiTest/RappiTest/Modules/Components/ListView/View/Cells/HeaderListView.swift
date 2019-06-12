//
//  HeaderListView.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

public protocol HeaderListViewDelegate: class {
    func onTapHeader(section: Int)
}

class HeaderListView: UICollectionReusableView {

    @IBOutlet weak var titleSection: Heading!
    @IBOutlet weak var btnSeeAll: Heading!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    
    weak public var delegate: HeaderListViewDelegate?
    
    var section = 0
    lazy var disposeBag : DisposeBag = {
        return DisposeBag()
    }()
    
    @IBInspectable public var title: String = "" {
        didSet {
            self.titleSection.isHidden = title.isEmpty
            self.titleSection.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.disposeBag = DisposeBag()
    }
    
    func setTitle(data: MainListModel, section: Int) {
        self.setBinding()
        self.title = data.data.count > 0 ? data.titleSection : data.titleSection + " (0)"
        self.btnSeeAll.text = data.data.count > 0 ? "" : ""
        self.section = section
    }
    
    func setTitle(data: BaseGenerModel, section: Int) {
        self.title = data.typeItem.titleSection
        self.section = section
        //self.titleSection.styleName = TypographyStyle.txtHeaderGeneralHeader.rawValue
        self.btnSeeAll.isHidden = true
//        self.bottomView.backgroundColor = ColorPallete.white.asColor()
//        self.topView.backgroundColor = ColorPallete.bgBaseView.asColor()
    }
    
    func setBinding() {
        self.btnSeeAll.rx.tapGesture().when(.recognized).subscribe({ _ in
            self.delegate?.onTapHeader(section: self.section)
        }).disposed(by: self.disposeBag)
    }
    
}
