//
//  device.swift
//  blescan
//
//  Created by Saber Ben Khalifa on 2/3/19.
//  Copyright © 2019 Saber Ben Khalifa. All rights reserved.
//



class Peripheral {
    
    var deviceName: String
    var macAddress: String
    var temp: Double
    var dateTime:String
    var  advertisementData: [String : Any]
    
    init(deviceName:String,macAddress :String , temp :Double , dateTime : String,  advertisementData: [String : Any]) {
        self.deviceName = deviceName
        self.macAddress = macAddress
        self.temp = temp
        self.dateTime = dateTime
        self.advertisementData=advertisementData
    }
}
