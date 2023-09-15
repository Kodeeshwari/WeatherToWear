//
//  CustomSearchOutfitViewController.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-20.
//

import UIKit

class CustomSearchOutfitViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var weatherDay : WeatherDay?
    var outfitsArray :[WeatherOutfit]=[]
    
    @IBOutlet weak var outfitTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outfitTableView.register(UINib(nibName: CustomSearchOutfitTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomSearchOutfitTableViewCell.identifier)
        print(weatherDay?.outfits.first?.image)
        outfitTableView.dataSource = self
        outfitTableView.delegate = self
        
        for outfitData in weatherDay!.outfits {
            let outfit = WeatherOutfit(name: outfitData.name, image: outfitData.image)
            outfitsArray.append(outfit)
        }
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outfitsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = outfitTableView.dequeueReusableCell(withIdentifier: CustomSearchOutfitTableViewCell.identifier, for: indexPath) as! CustomSearchOutfitTableViewCell
        
        cell.setCellContent(weatherOutfit : outfitsArray[indexPath.row])
        cell.backgroundColor = UIColor.clear
        return cell
    }

}
