//
//  RouteListViewController.swift
//  RouteContextApp
//
//  Created by Tomas Martins on 12/09/2018.
//  Copyright © 2018 Tomas Martins. All rights reserved.
//

import UIKit
import MapKit

class RouteListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {

    let routes = ["Casa -> Faculdade", "Faculdade -> Trabalho", "Faculdade -> Casa", "Trabalho -> Casa", "Loja de Departamento"]
    let srcLatitues: [CLLocationDegrees] = [-22.845782, -22.835810, -22.835810, -22.898136, -22.845782]
    let srcLongitudes: [CLLocationDegrees] = [-47.055265, -47.049598, -47.049598, -47.116035, -47.055265]
    let dstLatitudes: [CLLocationDegrees] = [-22.835810, -22.898136, -22.845782, -22.845782, -22.886686]
    let dstLongitudes: [CLLocationDegrees] = [-47.049598, -47.116035, -47.055265, -47.055265, -47.077154]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routeList", for: indexPath) as! RouteCollectionViewCell
        
        cell.routeNameLabel.text = routes[indexPath.row]
        
        if(indexPath.row != 4) {
            cell.sponsorLabel.alpha = 0
        } else {
            cell.sponsorLabel.alpha = 1
        }
        
        //vars for mapView on cell
        let sourceLocation = CLLocationCoordinate2D(latitude: srcLatitues[indexPath.row], longitude: srcLongitudes[indexPath.row])
        let destinationLocation = CLLocationCoordinate2D(latitude: dstLatitudes[indexPath.row], longitude: dstLongitudes[indexPath.row])
        //Sets source and destination Pins
        let sourcePin = customPin(pinTitle: "", pinSubtitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "", pinSubtitle: "", location: destinationLocation)
        //Display Pins on Map View
        cell.routeMapView.addAnnotation(sourcePin)
        cell.routeMapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        //Get directions from source to destiny
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("error getting directions == \(error)")
                }
                return
            }
            let route = directionResponse.routes[0]
            cell.routeMapView.add(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            cell.routeMapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: false)
            cell.routeMapView.isScrollEnabled = false
            cell.routeMapView.isZoomEnabled = false
            cell.routeMapView.isRotateEnabled = false
        }
        
        //Add shadow and set corner radius on cells
        cell.layer.cornerRadius = 20.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 3.0, height: 1.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routeList", for: indexPath) as! RouteCollectionViewCell
        let viewController = storyboard?.instantiateViewController(withIdentifier: "routeDetail") as! RouteInfoViewController
        viewController.navigationItem.title = routes[indexPath.row]
        viewController.dstLat = dstLatitudes[indexPath.row]
        viewController.dstLon = dstLongitudes[indexPath.row]
        viewController.srcLat = srcLatitues[indexPath.row]
        viewController.srcLon = srcLongitudes[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
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
