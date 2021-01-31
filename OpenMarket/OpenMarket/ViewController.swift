//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        OpenMarketAPI.request(RequestType.loadItemList(page: 1)) { (result: Result<ItemsToGet, Error>) -> () in
            switch result {
            case .success(let result):
                print("몇개있니? : \(result.items.count)")
                return
            case .failure(let error):
                print("fail \(error)")
                return
            }
        }
        
        OpenMarketAPI.request(RequestType.loadItem(id: 1)) { (result: Result<ItemToGet, Error>) -> () in
            switch result {
            case .success(let result):
                print("상세설명 : \(result.descriptions)")
                return
            case .failure(let error):
                print("fail \(error)")
                return
            }
        }
    }
}

