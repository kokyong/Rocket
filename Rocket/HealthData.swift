//
//  HealthData.swift
//  Rocket
//
//  Created by Kok Yong on 17/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

//

//
//import Foundation
//import HealthKit
//
//class HealthKitManager {
//    
//    class var sharedInstance: HealthKitManager {
//        struct Singleton {
//            static let instance = HealthKitManager()
//        }
//        
//        return Singleton.instance
//    }
//    
//    let healthStore: HKHealthStore? = {
//        if HKHealthStore.isHealthDataAvailable() {
//            return HKHealthStore()
//        } else {
//            return nil
//        }
//    }()
//    
//    let dateOfBirthCharacteristic = HKCharacteristicType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)
//    
//    let biologicalSexCharacteristic = HKCharacteristicType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)
//    
//    let bloodTypeCharacteristic = HKCharacteristicType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)
//    
//    var dateOfBirth: String? {
//       let dateOfBirth = healthStore?.dateOfBirthComponents() {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .short
//           return dateFormatter.stringFromDate(dateOfBirth)
//        }
//        return nil
//    }
//    
//    var biologicalSex: String? {
//        if let biologicalSex = healthStore?.biologicalSex() {
//            switch biologicalSex.biologicalSex {
//            case .female:
//                return "Female"
//            case .male:
//                return "Male"
//            case .notSet:
//                return nil
//            }
//        }
//        return nil
//    }
//    
//    var bloodType: String? {
//        if let bloodType = healthStore?.bloodType() {
//            
//            switch bloodType.bloodType {
//            case .aPositive:
//                return "A+"
//            case .aNegative:
//                return "A-"
//            case .bPositive:
//                return "B+"
//            case .bNegative:
//                return "B-"
//            case .abPositive:
//                return "AB+"
//            case .abNegative:
//                return "AB-"
//            case .oPositive:
//                return "O+"
//            case .oNegative:
//                return "O-"
//            case .notSet:
//                return nil
//            }
//        }
//        return nil
//    }
//    
//    func requestHealthKitAuthorization(dataTypesToWrite: NSSet?, _ dataTypesToRead: NSSet?) {
//        healthStore?.requestAuthorization(toShare: dataTypesToWrite as! Set<HKSampleType>?, read: dataTypesToRead as! Set<HKObjectType>?, completion: { (success, error) -> Void in
//            if success {
//                print("success")
//            } else {
//                print("error")
//            }
//        })
//    }
//}


