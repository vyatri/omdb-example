//
//  MasterPresenter.swift
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

protocol MasterPresentationLogic
{
    func presentData(_ results: FilmList?, atPage: Int)
}

class MasterPresenter: MasterPresentationLogic
{
  weak var viewController: MasterDisplayLogic?
  
    func presentData(_ results: FilmList?, atPage: Int) {
        viewController?.displayData(results, atPage: atPage)
    }
}
