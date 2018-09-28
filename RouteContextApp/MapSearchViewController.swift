//
//  MapSearchViewController.swift
//  RouteContextApp
//
//  Created by Tomas Martins on 12/09/2018.
//  Copyright © 2018 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit

class MapSearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var serachBarMap: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serachBarMap.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        serachBarMap.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(serachBarMap.text!) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                
                let placemark = placemarks?.first
                
                let anno = MKPointAnnotation()
                anno.coordinate = (placemark?.location?.coordinate)!
                anno.title = self.serachBarMap.text!
                
                let span = MKCoordinateSpanMake(0.075, 0.075)
                let region = MKCoordinateRegion(center: anno.coordinate, span: span)
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(anno)
                self.mapView.selectAnnotation(anno, animated: true)
                
                
                
            }else{
                print(error?.localizedDescription ?? "error")
            }
            
            
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
    @IBAction func doneButtonPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
