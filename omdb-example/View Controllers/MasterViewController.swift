//
//  MasterViewController.swift
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

protocol MasterDisplayLogic: class
{
  
}

class MasterViewController: UIViewController, MasterDisplayLogic
{
  var interactor: MasterBusinessLogic?
  var router: (NSObjectProtocol & MasterRoutingLogic & MasterDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MasterInteractor()
    let presenter = MasterPresenter()
    let router = MasterRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
    @IBOutlet weak var searchBar: UISearchBar!
    
  
  func doSomething()
  {
    let request = Master.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  
}
