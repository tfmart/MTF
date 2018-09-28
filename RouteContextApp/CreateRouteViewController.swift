//
//  CreateRouteViewController.swift
//  RouteContextApp
//
//  Created by Tomas Martins on 11/09/2018.
//  Copyright © 2018 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit

class CreateRouteViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    //Location vars
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var createRouteButton: UIButton!
    @IBOutlet weak var routeNameTextField: UITextField!
    
    var srcLat: CLLocationDegrees?
    var srcLon: CLLocationDegrees?
    var dstLat: CLLocationDegrees?
    var dstLon: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        createRouteButton.layer.cornerRadius = 15.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Get user current location and sets map region
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let localValue: CLLocationCoordinate2D = manager.location!.coordinate
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
        self.MapView.setRegion(viewRegion, animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
