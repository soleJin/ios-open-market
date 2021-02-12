//
//  MainViewController.swift
//  OpenMarket
//
//  Created by sole on 2021/02/04.
//

import UIKit

typealias Page = Int
typealias Response = [Page: [Item]]

protocol SendDataDelegate: AnyObject {
    func didSendData(_ data: Response)
}

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    weak var listCellDelegate: SendDataDelegate?
    weak var gridCellDelegate: SendDataDelegate?
    // 이 때 weak의 의미와 왜 프로토콜이 클래스에서만 채택할 수 있게 하는지 잘 생각해보자ㅋ
    
    var items: [Page: [Item]] = [:]
//    var itemsCount: Int {
//        return items.reduce(0) { currentCount, next in
//            currentCount + next.value.count
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let list = tableView.subviews.first?.subviews.first as? UITableView {
//            requestItems(page: 1) {
//                DispatchQueue.main.async {
//                    list.reloadData() // TODO: 코드 Depth 줄이기.
//                    self.spinner.stopAnimating()
//                }
//            }
//        }
//        if let list = collectionView.subviews.first?.subviews.first as? UICollectionView {
//            requestItems(page: 1) {
//                DispatchQueue.main.async {
//                    list.reloadData()
//                }
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowListCell" {
            let delegate = segue.destination as! SendDataDelegate
            self.listCellDelegate = delegate
        }
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            tableView.isHidden = false
//            if let list = tableView.subviews.first?.subviews.first as? UITableView {
//                list.reloadData()
//            }
            collectionView.isHidden = true
        } else {
            tableView.isHidden = true
            collectionView.isHidden = false
//            if let list = collectionView.subviews.first?.subviews.first as? UICollectionView {
//                list.reloadData()
//            }
        }
    }
}

extension MainViewController {
    func requestItems(page: Int, _ completionHandler: @escaping () -> Void) {
        guard self.items[page] == nil else {
            completionHandler()
            return
        }
        OpenMarketAPI.request(.loadItemList(page: page)) { (result: Result<ItemsToGet, Error>) in
            switch result {
            case .success(let data):
                self.items.updateValue(data.items, forKey: data.page)
                completionHandler()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
//    func getItem(_ row: Int) -> Item? {
//        let page = row / 20 + 1
//        let n = row % 20
//        if let itemsOfPage = items[page] {
//            return itemsOfPage[n]
//        }
//        return nil
//    }
}

