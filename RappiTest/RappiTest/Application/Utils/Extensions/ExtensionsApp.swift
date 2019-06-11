//
//  ExtensionsApp.swift
//  GoSample
//
//  Created by Mauricio Jimenez on 22/04/19.
//  Copyright © 2019 com.AlphaSoluciones. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreImage
import AVFoundation

//MARK: - String
extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func removeCurrencyValue() -> String {
        let aux = self.removeOcurrence(ocurrence: " MXN")
        return aux
    }
    
    func getDoubleValue() -> Double {
        let aux = self.removeOcurrence(ocurrence: " MXN")
        
        guard let valueDouble = Double(aux) else {
            return 0.0
        }
        
        return valueDouble
    }
    
    func isRegularExpresion(regex: String) -> Bool{
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    var noEspecialChars : Bool {
        let especialRegEx = "[+!@#$%^&*(),:{}|<>]"
        let especialTest = NSPredicate(format:"SELF MATCHES %@", especialRegEx)
        let result = especialTest.evaluate(with: self)
        print(result)
        return result
    }
    
    func currencyInputFormatting(currencySymbol : String) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currencySymbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    func currencyInputFormatting() -> String {
        
        var isNegative : Bool = false
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        if amountWithPrefix.range(of:"-") != nil {
            isNegative = true
        }
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return "0.00"
        }
        
        if isNegative {
            return "-\(formatter.string(from: number)!)"
        }else{
            return formatter.string(from: number)!
        }
        
        
    }
    
    func removeOcurrence(ocurrence: String) -> String {
        let str = self.replacingOccurrences(of: ocurrence, with: "")
        return str
    }
    
    func generateQRCode() -> UIImage? {
        let data = self.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    func generateBarcode() -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        print(AVMetadataObject.ObjectType.ean13.rawValue)
        print("\ncode128:\n\(AVMetadataObject.ObjectType.code128.rawValue)")
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    mutating func shorString(distance: Int) -> String {
        let otherRange = self.index(self.startIndex, offsetBy: distance)..<self.endIndex
        self.removeSubrange(otherRange)
        self = self + "..."
        
        return self
    }
    
    func getArrayStringByCharacter(character: String) -> [String] {
        // ", "
        let array = self.components(separatedBy: character)
        return array.count > 0 ? array : []
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    func getImageFormStr64() -> UIImage? {
        guard let dataDecoded : Data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage
    }
    
    func modifyCreditCardOrExpiryDateString(separateBy : String, length : Int) -> String{
        let trimmedString = self.components(separatedBy: separateBy).joined()
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if((i+1) % length == 0 && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(separateBy)
                    
                }else if (i+1) % length == 0 && i < length && separateBy == "/" {
                    guard let _mm = Int(modifiedCreditCardString) else {
                        return ""
                    }
                    if _mm > 12 {
                        return String(modifiedCreditCardString.prefix(1))
                    }
                }
            }
        }
        return modifiedCreditCardString
    }
    
    func getDataFromDateString(typeString: TypeDateString) -> String {
        
        var result = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = typeString == .hour ? "HH:mm" : "dd/MM/yy"
        
        if let date = dateFormatterGet.date(from: self) {
            result = dateFormatterPrint.string(from: date)
        }
        
        return result
    }
    
    func getDateForDetailConcept() -> String {
        var result = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = "d MMMM HH:mm"
        
        if let date = dateFormatterGet.date(from: self) {
            result = "\(dateFormatterPrint.string(from: date)) hrs"
        }
        return result
    }
    
    func isNumeric() -> Bool {
        let num = Int(self)
        if num != nil {
            return true
        }
        return false
    }
}

//MARK: - StylableImageView
//extension StylableImageView {
//    
//    func getImageWithUrl(url: String, roundedImage: Bool) {
//        self.styleName = !roundedImage ? "transparent" : "roundTransparent"
//        Alamofire.request(url).responseImage { response in
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                self.image = image
//            }
//        }
//    }
//}

//MARK: - UITextField
extension UITextView {
    func getText() -> String {
        return self.text != nil ? self.text! : ""
    }
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Aceptar", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
}

//MARK: - UITextField
extension UITextField {
    func getText() -> String {
        return self.text != nil ? self.text! : ""
    }
    
}

//MARK: - UIColor
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
            else if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16)
                    g = CGFloat((hexNumber & 0xff00) >> 8)
                    b = CGFloat((hexNumber & 0xff) )
                    
                    self.init(
                        red: CGFloat(r) / 0xff,
                        green: CGFloat(g) / 0xff,
                        blue: CGFloat(b) / 0xff,
                        alpha: 1
                    )
                    
                    return
                }
            }
            
        }
        
        return nil
    }
}

//MARK: - Array
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}

//MARK: - UIPageControl
extension UIPageControl {
    
    fileprivate func imageForSubview(_ view:UIView) -> UIImageView? {
        var dot:UIImageView?
        
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        
        return dot
    }
    
    func updateDots() {
        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
        var i = 0
        let activeImage = UIImage(named: "circleSliderActive")!
        let inactiveImage = UIImage(named: "circlePassiveSlider")!
        for view in self.subviews {
            if let imageView = self.imageForSubview(view) {
                if i == self.currentPage {
                    imageView.image = activeImage
                } else {
                    imageView.image = inactiveImage
                }
                i = i + 1
            } else {
                var dotImage = inactiveImage
                if i == self.currentPage {
                    dotImage = activeImage
                }
                view.clipsToBounds = false
                view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                view.addSubview(UIImageView(image:dotImage))
                i = i + 1
            }
        }
        
        self.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
    }
    
}

//MARK: - NSObject
extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}


//MARK: - DefaultButton
extension UIButton {
    func makeAnimation( color : UIColor){
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = color.cgColor
        colorAnimation.duration = 0.5
        self.layer.add(colorAnimation, forKey: "ColorPulse")
    }
}

//MARK: - UIApplication
extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}

//MARK: - NAVIGATION BAR
extension UINavigationItem {
    //Se agrega el logo de la app en el view title del navigation bar
    func addImageLogoOnTitle(imageName : String ){
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: imageName)
        imageView.image = image
        logoContainer.addSubview(imageView)
        self.titleView = logoContainer
    }
    
    func setStyle(item: UINavigationItem){
        if let leftItems = item.leftBarButtonItems, leftItems.count > 0 {
            self.leftBarButtonItems = leftItems
        }
        
        if let rightItems = item.rightBarButtonItems, rightItems.count > 0 {
            self.rightBarButtonItems = rightItems
        }
        
        if let titleV = item.titleView {
            self.titleView = titleV
        }
        
        if let titleStr = item.title {
            self.title = titleStr
        }
    }
    
}

//MARK: - UIImage
extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

//MARK: - DOUBLE
extension Double {
    func setCurrencyFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        //numberFormatter.numberStyle = .decimal
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: self as NSNumber)!
    }
}

//MARK: - VIEW
extension UIView {
    func setConstraintsWithConstant(topCt : CGFloat, leadingCt: CGFloat, trailingCt: CGFloat, bottomCt: CGFloat, adjacentView: UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: adjacentView.topAnchor, constant: topCt).isActive = true
        self.leadingAnchor.constraint(equalTo: adjacentView.leadingAnchor, constant: leadingCt).isActive = true
        self.trailingAnchor.constraint(equalTo: adjacentView.trailingAnchor, constant: trailingCt).isActive = true
        self.bottomAnchor.constraint(equalTo: adjacentView.bottomAnchor, constant: bottomCt).isActive = true
    }
    
    
    func setMarginsConstraintsWithConstant(
        topCt : CGFloat? = nil,
        leadingCt: CGFloat? = nil,
        trailingCt: CGFloat? = nil,
        bottomCt: CGFloat? = nil,
        topMarginCt: CGFloat? = nil,
        leadingMarginCt: CGFloat? = nil,
        trailingMarginCt: CGFloat? = nil,
        bottomMarginCt: CGFloat? = nil,
        adjacentView: UIView){
        
        
        let margins = adjacentView.layoutMarginsGuide
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let _topMarginCt = topMarginCt {
            self.topAnchor.constraint(equalTo: margins.topAnchor, constant: _topMarginCt).isActive = true
        }
        
        if let _topCt = topCt {
            self.topAnchor.constraint(equalTo: adjacentView.topAnchor, constant: _topCt).isActive = true
        }
        
        if let _bottomMarginCt = bottomMarginCt {
            self.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: _bottomMarginCt).isActive = true
        }
        
        if let _bottomCt = bottomCt {
            self.bottomAnchor.constraint(equalTo: adjacentView.bottomAnchor, constant: _bottomCt).isActive = true
        }
        
        if let _leadingMarginCt = leadingMarginCt {
            self.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: _leadingMarginCt).isActive = true
        }
        
        if let _leadingCt = leadingCt {
            self.leadingAnchor.constraint(equalTo: adjacentView.leadingAnchor, constant: _leadingCt).isActive = true
        }
        
        if let _trailingMarginCt = trailingMarginCt {
            self.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: _trailingMarginCt).isActive = true
        }
        
        if let _trailingCt = leadingCt {
            self.trailingAnchor.constraint(equalTo: adjacentView.trailingAnchor, constant: _trailingCt).isActive = true
        }
        
    }
    
    func removeSubViews(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

// MARK: UINavigationController
extension UINavigationController {
    /**
     It removes all view controllers from navigation controller then set the new root view controller and it pops.
     
     - parameter vc: root view controller to set a new
     */
    func initRootViewController(vc: UIViewController, transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.viewControllers.removeAll()
        self.pushViewController(vc, animated: false)
        self.popToRootViewController(animated: false)
    }
    
    /**
     It adds the animation of navigation flow.
     
     - parameter type: kCATransitionType, it means style of animation
     - parameter duration: CFTimeInterval, duration of animation
     */
    private func addTransition(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
}

//MARK: - UILabel
extension UILabel {
    func addImageWith(name: String, behindText: Bool) {
        
        let iconsSize = CGRect(x: 20, y: -5, width: 20, height: 20)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        attachment.bounds = iconsSize
        let attachmentString = NSAttributedString(attachment: attachment)
        
        
        
        guard let txt = self.text else {
            return
        }
        
        if behindText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSAttributedString(string: txt)
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }
    
    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

//MARK: - StylableImageView
extension StylableImageView {
    
    
    func getImageWithUrl(url: String, roundedImage: Bool, cache: Bool? = nil) {
        self.styleName = !roundedImage ? "transparent" : "roundTransparent"
        
        if let c = cache, c == true {
            self.af_setImage(withURL: URL(string: url)!, placeholderImage: nil, filter: nil, progress: nil, runImageTransitionIfCached: true) { (response) in
                if let image = response.result.value {
                    //print("image downloaded: \(image)")
                    self.image = image
                }
            }
        }
        else {
            Alamofire.request(url).responseImage { response in
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    self.image = image
                }
            }
        }
        
        
        
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

