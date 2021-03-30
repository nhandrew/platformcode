//
//  PressureStreamHandler.swift
//  Runner
//
//  Created by Andrew Julow on 3/30/21.
//

import Foundation
import CoreMotion

class PressureStreamHandler: NSObject, FlutterStreamHandler {
    let altimeter = CMAltimeter()
    private let queue = OperationQueue()
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: queue) { (data,error) in
                if data != nil {
                //Get pressure
                let pressurePascals = data?.pressure
                    events(pressurePascals!.doubleValue * 10.0)
             }
            }
        }
        return nil
    }
    
    func onCancel(withArguments arguments:Any?) -> FlutterError? {
        altimeter.stopRelativeAltitudeUpdates()
        return nil
    }
    
}
