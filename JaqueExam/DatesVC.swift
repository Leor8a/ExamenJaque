//
//  ViewController.swift
//  JaqueExam
//
//  Created by Luis Ernesto Ochoa Rios on 5/11/20.
//  Copyright © 2020 Luis Ernesto Ochoa Rios. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


let parameters: [String: Any] = [
    "api_key": "YUfdS621JMNbHJD1cK16qBF9edmg6RfELqEb9lC9",
    "date":"2019-07-01"
]
var datesArray = [String]()

class DatesVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datesArray = getLastHundredDates()
        print(datesArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchURL(url: "https://api.nasa.gov/planetary/apod", param: parameters)
    }
    
    //Start of TableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateCellIdentifier") else {
                    fatalError("Could not dequeue a cell")
        }
        cell.textLabel?.text = datesArray[indexPath.row]
        return cell
    }
    
    
    func fetchURL(url: String, param: [String: Any]){
        Alamofire.request(url, parameters: param).responseString { (response) in
            print (response.value ?? "No Value")
            }.responseJSON { (response) in
            print (response.value ?? "No Value")
        }
    }
    
    func getLastHundredDates() -> [String]
    {
        let cal = Calendar.current
        let date = cal.startOfDay(for: Date())
        var days = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        for i in 0 ... 99 {
            let newdate = cal.date(byAdding: .day, value: -i, to: date)!
            let str = dateFormatter.string(from: newdate)
            days.append(str)
        }
        //print("Numero de días:\(days.count)")
        return days
    }


}

