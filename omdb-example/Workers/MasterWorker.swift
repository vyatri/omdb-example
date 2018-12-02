//
//  OMDBWorker.swift
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
import Alamofire

class MasterWorker
{
    
    
    func doSearch(_ keyword: String, page: Int = 1, completion: @escaping (FilmList?, Int) -> Void)
    {
        
        let historyWorker = HistoryWorker()
        let searchedFilmsWorker = SearchedFilmsWorker()
        var pageToSearch = page
        
        var filmCollectors = [Film]()
        
        // get existing Search Results From DB
        if page == 1 {
            let existingHistory = historyWorker.getHistoryByKeyword(keyword)
            if existingHistory != nil {
                let films = searchedFilmsWorker.fetchResultsByKeyword(keyword)
                if films.count > 0 {
                    filmCollectors.append(contentsOf: films)
                }
                pageToSearch = existingHistory!.lastPage + 1
            }
        }
        
        guard Reachability.isConnectedToNetwork() else {
            completion(FilmList(filmCollectors),pageToSearch)
            return
        }
        
        let parameters: Parameters = [
            "apikey": "58aba22c", "r": "json",
            "s": keyword,
            "page": pageToSearch
        ]
        Alamofire.request("https://www.omdbapi.com/", parameters: parameters).validate()
            .responseJSON(completionHandler: { (response) in
                
            })
            .responseData { response in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let gitData = try decoder.decode(FilmList.self, from: data)
                        
                        if UserDefaults.standard.bool(forKey: "noSync") == false {
                            historyWorker.saveHistory(History(keyword: keyword, lastPage: pageToSearch))
                            searchedFilmsWorker.saveResults(gitData.Search, keyword: keyword)
                        }
                        
                        filmCollectors.append(contentsOf: gitData.Search)
                        completion(FilmList(filmCollectors), pageToSearch+1)
                        return
                    } catch let err {
                        print("Err", err)
                    }
                }
            case .failure( _):
                print("network error")
            }
            completion(FilmList(filmCollectors), pageToSearch)
        }
    }
    
    func getSearchResultsFromDB(_ keyword: String) -> [Film]
    {
        
        return []
    }
    
    func saveResults(_ results: [Film], onpage: Int)
    {
        
    }
    
    func getLastSearchBreakpoinnt(_ keyword: String) -> History?
    {
        return nil
    }
    
    func saveLastBreakpoint(_ history: History) -> Bool
    {
        return true
    }
}
