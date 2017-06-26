//
//  CarCareStore.swift
//  CarCareOnBoard
//
//  Created by Profesores on 6/12/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CarCareStore {
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    func addFuelType(name: String, about: String) {
        let fuelType = FuelType(context: context)
        fuelType.name = name
        fuelType.about = about
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func findAllFuelTypes() -> [FuelType] {
        var fuelTypes: [FuelType] = []
        do {
            fuelTypes = try context.fetch(FuelType.fetchRequest())
        } catch {
            print("Error fetching data from Data Store")
        }
        return fuelTypes
    }
    
    func deleteFuelType(for name: String) {
        let request = NSFetchRequest<FuelType>(entityName: "FuelType")
        do {
            let results = try context.fetch(request)
            for fuelType in results {
                if fuelType.name == name {
                    context.delete(fuelType)
                }
            }
        } catch {
            print("Error while deleting: \(error)")
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addFuelUpEntry(gallons: Double, locationReference: String, odometer: String, unitPrice: Double, fuelType: FuelType) {
        let fuelUpEntry = FuelUpEntry(context: context)
        fuelUpEntry.gallons = gallons
        fuelUpEntry.locationReference = locationReference
        fuelUpEntry.odometer = odometer
        fuelUpEntry.fuelType = fuelType
        fuelUpEntry.unitPrice = unitPrice
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
}

