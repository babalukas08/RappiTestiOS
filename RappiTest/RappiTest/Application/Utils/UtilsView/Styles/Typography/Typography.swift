//
//  Typography.swift
//  Intercol
//
//  Created by Mauricio Jimenez on 20/11/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//


import UIKit

public enum TypographyStyle: String {
    //
    case txtHeaderGeneral
    case txtHeaderGeneralHeader
    case txtHeaderGeneralFilter
    case txtHeaderGeneralBlue
    case txtHeaderGeneralWhiteOpacy
    case txtHeaderGeneralBlack
    case txtHelveticaLight
    case txtHelveticaLightBlack

    // Styles Message
    case messageAlert19HitGray
    case txtDateAlertIndicator
    case txtHelvetica15Black
    // Styles Loft Digital
    case txtBigTitleGray26
    case txtBigTitleWhite26
    case gotham19GrayBig
    case gothamMedium14Black
    case gothamMedium12Black
    case gothamMedium14GrayTitle
    case gothamMedium24White
    case gothamMedium26Gray
    case gothamMedium30Black
    case gothamMedium16Black
    case gothamMedium17GrayTitle
    case gothamMedium15GrayTitle
    case gothamMedium22GrayTitle
    case GothamBook18GrayTitle
    case GothamBook19GrayTitle
    case GothamBook19WhiteTitle
    case GothamBook14GrayTitle
    case GothamBook13GrayTitle
    case GothamBook16grayBigTitle
    case GothamBook25grayPrice
    case GothamBook10grayBigTitle
    case GothamBook26GrayTitle
    
    public func getStyle() -> TextStyle {
        switch self {
        // Loft Digital
        case .txtBigTitleGray26:
            let color = ColorPallete.grayBigTitle.asColor()
            let size = SizesPallete.TextSize.txtBase26.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .txtBigTitleWhite26:
            let color = ColorPallete.white.asColor()
            let size = SizesPallete.TextSize.txtBase26.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .gotham19GrayBig:
            let color = ColorPallete.grayBigTitle.asColor()
            let size = SizesPallete.TextSize.txtBase19.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .gothamMedium14Black:
            let color = ColorPallete.blackButtons.asColor()
            let size = SizesPallete.TextSize.textM.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .gothamMedium12Black:
            let color = ColorPallete.blackButtons.asColor()
            let size = SizesPallete.TextSize.textS.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .gothamMedium14GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.textM.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .gothamMedium24White:
            let color = ColorPallete.white.asColor()
            let size = SizesPallete.TextSize.txtBase24.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .gothamMedium26Gray:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.txtBase26.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .gothamMedium30Black:
            let color = ColorPallete.blackTitle.asColor()
            let size = SizesPallete.TextSize.txtBold30.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        
        case .gothamMedium16Black:
            let color = ColorPallete.blackTitle.asColor()
            let size = SizesPallete.TextSize.textL.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .gothamMedium15GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.txtBase15.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .gothamMedium22GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.textXXL.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .gothamMedium17GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.text17.rawValue
            let font = FontPallete.GothamCondensedMedium.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .GothamBook18GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.textXL.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .GothamBook19GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.txtBase19.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .GothamBook19WhiteTitle:
            let color = ColorPallete.white.asColor()
            let size = SizesPallete.TextSize.txtBase19.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        
        case .GothamBook14GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.textM.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .GothamBook13GrayTitle:
            let color = ColorPallete.grayBigTitle.asColor()
            let size = SizesPallete.TextSize.textSS.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .GothamBook16grayBigTitle:
            let color = ColorPallete.grayBigTitle.asColor()
            let size = SizesPallete.TextSize.textL.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .GothamBook10grayBigTitle:
            let color = ColorPallete.grayBigTitle.asColor()
            let size = SizesPallete.TextSize.textBase10.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .GothamBook25grayPrice:
            let color = ColorPallete.grayPrice.asColor()
            let size = SizesPallete.TextSize.textBase25.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .GothamBook26GrayTitle:
            let color = ColorPallete.grayTitle.asColor()
            let size = SizesPallete.TextSize.txtBase26.rawValue
            let font = FontPallete.GothamCondensedBook.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        // General Typography
            
        case .txtHelvetica15Black:
            let color = ColorPallete.black.asColor()
            let size = SizesPallete.TextSize.txtBase15.rawValue
            let font = FontPallete.Helvetica.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .txtDateAlertIndicator:
            let color = ColorPallete.hitGray.asColor()
            let size = SizesPallete.TextSize.textS.rawValue
            let font = FontPallete.HelveyticaL.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        // error message
        case .messageAlert19HitGray:
            let color = ColorPallete.hitGray.asColor()
            let size = SizesPallete.TextSize.txtBase19.rawValue
            let font = FontPallete.sanFrancisco.asFont(ofSize: CGFloat(size), withWeight: .base)
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        
            
        case .txtHeaderGeneral:
            let color = ColorPallete.white.asColor()
            let size = SizesPallete.TextSize.txtBase15.rawValue
            let font = FontPallete.HelveticaB.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .txtHeaderGeneralHeader:
            let color = ColorPallete.bgBaseView.asColor()
            let size = SizesPallete.TextSize.txtBase15.rawValue
            let font = FontPallete.HelveticaB.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        
        case .txtHeaderGeneralBlue:
            let color = ColorPallete.bgBaseView.asColor()
            let size = SizesPallete.TextSize.txtBase7.rawValue
            let font = FontPallete.HelveticaB.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .txtHeaderGeneralFilter:
            let color = ColorPallete.white.asColor()
            let size = SizesPallete.TextSize.txtBase7.rawValue
            let font = FontPallete.HelveticaB.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .txtHeaderGeneralWhiteOpacy:
            let color = ColorPallete.white.asColor(withAlpha: 0.7)
            let size = SizesPallete.TextSize.textSS.rawValue
            let font = FontPallete.HelveticaB.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
            
        case .txtHeaderGeneralBlack:
            let color = ColorPallete.black.asColor()
            let size = SizesPallete.TextSize.text17.rawValue
            let font = FontPallete.HelveticaB.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        
            
        case .txtHelveticaLight:
            let color = ColorPallete.white.asColor()
            let size = SizesPallete.TextSize.textXL.rawValue
            let font = FontPallete.HelveyticaL.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .txtHelveticaLightBlack:
            let color = ColorPallete.black.asColor()
            let size = SizesPallete.TextSize.text17.rawValue
            let font = FontPallete.HelveyticaL.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle

        
        
        }
    }
}

