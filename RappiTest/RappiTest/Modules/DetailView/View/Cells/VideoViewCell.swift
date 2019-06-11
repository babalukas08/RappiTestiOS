//
//  VideoViewCell.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 11/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift
import youtube_ios_player_helper

class VideoViewCell: UICollectionViewCell {
    
    @IBOutlet weak public var videoview: YTPlayerView!
    
    @IBOutlet weak public var titleLabel: Heading!
    @IBOutlet weak public var rating: Heading!
    @IBOutlet weak public var reviwersCount: Heading!
    
    
    @IBInspectable public var title: String = "" {
        didSet {
            self.titleLabel.isHidden = title.isEmpty
            self.titleLabel.text = title
        }
    }
    
    @IBInspectable public var ratingL: String = "" {
        didSet {
            self.rating.isHidden = ratingL.isEmpty
            self.rating.text = ratingL
        }
    }
    
    @IBInspectable public var review: String = "" {
        didSet {
            self.reviwersCount.isHidden = review.isEmpty
            self.reviwersCount.text = review
        }
    }
    
    lazy var itemModel: DataListModel = {
        return DataListModel()
    }()
    
    lazy var disposeBag : DisposeBag = {
        return DisposeBag()
    }()
    
    var keyVideo : String = "" {
        didSet {
            if !keyVideo.isEmpty {
                //self.videoview.load(withVideoId: keyVideo)
                let playerVars: [String:Any] = [
                    "autoplay": 0,
                    "playsinline" : 1,
                    "enablejsapi": 1,
                    "wmode": "transparent",
                    "controls": 0,
                    "showinfo": 0,
                    "rel": 0,
                    "fs" : 1,
                    "modestbranding": 0,
                    "iv_load_policy": 3 //annotations
                ]
                self.videoview.delegate = self
                self.videoview.load(withVideoId: keyVideo, playerVars: playerVars)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure<T>(model: T, keyVideo: String) {
        self.keyVideo = keyVideo

        if let video = model as? DataListModel {
            self.itemModel = video
            self.title = self.itemModel.name
            self.ratingL = "\(self.itemModel.vote_average) / 10"
            self.review = "\(self.itemModel.vote_count) votos"
        }
    }

}

extension VideoViewCell : YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        print("time \(playTime)")
    }
}
