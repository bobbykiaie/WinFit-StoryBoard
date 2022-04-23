//
//  CompetitionPageVC.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 4/16/22.
//

import UIKit

class CompetitionPageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let healthPlace = HealthStore()
    var heartArray = ["No Data"]

    
    
    
    
    
    @IBAction func heartListButton(_ sender: UIButton, forEvent event: UIEvent) {
        updateList()
        heartRateTable.reloadData()
        
    }
    
    
    func updateList() {
         heartArray = healthPlace.latestHeartRate()
        print(heartArray.count)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

        healthPlace.latestHeartRate()
        
        heartRateTable.delegate = self
        heartRateTable.dataSource = self
    }
    @IBOutlet weak var heartRate: UILabel!
    
    @IBOutlet weak var heartRateTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        return heartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heartRateTable.dequeueReusableCell(withIdentifier: "heartCell", for: indexPath)
        print(heartArray)
        cell.textLabel?.text = heartArray[indexPath.row]
        
        return cell
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
