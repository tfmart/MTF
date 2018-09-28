//
//  RouteInfoViewController.swift
//  RouteContextApp
//
//  Created by Tomas Martins on 11/09/2018.
//  Copyright © 2018 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit

class RouteInfoViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var MapKit: MKMapView!
    let locationManager = CLLocationManager()
    
    var srcLat: CLLocationDegrees?
    var srcLon: CLLocationDegrees?
    var dstLat: CLLocationDegrees?
    var dstLon: CLLocationDegrees?
    
    @IBOutlet weak var getCallButtonFrom: UIButton!
    @IBOutlet weak var playlistButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style the buttons
        getCallButtonFrom.layer.cornerRadius = 20.0
        playlistButton.layer.cornerRadius = 20.0
        sendMessageButton.layer.cornerRadius = 20.0
        
        let sourceLocation = CLLocationCoordinate2D(latitude: srcLat!, longitude: srcLon!)
        let destinationLocation = CLLocationCoordinate2D(latitude: dstLat!, longitude: dstLon!)
        
        let sourcePin = customPin(pinTitle: "Puc Campinas", pinSubtitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "Bosch Campinas", pinSubtitle: "", location: destinationLocation)
        
        self.MapKit.addAnnotation(sourcePin)
        self.MapKit.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("error getting directions == \(error)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.MapKit.add(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.MapKit.setRegion(MKCoordinateRegionForMapRect(rect), animated: false)
            self.MapKit.isZoomEnabled = false
            self.MapKit.isScrollEnabled = false
            self.MapKit.isRotateEnabled = false
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Sets different title for back button in next pushed view
        self.navigationItem.title = "Rota"
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

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubtitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = location
    }
}
