//
//  GridBaseCell.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit

class GridBaseCell: UICollectionViewCell {

    @IBOutlet weak var imageProduct: StylableImageView!
    @IBOutlet weak var titleIn: Heading!
    @IBOutlet weak var dateIn: Heading!
    @IBOutlet weak var titleOut: Heading!
    
    
    lazy var tvModel: TvModel = {
        return TvModel()
    }()
    
    lazy var movieModel: MovieModel = {
        return MovieModel()
    }()
    
    lazy var mainModel: DataListModel = {
        return DataListModel()
    }()

    
    var index = 0
    
    @IBInspectable public var title: String = "" {
        didSet {
            self.titleIn.isHidden = title.isEmpty
            self.titleIn.text = title.count > 26 ? title.shorString(distance: 26) : title
        }
    }
    
    @IBInspectable public var date: String = "" {
        didSet {
            self.dateIn.text = date
            self.dateIn.isHidden = date.isEmpty
        }
    }
    
    @IBInspectable public var titleO: String = "" {
        didSet {
            self.titleOut.text = titleO.count > 26 ? titleO.shorString(distance: 26) : self.titleO
            self.titleOut.isHidden = titleO.isEmpty
        }
    }
    
    @IBInspectable public var imageStr: String = "" {
        didSet {
            
            if imageStr.isEmpty {
                return
            }
            // get image to URL with cache
            self.imageProduct.getImageWithUrl(url: imageStr, roundedImage: false, cache: true)
            self.imageProduct.adjustImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell<T>(model: T, typeListView : TypeListView) {
        if let movie = model as? MovieModel {
            self.movieModel = movie
            self.imageStr = Constants.UrlServices.BasePathImage + self.movieModel.poster_path
            self.title = typeListView == .mainView ? "" : self.movieModel.title
            self.date = typeListView == .mainView ? "" : self.movieModel.release_date
            self.titleO = typeListView == .mainView ? self.movieModel.title : ""
        }
        else if let tv = model as? TvModel {
            self.tvModel = tv
            self.imageStr = Constants.UrlServices.BasePathImage + self.tvModel.poster_path
            self.title = typeListView == .mainView ? "" : self.tvModel.name
            self.date = typeListView == .mainView ? "" : self.tvModel.first_air_date
            self.titleO = typeListView == .mainView ? self.tvModel.name : ""
        }
        else if let main = model as? DataListModel {
            self.mainModel = main
            self.imageStr = Constants.UrlServices.BasePathImage + self.mainModel.image
            self.title = typeListView == .mainView ? "" : self.mainModel.name
            self.date = typeListView == .mainView ? "" : ""
            self.titleO = typeListView == .mainView ? self.mainModel.name : ""
        }
    }
}
