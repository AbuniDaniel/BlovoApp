//
//  ViewControllerLocatie.swift
//  Blovo
//
//  Created by user215931 on 5/8/22.
//


import UIKit
import MapKit
import CoreLocation

class ViewControllerLocatie: UIViewController, MKMapViewDelegate{
    
    let map = MKMapView()
    let coordinate = CLLocationCoordinate2D(latitude: 44.4196, longitude: 26.1371)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locatie"
        view.addSubview(map)
        map.frame = view.bounds
        
        map.setRegion(MKCoordinateRegion(center: coordinate,
                                         span: MKCoordinateSpan(
                                            latitudeDelta: 0.1,
                                            longitudeDelta: 0.1)),
                      animated: false)
        map.delegate = self
        
        addCustomPin()
    }
    
    private func addCustomPin(){
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "McDonald's"
        pin.subtitle = "Aici este locatia"
        map.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "logo_locatie")
        
        return annotationView
    }
}

