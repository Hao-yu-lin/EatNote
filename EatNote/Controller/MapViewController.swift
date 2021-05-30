//
//  MapViewController.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/30.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var eatnote: EatNoteModel!
    
    var selfLocation: CLLocationManager!

    @IBAction func navigation2MapApp(sender: UIButton) {
        var lat = String()
        var lon = String()
        
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(self.eatnote.location! + self.eatnote.address!, completionHandler: {(placemarks:[CLPlacemark]!,error:Error!) in
            if error != nil{
                print(error!)
                return
            }
            if placemarks != nil && placemarks.count > 0{
                let placemark = placemarks[0] as CLPlacemark
                lat = String(placemark.location?.coordinate.latitude ?? 0.0)
                lon = String(placemark.location?.coordinate.longitude ?? 0.0)
                print("\(lat),\(lon)")
            }
        })
        

        
        // google map
        let GoogleMapActionHandler = { (action:UIAlertAction!) -> Void in

        let url = URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(lon)&directionsmode=driving")
                
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                } else {
                    // 若手機沒安裝 Google Map App 則導到 App Store(id443904275 為 Google Map App 的 ID)
                    let appStoreGoogleMapURL = URL(string: "itms-apps://itunes.apple.com/app/id585027354")!
                    UIApplication.shared.open(appStoreGoogleMapURL, options: [:], completionHandler: nil)
                }

            
        }
        
        let GoogleMapAction = UIAlertAction(title: "Navigation : GoogleMap" ,style: .default, handler: GoogleMapActionHandler)
        optionMenu.addAction(GoogleMapAction)
        
        let AppleMapActionHandler = { (action: UIAlertAction!) -> Void in
           
            let AppleMapURL = URL(string: "http://maps.apple.com/?daddr=\(lat),\(lon)&dirflg=d")
                
                if UIApplication.shared.canOpenURL(AppleMapURL!){
                   
                    UIApplication.shared.open(AppleMapURL!, options: [:], completionHandler: nil)
                  
                }else{
                    // 若手機沒安裝 Apple Map App 則導到 App Store(id915056765 為 apple Map App 的 ID)
                    let appStoreGoogleMapURL = URL(string: "itms-apps://itunes.apple.com/app/id915056765")!
                   
                    UIApplication.shared.open(appStoreGoogleMapURL, options: [:], completionHandler: nil)
                 
                }
            
        }
        
        let AppleMapAction = UIAlertAction(title: "Navigation : AppleMap" ,style: .default, handler:AppleMapActionHandler)
        optionMenu.addAction(AppleMapAction)
        
        
        let shareAction = UIAlertAction(title: "Share Address", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            let defaultText = self.eatnote.name! + ":" + self.eatnote.location! + self.eatnote.address!
            
            let activityController: UIActivityViewController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
       
        optionMenu.addAction(shareAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get location
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(self.eatnote.location! + self.eatnote.address!, completionHandler: {placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks{
                // Get the first placemarks
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.eatnote.name
                
                if let location = placemark.location{
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                    
                }
            }
        })
        

        
        // Configure map view
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        mapView.showsUserLocation = true
        
        
        // self Location
        selfLocation = CLLocationManager()
        selfLocation.delegate = self
        selfLocation.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 開啟APP會詢問使用權限
        if CLLocationManager.authorizationStatus()  == .notDetermined {
            // 取得定位服務授權
            selfLocation.requestWhenInUseAuthorization()
            // 開始定位自身位置
            selfLocation.startUpdatingLocation()
        }
    }
    
    
    // store location
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphText = "🥰"
        annotationView?.markerTintColor = UIColor.orange
        
        

        
        return annotationView
    }
    
    
    // self location
    func locationManager(_ manager: CLLocationManager,
      didUpdateLocations locations: [CLLocation]) {
        //取得當下座標
        let currentLocation :CLLocation =
          locations[0] as CLLocation
        //總縮放範圍
        let range:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
     
        //自身0
        let myLocation = currentLocation.coordinate
        let appearRegion:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: range)
        
        //在地圖上顯示
        mapView.setRegion(appearRegion, animated: true)
    }
    
}
