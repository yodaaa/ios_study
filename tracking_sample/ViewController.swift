//
//  ViewController.swift
//  tracking_sample/Users/masaakiyoda/Desktop/tracking_sample/tracking_sample/ViewController.swift
//
//  Created by 依田真明 on 2016/05/19.
//  Copyright © 2016年 MasaakiYoda. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var myLongitudeLabel: UILabel!
    @IBOutlet weak var myLatitudeLabel: UILabel!
    
    var myLocationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示.
        if(status == CLAuthorizationStatus.notDetermined) {
            print("didChangeAuthorizationStatus:\(status)");
            // まだ承認が得られていない場合は、認証ダイアログを表示.
            self.myLocationManager.requestAlwaysAuthorization()
        }
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = 1
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("didChangeAuthorizationStatus");
        
        // 認証のステータスをログで表示.
        var statusStr = "";
        switch (status) {
        case .notDetermined:
            statusStr = "NotDetermined"
        case .restricted:
            statusStr = "Restricted"
        case .denied:
            statusStr = "Denied"
        case .authorizedAlways:
            statusStr = "AuthorizedAlways"
        case .authorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        print(" CLAuthorizationStatus: \(statusStr)")
    }
    
    @IBAction func GetLocate(_ sender: UIButton) {
        myLocationManager.startUpdatingLocation()
    }
    
    @IBAction func StopLocate(_ sender: UIButton) {
        myLocationManager.stopUpdatingLocation()
        myLatitudeLabel.text = "緯度："
        myLongitudeLabel.text =  "経度："
    }
    
    // 位置情報取得成功時に呼ばれます
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("緯度：\(manager.location!.coordinate.latitude)")
        print("経度：\(manager.location!.coordinate.longitude)")
        myLatitudeLabel.text = "緯度：\(manager.location!.coordinate.latitude)"
        myLongitudeLabel.text = "経度：\(manager.location!.coordinate.longitude)"
    }
    
    // 位置情報取得失敗時に呼ばれます
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
        print("error")
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

