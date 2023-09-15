////
////  currentLocationViewController.swift
////  WeatherToWear
////
////  Created by Kodeeshwari Solanki on 2023-04-18.
////
//
//import UIKit
//
//class currentLocationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var dayNightBGImageView: UIImageView!
//
//    @IBOutlet weak var outfitTableView: UITableView!
//
//    var imageViewOriginalHeight: CGFloat = 0
//
//    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
//
//    var all : [OutfitModel] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        initialize()
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//
//        let numRows = outfitTableView.numberOfRows(inSection: 0)
//
//        // Then, scroll to the last row of the table view
//        if numRows > 0 {
//            let lastRowIndex = numRows - 1
//            let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
//            outfitTableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
//        }
//
//    }
//
//
//    public func initialize(){
//
//        let myOutfit = OutfitModel(outfitName: "Jumper",outfitImageUrl: URL(string: "https://fakeimg.pl/250x100/ff0000/")!)
//
//        all.append(myOutfit)
//
//        let myOutfit1 = OutfitModel(outfitName: "Jacket",outfitImageUrl: URL(string: "https://fakeimg.pl/250x100/ff0000/")!)
//        all.append(myOutfit1)
//
//        //injecting a xib or nib to tableview
//        outfitTableView.register(UINib(nibName: OutfitTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OutfitTableViewCell.identifier)
//        outfitTableView.delegate = self
//        outfitTableView.dataSource = self
//
//        outfitTableView.separatorColor = UIColor.gray
//        imageViewOriginalHeight = dayNightBGImageView.frame.height
//        outfitTableView.frame = view.bounds
//
////        outfitTableView.estimatedRowHeight = 350
////        outfitTableView.rowHeight = UITableView.automaticDimension
//
//    }
//
////    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//////        if scrollView.contentOffset.y>0{
//////            let imageViewNewHeight = imageViewOriginalHeight - scrollView.contentOffset.y
//////
//////            dayNightBGImageView.frame.size.height = imageViewNewHeight
//////            dayNightBGImageView.frame.origin.y = 0
//////
//////            outfitTableView.frame.origin.y = imageViewNewHeight
//////            outfitTableView.frame.size.height = view.frame.height - imageViewNewHeight
//////
//////        }
////
////        let statusBarHeight = UIApplication.shared.statusBarFrame.height
////            let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
////            outfitTableView.frame = CGRect(x: 0, y: statusBarHeight + navigationBarHeight,
////                                            width: view.bounds.width, height: view.bounds.height - statusBarHeight - navigationBarHeight)
////        }
////
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return all.count
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////        let cell = tableView.dequeueReusableCell(withIdentifier: OutfitTableViewCell.identifier, for: indexPath) as! OutfitTableViewCell
////
////        cell.setCellContent(outfit: all[indexPath.row])
////
////        return cell
////    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 260
//        //return UITableView.automaticDimension
//    }
//
//
//}
