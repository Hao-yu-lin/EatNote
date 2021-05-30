//
//  EatNoteDetailViewController.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/24.
//

import UIKit
import MapKit

class EatNoteDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: EatNoteDetailHeaderView!
    
    //var eatnote = EatNote()
    var eatnote: EatNoteModel!

    // MARK: - phone call & navigation
    
    // phone call
   

    @IBAction func phonecall(sender: UIButton){
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)

        // Add Call action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            if let phoneURL = URL(string: "tel:\(self.eatnote.phone)"){
                if UIApplication.shared.canOpenURL(phoneURL){
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                }else{
                    let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, something error. Please retry later.", preferredStyle: .alert)
                    alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertMessage, animated: true, completion: nil)
                }
            }
        }
        
        
        
        let callAction = UIAlertAction(title: "Call : " + eatnote.phone! ,style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        let shareAction = UIAlertAction(title: "Share phone number", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let defaultText = self.eatnote.name! + ":" + self.eatnote.phone!
            
            let activityController: UIActivityViewController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
       
        optionMenu.addAction(shareAction)
       
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)

        
    }
    
    
    // navigation

    @IBAction func navigationMapApp(sender: UIButton) {
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
    
    
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        headerView.typeLabel.text = eatnote.type
//        headerView.headerImageView.image = UIImage(named: eatnote.name)
        if let eatnotImage = eatnote.image{
            headerView.headerImageView.image = UIImage(data: eatnotImage as Data)
        }
        
        headerView.checkImageView.isHidden = (eatnote.isVisited) ? false : true
        
        
        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        
        
        // Configure the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 68, green: 86, blue: 245)
       
        tableView.contentInsetAdjustmentBehavior = .always
        
        // Display rating
        if let rating = eatnote.rating {
            headerView.ratingImageView.image = UIImage(named: rating)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // cell control
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailNameCell.self), for: indexPath) as! EatNoteDetailNameCell
            cell.nameTextLabel.text = eatnote.name
            cell.selectionStyle = .none
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailPhoneCell.self), for: indexPath) as! EatNoteDetailPhoneCell
            cell.iconImageView.image = UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = eatnote.phone
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailIAddressCell.self), for: indexPath) as! EatNoteDetailIAddressCell
            cell.iconImageView.image = UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = eatnote.location! + eatnote.address!
            cell.selectionStyle = .none
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailTextCell.self), for: indexPath) as! EatNoteDetailTextCell
            cell.commentLabel.text = eatnote.comment
            cell.selectionStyle = .none
            
            return cell
            
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailMapCell.self), for: indexPath) as! EatNoteDetailMapCell
            
//            cell.configure(location: eatnote.location + eatnote.address)
            if let eatnoteLocation = eatnote.location{
                if let eatnoteAddress = eatnote.address{
                    cell.configure(location: eatnoteLocation + eatnoteAddress)
                }
            }
            
            return cell
        
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRate" {
            let destinationController = segue.destination as! RateViewController
            destinationController.eatnote = eatnote
        }
        
        if segue.identifier == "showMap"{
            let destinationController = segue.destination as! MapViewController
            destinationController.eatnote = eatnote
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func rateEatNote(segue: UIStoryboardSegue){
        dismiss(animated: true, completion: {
            if let rating = segue.identifier {
                self.eatnote.rating = rating

                self.headerView.ratingImageView.image = UIImage(named: rating)
                
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                    appDelegate.saveContext()
                }
                
                let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                self.headerView.ratingImageView.transform = scaleTransform
                self.headerView.ratingImageView.alpha = 0
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
                    self.headerView.ratingImageView.transform = .identity
                    self.headerView.ratingImageView.alpha = 1
                }, completion: nil)
            }
        })
    }
    


}
