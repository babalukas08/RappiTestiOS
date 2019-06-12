//
//  FilterView.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 07/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

public protocol FilterViewDelegate: class {
    func onTapSend(mod: FilterView, code: String)
    func onTapCancel()
    func onTapIndex(model: [Int])
}

@IBDesignable
public class FilterView: BaseViewNibDesignable {
    
    weak public var delegate: FilterViewDelegate?
    
    @IBOutlet weak public var titleLabel: Heading!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    lazy var data : [BaseGenerModel] = {
       return []
    }()
    
    lazy var disposeBag : DisposeBag = {
        return DisposeBag()
    }()
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public override func setupView() {
        self.hero.isEnabled = true
        self.hero.id = "FilterV"
        self.hero.modifiers = [.cascade]
        self.collectionView.hero.modifiers = [.cascade]
        self.disposeBag = DisposeBag()
        self.configSizeCollection()
        self.collectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "noneCell")
                
        self.collectionView.register(UINib(nibName: "HeaderListView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerListView")
    }
    
    private func configSizeCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 54)/6, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        layout.headerReferenceSize = CGSize(width: self.collectionView.bounds.width, height: 40)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        self.collectionView.collectionViewLayout = layout
        self.collectionView.reloadData()
    }
    
    override func configure<T>(model: T) {
        self.setupView()
        if let source = model as? [BaseGenerModel] {
            self.data = source
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 0)
    }
    
    func saveData() {
        for value in self.data {
            let result = DataSourceManager.saveCacheModel(value.typeItem.realmKey, value: value.toJSONString() ?? "")
            switch result {
            case .success:
                continue
            case .failure(let message):
                print("failure, \(message)")
            }
        }
    }
}

extension FilterView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].genres.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath as IndexPath) as? FilterCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "noneCell", for: indexPath)
        }
        
        cell.configureCell(data: self.data[indexPath.section].genres[indexPath.row])
        cell.hero.modifiers = [.fade, .scale(0.5)]
        return cell
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView : HeaderListView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerListView", for: indexPath) as? HeaderListView else {
                return UICollectionReusableView()
            }
            
            let model = self.data[indexPath.section]
            headerView.setTitle(data: model, section: indexPath.section)

            
            headerView.backgroundColor = UIColor.clear
            
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    
}

extension FilterView : UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.data[indexPath.section].genres[indexPath.row]
        model.isSelect = !model.isSelect
        self.data[indexPath.section].genres[indexPath.row] = model
        self.saveData()
        self.collectionView.reloadData()
        
        let ids = self.data.map{$0.genres.filter{$0.isSelect}.compactMap({$0.id})}.flatMap({$0.map{$0}})
        
        print(ids)
        
        self.delegate?.onTapIndex(model: ids)

    }
    
}

extension FilterView : AlertHostControllerDelegate {
    public func onTapCancelHost() {
        self.delegate?.onTapCancel()
    }
}

