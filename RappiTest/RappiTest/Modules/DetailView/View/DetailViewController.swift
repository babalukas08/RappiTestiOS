//
//  DetailViewController.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var modelItem : DataListModel = {
        return DataListModel()
    }()
    
    var keyVideo = ""
    
    weak var presenter: DetailViewPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.typeHeader = .ChildView
    }
    
    private func configView() {
        //SummaryCell
        self.collectionView.register(UINib(nibName: "VideoViewCell", bundle: nil), forCellWithReuseIdentifier: "videoViewCell")
        self.collectionView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellWithReuseIdentifier: "summaryCell")
        self.configSizeCollection()
    }
    
    private func configSizeCollection() {
        self.collectionView.reloadData()
    }

}

extension DetailViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoViewCell", for: indexPath as IndexPath) as? VideoViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "noneCell", for: indexPath)
            }
            
            cell.configure(model: self.modelItem, keyVideo: self.keyVideo)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCell", for: indexPath as IndexPath) as? SummaryCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "noneCell", for: indexPath)
            }
            
            cell.configure(model: self.modelItem)
            return cell
        }
        
        
    }
 
}

extension DetailViewController : UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

extension DetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 0.8)
        }
        else {
            let height = self.modelItem.overview.height(withConstrainedWidth: UIScreen.main.bounds.size.width, font: FontPallete.HelveticaB.asFont(ofSize: CGFloat(15)))
            return CGSize(width: UIScreen.main.bounds.size.width, height: height + 140)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension DetailViewController : DetailViewInterface {
    func servicesResult(_ result: ServicesManagerResult, typeServices: ServicesType) {
        print(typeServices)
    }
    
    
}


