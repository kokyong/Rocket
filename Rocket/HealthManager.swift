//
//  HealthManager.swift
//  Rocket
//
//  Created by Kok Yong on 19/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import HealthKit


class HealthManager {
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((_ success:Bool, _ error:NSError?) -> Void)!)
    {
        // 1. Set the types you want to read from HK Store
        let healthKitTypesToRead : Set<HKObjectType>  = [HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKObjectType.workoutType()]
        
        
        // 2. Set the types you want to write to HK Store
        let healthKitTypesToWrite : Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
                                          HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
                                          HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!]
                                          
            
        
        
        // 3. If the store is not available (for instance, iPad) return an error and don't go on.
        if !HKHealthStore.isHealthDataAvailable()
        {
            let error = NSError(domain: "com.raywenderlich.tutorials.healthkit", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if( completion != nil )
            {
                completion
            }
            return
        }
        
        // 4.  Request HealthKit authorization
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) -> Void in
            
            completion?(success, error as! NSError)
        }
        
        
    }
    
    
}
