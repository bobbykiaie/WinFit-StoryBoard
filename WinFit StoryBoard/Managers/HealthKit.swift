//
//  HealthKit.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 4/18/22.
//

import Foundation
import HealthKit

class HealthStore {
    
    var healthStore: HKHealthStore?
    var recentHeartRate = 0.0
    var recentSteps = 0.0
    var restHR = 0.0
    var dataArray = ["0.0"]
    
    init(){
        if HKHealthStore.isHealthDataAvailable() {
            
            healthStore = HKHealthStore()
        } else {
            return
        }
             self.accessData()
            self.getRestingHR()
            self.getSteps { num in
               
                self.recentSteps = num
            }

    }
    
    
    func accessData() {
        let read = Set(
            [HKObjectType.quantityType(forIdentifier: .heartRate)!,
             HKObjectType.quantityType(forIdentifier: .stepCount)!,
             HKObjectType.quantityType(forIdentifier: .restingHeartRate)!
            ])
        
        let share = Set(
            [HKObjectType.quantityType(forIdentifier: .heartRate)!,
             HKObjectType.quantityType(forIdentifier: .stepCount)!,
             HKObjectType.quantityType(forIdentifier: .restingHeartRate)!
            ])
        
        healthStore!.requestAuthorization(toShare: share, read: read) { (success, error) in
            if !success {
               print("Error")
                
            }
        }
    }
    
    
//    func averageOfHR(){
//        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else{
//            return
//        }
//        
//        let startDate = calendar.startOfDay(for: Date())
//        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
//        let predicate = HKSamplePredicate.quantitySample(type: sampleType, predicate: <#T##NSPredicate?#>)
//        let query = HKStatisticsQueryDescriptor(predicate: sampleType, options: <#T##HKStatisticsOptions#>)
//        healthStore?.execute(query)
//            
//    }
    
    func getRestingHR() {
        //Create query to get Resting Heart Rate
        
        let restingHRType = HKSampleType.quantityType(forIdentifier: .restingHeartRate)
   
       
      
        let query = HKSampleQuery(sampleType: restingHRType!, predicate: nil, limit: 5, sortDescriptors: nil) { query, results, error in
            guard results != nil else {
                self.restHR = 59
                return
            }
            if (results == nil) {
                print("no Results")
            }
            else {
//                print(results!)
            }
            let data = results![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            let restingHR = data.quantity.doubleValue(for: unit)
//            print(restingHR)
            guard restingHR > 0  else {
                return
            }
            self.restHR = restingHR
            
        }
        
         healthStore?.execute(query)
 
        
    }
    
    func getSteps(completion: @escaping(Double) -> Void) {
        
        let sampleType = HKQuantityType(.stepCount)
  
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let startOfDay = Calendar.current.startOfDay(for: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        
        let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: startOfDay, intervalComponents: DateComponents(day: 1))
        query.initialResultsHandler = { _, result, error in
            guard result != nil else {
                completion(55)
                return
            }
                var resultCount = 0.0
                result!.enumerateStatistics(from: startOfDay, to: Date()) { statistics, _ in
                if let sum = statistics.sumQuantity() {
                    // Get steps (they are of double type)
                    resultCount = sum.doubleValue(for: HKUnit.count())
                    
                    
                } // end if
                // Return
                    completion(resultCount.rounded())
                    
            }
            
        }
        healthStore?.execute(query)
        
    }
    
    func latestHeartRate() -> [String] {
      
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return ["Scone"] }
        
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor])  { (sample, result, error) in
            guard error == nil else {
                return
            }
           
           
            let data = result! as! [HKQuantitySample]
            let unit = HKUnit(from: "count/min")
            let newArray = data.map { item in
               String(item.quantity.doubleValue(for: unit))
            }
            
            self.dataArray = newArray
            let lastIndex = data.count - 1
            let latestHR = data[lastIndex].quantity.doubleValue(for: unit)
         
            self.recentHeartRate = latestHR
            
        }
        healthStore?.execute(query)
        
        return dataArray
    }
   
        
}
