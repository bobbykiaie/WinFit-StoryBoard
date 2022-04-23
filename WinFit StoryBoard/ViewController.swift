//
//  ViewController.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 4/16/22.
//

import UIKit
import HealthKit


    //Shared Variable

    
    //Healthkit store object




class ViewController: UIViewController {
  
    let healthPlace = HealthStore()
    var scone = "scone"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        healthPlace.accessData()
        healthPlace.latestHeartRate()
        healthPlace.getRestingHR()
       
        
    }
   
    @IBAction func TestButton(_ sender: UIButton, forEvent event: UIEvent) {
//        healthPlace.averageOfHR()
    }
    
    
   
    @IBAction func changeSteps(_ sender: UIButton, forEvent event: UIEvent)  {
        healthPlace.getRestingHR()
        healthPlace.latestHeartRate()
        theSteps.text = String(healthPlace.recentHeartRate)
        restingHRLabel.text = String(healthPlace.restHR)
        
    }
    
    
    
    @IBOutlet weak var restingHRLabel: UILabel!
    @IBOutlet weak var theSteps: UILabel!
    
    
}

