//
//  ListView.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift

public enum TypeListView : String {
    case mainView
    case gridCategorie
    case listCategorie
    
    public func getlayoutData() -> CarouselData {
        
        var data = CarouselData()
        
        switch self {
        case .mainView:
            data.size = CGSize(width: (UIScreen.main.bounds.size.width - 32)/3.5, height: (UIScreen.main.bounds.size.width/3.5) + 90)
            data.insets = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        case .gridCategorie:
            data.size = CGSize(width: (UIScreen.main.bounds.size.width - 32)/4, height: ((UIScreen.main.bounds.size.width - 32)/4) + 50)
            data.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .listCategorie:
            data.size = CGSize(width: (UIScreen.main.bounds.size.width - 32), height: 200)
            data.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        return data
    }
}

public protocol ListViewViewDelegate: class {
    func onTapCell(index: IndexPath)
}

@IBDesignable
public class ListView: BaseViewNibDesignable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak public var delegate: ListViewViewDelegate?
    
    lazy var disposeBag : DisposeBag = {
        return DisposeBag()
    }()
    
    lazy var tvData : [TvModel] = {
        return []
    }()
    
    lazy var movieData : [MovieModel] = {
        return []
    }()
    
    lazy var mainData : [MainListModel] = {
        return[]
    }()
    
    var typeListView : TypeListView = .mainView
    
    @IBInspectable public var typeList: String = "mainView" {
        didSet {
            let type = TypeListView.init(rawValue: typeList) ?? .mainView
            self.typeListView = type
            self.configSizeCollection(type: type)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        //setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupView()
    }
    
    private func configSizeCollection(type: TypeListView) {
        let layout = UICollectionViewFlowLayout()
        
        let dataLayout = type.getlayoutData()
        
        layout.itemSize = dataLayout.size
        layout.sectionInset = dataLayout.insets
        layout.headerReferenceSize = CGSize(width: self.collectionView.bounds.width, height: 40)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
        self.collectionView.reloadData()
    }
    
    override func setupView() {
        print("Setup")
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.register(UINib(nibName: "GridBaseCell", bundle: nil), forCellWithReuseIdentifier: "gridBaseCell")
        
        self.collectionView.register(UINib(nibName: "HeaderListView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerListView")

        //self.collectionView.isPagingEnabled = true
    }
    
    override func configure<T>(model: T) {
        self.setupView()
        if let movie = model as? [MovieModel] {
            self.movieData = movie
        }
        else if let tv = model as? [TvModel] {
            self.tvData = tv
        }
        else if let main = model as? [MainListModel] {
            self.mainData = main
        }
        
        self.collectionView.reloadData()
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 0)
    }
}

extension ListView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch self.typeListView {
        case .mainView:
            return self.mainData.count
        default:
            return 1
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.typeListView {
        case .mainView:
            return self.mainData[section].data.count
        case .gridCategorie:
            return self.movieData.count > 0 ? self.movieData.count : self.tvData.count
        case .listCategorie:
            return self.movieData.count > 0 ? self.movieData.count : self.tvData.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.typeListView {
        case .mainView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridBaseCell", for: indexPath as IndexPath) as? GridBaseCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "noneCell", for: indexPath)
            }
            
            cell.configCell(model: self.mainData[indexPath.section].data[indexPath.row], typeListView: self.typeListView)
            
            return cell
        case .gridCategorie:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridBaseCell", for: indexPath as IndexPath) as? GridBaseCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "noneCell", for: indexPath)
            }
            
            if self.movieData.count > 0 {
                cell.configCell(model: self.movieData[indexPath.row], typeListView: self.typeListView)
            }
            else {
                cell.configCell(model: self.tvData[indexPath.row], typeListView: self.typeListView)
            }
            
            
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "noneCell", for: indexPath)
        }
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView : HeaderListView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerListView", for: indexPath) as? HeaderListView else {
                return UICollectionReusableView()
            }
            
            if typeListView == .mainView {
                headerView.delegate = self
                let model = self.mainData[indexPath.section]
                headerView.setTitle(data: model, section: indexPath.section)
            }
            
            headerView.backgroundColor = UIColor.clear

            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    
}

extension ListView : UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.typeListView {
        case .mainView:
            print(self.mainData[indexPath.section].data[indexPath.row].genre_ids)
        default:
            print(indexPath)
        }
        
        self.delegate?.onTapCell(index: indexPath)
    }
    
}

extension ListView : HeaderListViewDelegate {
    public func onTapHeader(section: Int) {
        print(section)
    }
    
    
}
