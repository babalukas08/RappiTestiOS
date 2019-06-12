//
//  BaseViewController.swift
//  ProductScanner
//
//  Created by Mauricio Jimenez on 22/04/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import UIKit
import SwiftMessages
import NVActivityIndicatorView
import RxSwift
import Hero

class BaseViewController: UIViewController, AlertController {
    
    var titleNav = ""
    var typeHeader : StyleHeaderNavigationBar = .Home {
        didSet {
            self.setNavBarStyle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPallete.bgBaseView.asColor()
        //UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
        
        if let navController = navigationController {
            //self.view.backgroundColor = UIColor.white
            navController.hero.isEnabled = true
            NavBarUtils.clearNavigationBar(forBar: navController.navigationBar)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Navigation Methods
    func setNavBarStyle() {
        guard let item = NavBarUtils.setStyleNavigationByType(controller: self, self.typeHeader, self.titleNav) else {
            return
        }
        
        if let d = item.title, !d.isEmpty {
            self.navigationItem.title = d
        }
        
        self.navigationItem.titleView               = self.getLogo()
        self.navigationItem.leftBarButtonItems      = item.leftBarButtonItems
        self.navigationItem.rightBarButtonItems     = item.rightBarButtonItems
    }
    
    @objc func onTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getLogo() -> UIView? {
        switch self.typeHeader {
        case .Home, .HomeIphone, .ChildView, .ChildViewCloseIcon:
            let logo = UIImageView(image: (UIImage(named: "logoMDB")))
            logo.contentMode = .scaleAspectFit
            //logo.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
            return logo
        default:
            return nil
        }
    }
    
    // MARK: methods for navigation buttons, implement in controller you used with override functions
    @objc func onTapMenu() {print("OnTapMenu")}
    @objc func onTapClose() { print("onTapClose")}
    @objc func onTapFilter() { print("onTapFilter")}
    @objc func onTapCamara() { print("onTapCamara")}
    @objc func onTapHistory() { print("onTapHistory")}
    @objc func onTapNewBag() { print("onTapNewBag")}
    
    
    // MARK: show dialogs
    func showMessageDialog(_ title: String, message: String, textButtonOne: String, textButtonTwo: String, okHandler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: textButtonOne, style: UIAlertAction.Style.default, handler: okHandler))
        if cancelHandler != nil {
            alertViewController.addAction(UIAlertAction(title: textButtonTwo, style: UIAlertAction.Style.default, handler: cancelHandler))
        }
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    //MARK: -  Toast MESSAGE
    func showToastMessage(message : String, type : Theme, slideFrom : SwiftMessages.PresentationStyle ) {
        SwiftMessages.show {
            let mssgView = MessageView.viewFromNib(layout: .cardView)
            // ... configure the view
            mssgView.configureTheme(type)
            mssgView.configureDropShadow()
            mssgView.configureContent(title: "", body: message)
            mssgView.button?.isHidden = true
            var config = SwiftMessages.Config()
            config.interactiveHide = true
            config.duration = .seconds(seconds: 3.5)
            config.presentationStyle = slideFrom
            
            return mssgView
        }
    }
    
    //MARK: - Loader
    func showLoader(_ message: String? = nil, closure: @escaping (Bool) -> Void) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        let msgLoader = message ?? ""
        let activityData = ActivityData(message: msgLoader, type: .ballGridPulse)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
            closure(true)
        }
    }
    
    func showLoader(_ message: String? = nil) {
        let msgLoader = message ?? ""
        let activityData = ActivityData(message: msgLoader, type: .ballGridPulse)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    func hiddenLoader(_ message: String?, closure: @escaping (Bool) -> Void) {
        
        if let textMessage = message {
            self.changeTextLoader(textMessage)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            closure(true)
        }
    }
    
    func changeTextLoader(_ message: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
        }
    }
    
    // MARK: Send to Browser
    func sendToBrowser(urlPath: String) {
        if let url = URL(string: urlPath), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        else {
            self.showToastMessage(message: "Error al dirigir a la tienda online, inténtelo más tarde", type: .error, slideFrom: .top)
        }
    }
    
    // MARK: Contrainst
    func setContraintsView(subview: UIView, containerView: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        subview.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8, constant: 1).isActive = true
        subview.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setContraintsCenterView(subview: UIView, containerView: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        
        //subview.heightAnchor.constraint(equalTo: subview.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    func setConstraintIphone(subview: UIView, containerView: UIView) {
        // 40 16 16 20
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        subview.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.5, constant: 1).isActive = true
        subview.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    //Modal DatePicker
    func presentModalDatePicker(sourceView: UIView, closure: @escaping (Bool, Date) -> Void){
        self.view.endEditing(true)
        let stringTitle = ""
        let alertPickerDate = UIAlertController(title: stringTitle, message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        let datePicker : UIDatePicker = UIDatePicker(frame: .zero)
        
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .clear
        let now : Date = Date()
        datePicker.setDate(now, animated: false)
        
        
        alertPickerDate.view.tintColor = ColorPallete.yellowPH.asColor()
        alertPickerDate.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = true
        datePicker.trailingAnchor.constraint(equalToSystemSpacingAfter: alertPickerDate.view.trailingAnchor, multiplier: -0.8)
        datePicker.leftAnchor.constraint(equalToSystemSpacingAfter: alertPickerDate.view.leftAnchor, multiplier: 0.8)
        
        let aceptAction = UIAlertAction(title: "Aceptar", style: .default, handler: {
            (alert: UIAlertAction!) in print("Done")
            print("Fecha Seleccionada: \(datePicker.date)")
            closure(true, datePicker.date)
        })
        
        alertPickerDate.addAction(aceptAction)
        
        DispatchQueue.main.async {
            if let topVC = UIApplication.getTopMostViewController() {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    alertPickerDate.view.frame = .zero
                    alertPickerDate.popoverPresentationController?.sourceView = sourceView
                    alertPickerDate.popoverPresentationController?.sourceRect = CGRect(x: 0, y: sourceView.bounds.height - 250, width: sourceView.bounds.width, height: 250)
                    topVC.present(alertPickerDate, animated: true, completion: {})
                    alertPickerDate.view.translatesAutoresizingMaskIntoConstraints = true
                    alertPickerDate.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
                }
                else {
                    topVC.present(alertPickerDate, animated: true, completion: { })
                }
            }
        }
    }
    
}
