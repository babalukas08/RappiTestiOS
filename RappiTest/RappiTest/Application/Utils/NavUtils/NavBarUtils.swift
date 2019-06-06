//
//   NavBarUtils.swift
//  ProductScanner
//
//  Created by Mauricio Jimenez on 09/05/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import Foundation
import UIKit

fileprivate extension Selector {
    static let menuSelector = #selector(BaseViewController.onTapMenu)
    static let backSelector = #selector(BaseViewController.onTapBack)
    static let closeSelector = #selector(BaseViewController.onTapClose)
    static let bagSelector = #selector(BaseViewController.onTapBag)
    static let camaraSelector = #selector(BaseViewController.onTapCamara)
    static let historySelector = #selector(BaseViewController.onTapHistory)
    static let newBagSelector = #selector(BaseViewController.onTapNewBag)
}

struct NavBarUtils {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.tintColor = ColorPallete.yellowPH.asColor()
        navBar.backgroundColor = ColorPallete.black.asColor()
        navBar.titleTextAttributes = [.foregroundColor: ColorPallete.yellowPH.asColor()]
    }
    
    static func whiteNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = false
        navBar.backgroundColor = ColorPallete.black.asColor()
        navBar.tintColor = ColorPallete.yellowPH.asColor()
        navBar.titleTextAttributes = [.foregroundColor: ColorPallete.yellowPH.asColor()]
    }
    
    static func setStyleNavigationByType(controller: UIViewController, _ type: StyleHeaderNavigationBar, _ title: String) -> UINavigationItem? {
        let modelNav = type.getDataforNavigation(title: title)
        let allButtons = UINavigationItem(title: modelNav.titleNavigation)
        let backBtn = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: controller, action: .backSelector)
        
        switch type {
        case .None:
            print("None Nav Bar")
            return nil
        case .Home:
            let homeImage = self.addImageLogoOnTitle(imageName: "logoAlphaChico")
            allButtons.titleView = homeImage
            return allButtons
        case .HomeIphone:
            let bagBtn = UIBarButtonItem(image: modelNav.iconOne, style: .plain, target: controller, action: .bagSelector)
            allButtons.leftBarButtonItems = [bagBtn]
            
            let camaraBtn = UIBarButtonItem(image: modelNav.iconTwo, style: .plain, target: controller, action: .camaraSelector)
            allButtons.rightBarButtonItems = [camaraBtn]
            let homeImage = self.addImageLogoOnTitle(imageName: "logoAlphaChico")
            allButtons.titleView = homeImage
            return allButtons
        case .ChildView:
            allButtons.leftBarButtonItem = backBtn
            return allButtons
        case .ChildViewCloseIcon:
            let newBag = UIBarButtonItem(title: "CREAR NUEVA BOLSA", style: .plain, target: controller, action: .newBagSelector)
            allButtons.rightBarButtonItems = [newBag]
            let homeImage = self.addImageLogoOnTitle(imageName: "logoAlphaChico")
            allButtons.titleView = homeImage
            return allButtons
        case .History:
            let history = UIBarButtonItem(image: modelNav.iconOne, style: .plain, target: controller, action: .historySelector)
            allButtons.leftBarButtonItems = [history]
            
            let newBag = UIBarButtonItem(title: "CREAR NUEVA BOLSA", style: .plain, target: controller, action: .newBagSelector)
            allButtons.rightBarButtonItems = [newBag]
            
            let homeImage = self.addImageLogoOnTitle(imageName: "logoAlphaChico")
            allButtons.titleView = homeImage
            return allButtons
        }
        
    }
    
    static func addImageLogoOnTitle(imageName : String ) -> UIView {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 117, height: 30))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 117, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let image = UIImage(named: imageName)
        imageView.image = image
        logoContainer.addSubview(imageView)
        return logoContainer
    }
    
}

/// Enum Type of Header Navigation Bar Styles
enum StyleHeaderNavigationBar: String {
    /// None - Default Navigation Bar
    case None
    /// Home - Add button to home view
    case Home
    case HomeIphone
    /// ChildView - Add button to back to previus view
    case ChildView
    /// ChildViewCloseIcon - Add button to back to previus view, add a close button
    case ChildViewCloseIcon
    case History
    
    public func getDataforNavigation(title: String?) -> DataNavigationBar {
        switch self {
        case .None:
            return DataNavigationBar()
        case .Home:
            return DataNavigationBar(showBackBtn: false, showLogoTitle: true, titleNavigation: "", numberIconsRight: 0, iconOne: nil, iconTwo: nil, viewTitle: nil)
        case .HomeIphone:
            return DataNavigationBar(showBackBtn: false, showLogoTitle: true, titleNavigation: "", numberIconsRight: 1, iconOne: UIImage(named: "list"), iconTwo: UIImage(named: "iconCamara"), viewTitle: nil)
        case .ChildView:
            return DataNavigationBar(showBackBtn: true, showLogoTitle: false, titleNavigation: title ?? "", numberIconsRight: 1, iconOne: UIImage(named: "back"), iconTwo: nil, viewTitle: nil)
        case .ChildViewCloseIcon:
            return DataNavigationBar(showBackBtn: true, showLogoTitle: false, titleNavigation: title ?? "", numberIconsRight: 1, iconOne: UIImage(named: "close"), iconTwo: nil, viewTitle: nil)
        case .History:
            return DataNavigationBar(showBackBtn: false, showLogoTitle: false, titleNavigation: title ?? "", numberIconsRight: 1, iconOne: UIImage(named: "history"), iconTwo: nil, viewTitle: nil)
        }
    }
}

public struct DataNavigationBar  {
    public var showBackBtn: Bool = false
    public var showLogoTitle: Bool = false
    public var titleNavigation: String = ""
    public var numberIconsRight: Int = 0
    public var iconOne: UIImage?
    public var iconTwo: UIImage?
    public var viewTitle: UIView?
    
    public init() { }
    public init(showBackBtn: Bool, showLogoTitle: Bool, titleNavigation: String, numberIconsRight: Int, iconOne: UIImage?, iconTwo: UIImage?, viewTitle: UIView?) {
        self.showBackBtn        = showBackBtn
        self.showLogoTitle      = showLogoTitle
        self.titleNavigation    = titleNavigation
        self.numberIconsRight   = numberIconsRight
        self.iconOne            = iconOne
        self.iconTwo            = iconTwo
        self.viewTitle          = viewTitle
    }
}

