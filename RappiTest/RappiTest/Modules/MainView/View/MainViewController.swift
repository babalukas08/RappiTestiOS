//
//  MainViewController.swift
//  RappiTest
//
//  Created by Mauricio Jimenez on 06/06/19.
//  Copyright © 2019 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

class MainViewController: BaseViewController {

    @IBOutlet weak var inputSearch: UITextField!
    @IBOutlet weak var listView: ListView!
    
    weak var presenter: MainViewPresenterInterface?
    
    lazy var mainData : [MainListModel] = {
        return[]
    }()
    
    lazy var data : [BaseGenerModel] = {
       return []
    }()
    
    lazy var detailModel : DataListModel = {
       return DataListModel()
    }()
    
    lazy var disposeBag : DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBinding()
        
        self.hero.isEnabled = true
        self.listView.hero.isEnabled = true
        
        self.showLoader()
        self.presenter?.getCatalogs()

        self.listView.hero.modifiers = [.cascade]
    }

    override func viewWillAppear(_ animated: Bool) {
        self.typeHeader = .Home
    }
    
    override func onTapFilter() {
        self.data = DataSourceManager.getDataFilter()
        self.showFilterModal(delegate: self, model: self.data)
    }
    
    func setBinding() {
        
        self.inputSearch.rx.controlEvent(.editingChanged).subscribe(onNext: { [unowned self] in
            let word = self.inputSearch.getText()
            if word.count > 2 {
                self.findItems(ids: nil, word: word)
            }
            else if word.isEmpty {
                self.originalData()
            }
        }).disposed(by: disposeBag)
    }
    
    private func originalData() {
        
        let ids = DataSourceManager.filtersSelect()
        if ids.count > 0 {
            self.findItems(ids: ids, word: nil)
        }
        else {
            self.mainData = DataSourceManager.getDataMain()
            self.listView.configure(model: self.mainData)
            self.listView.typeList = "mainView"
        }
        
        
    }
    
    private func baseData() -> [MainListModel] {
        return DataSourceManager.getDataMain()
    }
    
    private func findItems(ids: [Int]?, word: String?) {
        if let gfilters = ids, gfilters.count > 0 {
            // Get array by id's
            self.mainData = DataSourceManager.getDataMain(ids: gfilters)
            self.listView.configure(model: self.mainData)
            return
            
        }
        else if let find = word {
            // find by name movie or serie
            let result = self.mainData.filter { (model) -> Bool in
                let filterName = model.data.filter({$0.name.lowercased().contains(find.lowercased())})
                print("\nResult: \(filterName)")
                model.data = filterName
                return filterName.count > 0
            }
            
            if result.count > 0 {
                print(result)
                self.mainData = result
                self.listView.configure(model: self.mainData)
                return
            }
            
        }
        
            self.mainData = self.baseData()
            self.listView.configure(model: self.mainData)
        
    }

}

extension MainViewController : MainViewInterface {
    func servicesResult(_ result: ServicesManagerResult, typeServices: ServicesType) {
        print(typeServices)
        self.hiddenLoader(nil) { (_) in }
        switch result {
        case .success:
            if typeServices == .getCatalog {
                self.listView.delegate = self
                self.mainData = DataSourceManager.getDataMain()
                self.listView.configure(model: self.mainData)
                self.listView.typeList = "mainView"
                //Genders
                self.showLoader("Cargando Generos")
                self.presenter?.getGenders()
            }
            else if typeServices == .genders {
                let serie = TypeItem.serie
                print("Services: \(serie.data)")
                self.originalData()
            }
            else if typeServices == .video {
                self.presenter?.pushToDetail(view: self, navigation: self.navigationController, modelDetail: self.detailModel)
            }
        default:
            if typeServices == .video {
                self.presenter?.pushToDetail(view: self, navigation: self.navigationController, modelDetail: self.detailModel)
            }
            else {
                return
            }
        }
    }
}

extension MainViewController : ListViewViewDelegate {
    func onTapCell(index: IndexPath) {
        print(index)
        self.showLoader()
        self.detailModel = self.mainData[index.section].data[index.row]
        self.presenter?.sendDetail(by: self.detailModel)
    }
}

extension MainViewController : FilterViewDelegate {
    func onTapSend(mod: FilterView, code: String) {
        print("")
    }
    
    func onTapCancel() {
        print("")
    }
    
    func onTapIndex(model: [Int]) {
        self.findItems(ids: model, word: nil)
    }
    
}
