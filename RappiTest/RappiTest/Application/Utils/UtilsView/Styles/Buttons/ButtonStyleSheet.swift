//
//  ButtonStyleSheet.swift
//  Intercol
//
//  Created by Mauricio Jimenez on 20/11/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//


import UIKit

public enum ButtonStyleSheet: String {
    case redRoundButton
    case redRoundButtonOpacy
    case redRectButton
    case redRectButtonOpacy
    case roundButton
    // Loft Digital
    case rectYellow
    case rectTransparentBordersGray
    
    public func getStyle() -> ButtonStyle {
        var buttonStyle = ButtonStyle()
        buttonStyle.primaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
        buttonStyle.secondaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
        buttonStyle.leftInset = SizesPallete.ButtonSize.horizontaInset.rawValue
        buttonStyle.rightInset = SizesPallete.ButtonSize.horizontaInset.rawValue
        
        switch self {
            
            // Loft Digital Button
        case .rectYellow:
            buttonStyle.primaryViewStyle = ViewStyleSheet.rectYellow.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.rectYellow.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.gothamMedium14GrayTitle.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.gothamMedium14GrayTitle.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0
        case .rectTransparentBordersGray:
            buttonStyle.primaryViewStyle = ViewStyleSheet.transparentGrayBorder.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.transparentGrayBorder.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.gothamMedium14GrayTitle.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.gothamMedium14GrayTitle.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0
            // General Buttons
        case .redRectButton:
            buttonStyle.primaryViewStyle = ViewStyleSheet.redButtonRect.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.redButtonRect.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0
            
        case .redRoundButton:
            buttonStyle.primaryViewStyle = ViewStyleSheet.redButton.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.redButton.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0

            
        case .redRoundButtonOpacy:
            buttonStyle.primaryViewStyle = ViewStyleSheet.redButtonOpacy.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.redButtonOpacy.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0
            
        case .redRectButtonOpacy:
            buttonStyle.primaryViewStyle = ViewStyleSheet.redButtonOpacyRect.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.redButtonOpacyRect.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHelveticaLight.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0
            
        case .roundButton:
            buttonStyle.primaryViewStyle = ViewStyleSheet.transparent.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.transparent.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0

        }
        
        return buttonStyle
    }
}

