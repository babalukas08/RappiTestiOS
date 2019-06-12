//
//  SplashViewController.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 12/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: BaseViewController {
    
    @IBOutlet weak var lottieView: UIView!
    weak var presenter: MainViewPresenterInterface?
    
    var successServices = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPallete.bgBaseView.asColor()
        self.presenter?.getCatalogs()
        
        let starAnimationView = AnimationView(name: "penguin")
        starAnimationView.loopMode = .playOnce
        starAnimationView.animationSpeed = 1
        starAnimationView.contentMode = .scaleAspectFit
        
        self.lottieView.addSubview(starAnimationView)
        
        let label = Heading(frame: .zero)
        label.styleName = TypographyStyle.txtHeaderGeneral.rawValue
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.text = "Descuida el PINGÜINO es inofensivo si no lo molestas! Deja que baile mientras descargamos los catálogos."
        self.lottieView.addSubview(label)
        
        
        starAnimationView.translatesAutoresizingMaskIntoConstraints = false
        starAnimationView.centerXAnchor.constraint(equalTo: lottieView.centerXAnchor, constant:0).isActive = true
        starAnimationView.centerYAnchor.constraint(equalTo: lottieView.centerYAnchor, constant:0).isActive = true
        starAnimationView.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor, constant: 0).isActive = true
        starAnimationView.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor, constant: 0).isActive = true
        starAnimationView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        starAnimationView.clipsToBounds = true
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: starAnimationView.bottomAnchor, constant: 0).isActive = true
        label.centerXAnchor.constraint(equalTo: starAnimationView.centerXAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: starAnimationView.trailingAnchor, constant: -16).isActive = true
        label.leadingAnchor.constraint(equalTo: starAnimationView.leadingAnchor, constant: 16).isActive = true
        label.clipsToBounds = true
        
        starAnimationView.play() { (finished) in
            if finished {
                if self.successServices {
                    self.presenter?.pushToMainView(navigation: self.navigationController)
                }
                else {
                    starAnimationView.play()
                }
            }
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SplashViewController : MainViewInterface {
    func servicesResult(_ result: ServicesManagerResult, typeServices: ServicesType) {
        print(typeServices)
        self.hiddenLoader(nil) { (_) in }
        switch result {
        case .success:
            if typeServices == .getCatalog {
                self.showLoader("Cargando Generos")
                self.presenter?.getGenders()
            }
            else if typeServices == .genders {
                let serie = TypeItem.serie
                print("Services: \(serie.data)")
                self.successServices = !self.successServices
            }
        default:
            return
        }
    }
}
