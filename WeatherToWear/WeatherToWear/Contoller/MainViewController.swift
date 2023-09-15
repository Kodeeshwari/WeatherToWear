//
//  MainViewController.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-17.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var imgArray = [UIImage(named: "bg"),UIImage(named: "bg"),UIImage(named: "bg"),UIImage(named: "bg"),UIImage(named: "bg")]
    var outfitsArray: [WeatherOutfit] = []
    
   
    let imagesDictionary: [String: UIImage] = ["rain": UIImage(named: "rain")!, "cloud": UIImage(named: "cloud")!,"snow": UIImage(named: "snow")!,"clear": UIImage(named: "cloud")!]

    
    var userModel : UserModel?
    var currentWeather : WeatherDataDetail?
    var currentDay : WeatherDay?
    var outfit : WeatherOutfit?
    
    @IBOutlet weak var lblhighLow: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblWeatherCondition: UILabel!
    @IBOutlet weak var imgWeatherType: UIImageView!
    
    
    @IBOutlet weak var logoutUiBarBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.indicatorStyle = .white
        currentWeatherDetail()
        
      
        // setViewComponent()
    }
    
    func initialize(){
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        if let userModel = userModel{
            navigationItem.title = userModel.city?.capitalized
        }
        
        if let navBar = navigationController?.navigationBar {
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return outfitsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Segue.OutfitCollectionViewCell, for: indexPath) as! OutfitCollectionViewCell
        
        let outfit = outfitsArray[indexPath.row]
        
        if let url = URL(string: outfit.image) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    
                    DispatchQueue.main.async {
                        cell.outfitImage.image = UIImage(data: data)
                    }
                }
            })
            dataTask.resume()
        }
        return cell
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        performSegue(withIdentifier: Segue.toOutfitFilterViewController, sender: nil)
    }
    
    func currentWeatherDetail(){
        
        ManageFeatureAPI.getWeatherData(city:userModel!.city!, fromDate: "2023-04-11", toDate: "2023-04-11", gender: userModel!.gender!, successHandler: {(httpStatusCode,response) in
            DispatchQueue.main.async {
                if httpStatusCode==200{
                    
                    let message = response["message"] as? String ?? "Unknown response"
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: response["data"], options: []),
                       let weatherDataDetail = WeatherDataDetail.decode(json: response["data"] as? [String : Any]) {
                        
                        self.updateUI(with: weatherDataDetail)
                    } else {
                        // Failed to decode the response into a WeatherDataDetail object
                        Toast.ok(view: self, title: "Error", message: "Failed to decode weather data")
                    }
                    
                }
                else{
                    Toast.ok(view: self, title: "Response", message: "\(httpStatusCode)")
                }
            }
        }, failHandler: {(httpStatusCode,errorMessage)in
            print("HTTP Status Code: \(httpStatusCode)")
            print("Error Message: \(errorMessage)")
            DispatchQueue.main.async {
                Toast.ok(view: self, title: "Error: \(httpStatusCode)", message: "\(errorMessage)")
            }
            
        })
        
    }
    
    func updateUI(with weatherDataDetail: WeatherDataDetail) {
        
        if let weatherDay = weatherDataDetail.days.first {
            self.lblTemp.text = "\(weatherDay.temp)"
            self.lblhighLow.text = "\(weatherDay.tempmax) \(weatherDay.tempmin)"
            self.lblCity.text = weatherDay.datetime
            self.lblWeatherCondition.text = weatherDay.preciptype
            
            self.imgWeatherType.image = imagesDictionary[weatherDay.preciptype]
            
            for outfitData in weatherDay.outfits {
                let outfit = WeatherOutfit(name: outfitData.name, image: outfitData.image)
                outfitsArray.append(outfit)
            }
            //            print(outfitsArray.first?.image)
            
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    @IBAction func logoutUIBarBtn(_ sender: Any) {
        performSegue(withIdentifier: Segue.toLoginViewController, sender: nil)
    }
    
}
