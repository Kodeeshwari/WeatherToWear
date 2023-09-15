//
//  OutfitFilterViewController.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-19.
//

import UIKit

class OutfitFilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var genderList = ["Male", "Female", "Other"]
    var city : String = ""
    
    var weatherDayArray: [WeatherDay] = []
    
    var weatherDay : WeatherDay?
    
    
    var selectedGender: String?
    let startDatepicker = UIDatePicker()
    let endDatepicker = UIDatePicker()
    
    
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var btnOutfitSearch: UIButton!
    
    @IBOutlet weak var lblSortByDate: UILabel!
    
    @IBOutlet weak var switchSortDate: UISwitch!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search for Outfit"
        
        // Set the color of the back button in the navigation bar to white
        navigationController?.navigationBar.tintColor = UIColor.white

//        navigationItem.titleTextAttributes = [.foregroundColor: UIColor.white]
        if let navBar = navigationController?.navigationBar {
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        initial();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if isMovingFromParent { // Check if the user is navigating back
            // Clear table view data
            self.weatherDayArray.removeAll()
            self.tableView.reloadData()
        }
    }
    
    private func initial(){
        
        
        //intialise  the table view
        tableView.register(UINib(nibName: OutfitTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OutfitTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        createPickerView()
        startDatePickerView()
        endDatePickerView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genderList[row]
        
        txtGender.text = selectedGender
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.tintColor = UIColor.white
        txtGender.inputView = pickerView
        dismissPickerView()
    }
    
    func startDatePickerView(){
        startDatepicker.datePickerMode = .date
        startDatepicker.addTarget(self, action: #selector(self.startDateChange(datePicker:)), for: UIControl.Event.valueChanged)
        txtStartDate.inputView = startDatepicker
        txtStartDate.text = formatDate(date: Date())
        startDatepicker.frame.size = CGSize(width: 0, height: 300)
        startDatepicker.preferredDatePickerStyle = .wheels
        dismissPickerView()
    }
    
    func endDatePickerView(){
        endDatepicker.datePickerMode = .date
        endDatepicker.addTarget(self, action: #selector(self.endDateChange(datePicker:)), for: UIControl.Event.valueChanged)
        txtEndDate.inputView = endDatepicker
        txtEndDate.text = formatDate(date: Date())
        endDatepicker.frame.size = CGSize(width: 0, height: 300)
        endDatepicker.preferredDatePickerStyle = .wheels
        dismissPickerView()
    }
    
    
    @objc func startDateChange(datePicker: UIDatePicker){
        txtStartDate.text = formatDate(date: datePicker.date)
    }
    
    @objc func endDateChange(datePicker: UIDatePicker){
        txtEndDate.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
        
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtStartDate.inputAccessoryView = toolBar
        txtEndDate.inputAccessoryView = toolBar
        txtGender.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    
    @IBAction func btnOutfitSearchTouchUpInside(_ sender: Any) {
        guard let city = txtCity.text,
              let gender = selectedGender,
              let startDate = txtStartDate.text,
              let endDate = txtEndDate.text else {
            // handle missing fields here
            Toast.ok(view: self, title: "Error", message: "No feild should be empty")
            return
        }
        
        ManageFeatureAPI.getWeatherData(city:city.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), fromDate: startDate, toDate: endDate, gender: gender.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), successHandler: {(httpStatusCode,response) in
            DispatchQueue.main.async {
                if httpStatusCode==200{
                    
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
    
    //count the table view item
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDayArray.count
    }
    
    //set the table view item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OutfitTableViewCell.identifier, for: indexPath) as! OutfitTableViewCell
        
        cell.setCellContent(weatherDay:weatherDayArray[indexPath.row], city:city)
        
        return cell
    }
    
    //set the table view height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherDay = weatherDayArray[indexPath.row]
        performSegue(withIdentifier: Segue.toCustomSearchOutfitViewController, sender: nil)
    }
    
    func updateUI(with weatherDataDetail: WeatherDataDetail) {
        
        city = weatherDataDetail.city
        for weatherDay in weatherDataDetail.days{
            weatherDayArray.append(weatherDay)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==Segue.toCustomSearchOutfitViewController{
            if let customSearchViewController = segue.destination as? CustomSearchOutfitViewController{
                customSearchViewController.weatherDay = weatherDay
            }
        }
    }
    
    
    @IBAction func swtichValueChanged(_ sender: Any) {
        var reverseArray : [WeatherDay]{
            return Array(weatherDayArray.reversed())
        }
        if switchSortDate.isOn{
            
            weatherDayArray=reverseArray
            tableView.reloadData()
        }
        else{
            weatherDayArray=reverseArray
            tableView.reloadData()
        }
    }
    
    
}
