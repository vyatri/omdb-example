
//
//  MasterInteractor.swift
//  omdb-example
//
//  Created by Juanita Vyatri on 01/12/18.
//  Copyright (c) 2018 Vyatri. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MasterBusinessLogic
{
    func fetchData(keyword: String?, page: Int)
}

protocol MasterDataStore
{
  //var name: String { get set }
}

class MasterInteractor: MasterBusinessLogic, MasterDataStore
{
  var presenter: MasterPresentationLogic?
  var worker: OMDBWorker?
//  //var name: String = ""
//
//  // MARK: Do something
//
  func fetchData(keyword: String?, page: Int = 1)
  {
    
    guard keyword != nil && keyword!.trimmingCharacters(in: NSCharacterSet.whitespaces).count > 0 else { return }
    
    worker = OMDBWorker()
    worker?.doSearch(keyword ?? "", page: page, completion: { (results) in
        self.presenter?.presentData(results)
    })
  }
}
