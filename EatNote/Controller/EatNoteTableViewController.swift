//
//  EatNoteTableViewController.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/23.
//

import UIKit

class EatNoteTableViewController: UITableViewController {
    
    // MARK: - Data source
    
    
    var EatNotes:[EatNote] = [
        EatNote(name: "咖啡嗜者", type: "咖啡", location: "台北市",address: "大安區雲和街72巷1號1樓", image: "咖啡嗜者", isVisited: false, phone: "0223675123", description: "A大師咖啡"),
        EatNote(name: "虎咖啡", type: "咖啡", location: "宜蘭縣",address:"宜蘭市國榮路104號", image: "虎咖啡", isVisited: false, phone: "039312104", description: "虎咖啡吃鬆餅 喝義式咖啡"),
        EatNote(name: "Mars coffee", type: "咖啡", location: "台北市",address: "文山區辛亥路四段235號", image: "Mars coffee", isVisited: false, phone: "0286638080", description: "大學回憶錄"),
        EatNote(name: "cafe sodavid", type: "咖啡", location: "宜蘭縣",address: "羅東鎮中華路255號", image: "cafe sodavid", isVisited: false, phone: "0920652053", description: "手沖很好喝，都是衣索比亞豆"),
        EatNote(name: "黑米", type: "餐點", location: "台北市",address: "文山區羅斯福路五段269巷16號", image: "黑米", isVisited: false, phone: "0286638008", description: "好吃的義大利麵店，需要訂位"),
        EatNote(name: "Terra", type: "甜點", location: "台北市",address: "大安區溫州街7號", image: "Terra", isVisited: false, phone: "0223636355", description: "巧克力專賣店"),
        EatNote(name: "吳一無二法式甜點", type: "甜點", location: "台北市",address: "大安區安和路二段184巷6號", image: "吳一無二法式甜點", isVisited: false, phone: "0227371707", description: "好吃的法式甜點"),
        EatNote(name: "TaSweet", type: "甜點", location: "宜蘭縣",address: "羅東鎮四維路10號", image: "TaSweet", isVisited: false, phone: "039565906", description: "羅東有名的蛋糕捲店"),
    ]

    
    
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set to use the large title of the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configure the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Helvetica Neue Medium", size: 40.0){
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont]
        }
        
        
        // hidebars
        navigationController?.hidesBarsOnSwipe = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections in tableView
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows in section
        return EatNotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteTableViewCell.self), for: indexPath) as! EatNoteTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = EatNotes[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: EatNotes[indexPath.row].image)
        cell.locationLabel.text = EatNotes[indexPath.row].location
        cell.typeLabel.text = EatNotes[indexPath.row].type
        cell.checkImageView.isHidden = !self.EatNotes[indexPath.row].isVisited
        
        return cell
    }
    
   


    
    // MARK: - Table view delegate
    
    //SwipeAction
    // Right to Left Action
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (action, sourceView, completionHandler) in
            
            self.EatNotes.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.EatNotes[indexPath.row].name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.EatNotes[indexPath.row].image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else  {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        // Customize the color
        deleteAction.backgroundColor = UIColor(red: 231, green: 76, blue: 60)
        deleteAction.image = UIImage(systemName: "trash")

        shareAction.backgroundColor = UIColor(red: 254, green: 149, blue: 38)
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    // Left to Right Action
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! EatNoteTableViewCell
            self.EatNotes[indexPath.row].isVisited = (self.EatNotes[indexPath.row].isVisited) ? false : true
            cell.checkImageView.isHidden = self.EatNotes[indexPath.row].isVisited ? false : true
            
            completionHandler(true)
        }
        
        let checkInIcon = EatNotes[indexPath.row].isVisited ? "arrow.uturn.left" : "checkmark"
        checkInAction.backgroundColor = UIColor(red: 38, green: 162, blue: 78)
        checkInAction.image = UIImage(systemName: checkInIcon)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        
        return swipeConfiguration
    }



    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEatNoteDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! EatNoteDetailViewController
                destinationController.eatnote = EatNotes[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    

}
