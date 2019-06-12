//
//  SplashViewController.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 12/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    weak var presenter: MainViewPresenterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPallete.redLogin.asColor()
        self.presenter?.getCatalogs()
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
                self.presenter?.pushToMainView(navigation: self.navigationController)
            }
        default:
            return
        }
    }
}
