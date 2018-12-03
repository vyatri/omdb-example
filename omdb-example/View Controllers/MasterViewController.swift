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
    func displayData(_ results: FilmList?, nextPage: Int)
    func clearDisplay()
}

class MasterViewController: UIViewController, MasterDisplayLogic, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var searchResults: [Film]!
    var needDisplayPage: Int!
    var enableSearchOnScroll: Bool!
    
    func displayData(_ results: FilmList?, nextPage: Int = 1) {
        
        // results found
        if (results != nil && results!.Search.count > 0){
            if needDisplayPage == 1 || searchResults == nil {
                searchResults = results?.Search
            } else {
                searchResults += results!.Search
            }
            enableSearchOnScroll = true
        }
        
        // keyword is not yielding results
        else if needDisplayPage == 1 {
            searchResults = nil
        }
        
        // reached end of page
        else {
            
        }
        
        needDisplayPage = nextPage
        collectionView.reloadDataSmoothly()
    }
    
    func clearDisplay() {
        searchResults = nil
        needDisplayPage = 1
        enableSearchOnScroll = false
        collectionView.reloadDataSmoothly()
    }
    
    // card size for list view
    func portraitCellSize() -> CGSize {
        let width = self.collectionView.bounds.size.width - 30
        let height:CGFloat = 100.0
        return CGSize(width: width, height: height)
    }
    
    // card size for grid view
    func landscapeCellSize() -> CGSize {
        let width:CGFloat = (self.collectionView.bounds.size.width - 90 ) / 4
        // image ratio is 8:11. Then, 60 height for title is enough
        let height:CGFloat = ( width * 11 / 8 ) + 60
        return CGSize(width: width, height: height)
    }
    
    @IBAction func toggleSyncSwitch(_ sender: UISwitch) {
        UserDefaults.standard.set((sender.isOn) ? false : true , forKey: "noSync")
    }
    // MARK: - Searchbar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        needDisplayPage = 1
        enableSearchOnScroll = true
        interactor?.fetchData(keyword: searchBar.text, page: needDisplayPage ?? 1)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    // MARK: - UICollectionView delegate, datasource, and flowlayout
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchResults == nil {
            self.collectionView.isHidden = true
            return 0
        } else {
            self.collectionView.isHidden = false
            return searchResults.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmcard", for: indexPath) as! FilmCell
        cell.setData(searchResults[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            return landscapeCellSize()
        } else {
            return portraitCellSize()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard enableSearchOnScroll == true else { return }
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height - 20 {
            enableSearchOnScroll = false
            interactor?.fetchData(keyword: searchBar.text, page: (needDisplayPage ?? 1) )
            self.collectionView.reloadData()
        }
    }
}
