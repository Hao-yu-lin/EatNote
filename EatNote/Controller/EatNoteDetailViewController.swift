//
//  EatNoteDetailViewController.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/24.
//

import UIKit

class EatNoteDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: EatNoteDetailHeaderView!
    @IBAction func phonecall(sender: UIButton){
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        present(optionMenu, animated: true, completion: nil)
        
        
        
    }
    
    var eatnote = EatNote()
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        headerView.typeLabel.text = eatnote.type
        headerView.headerImageView.image = UIImage(named: eatnote.name)
        headerView.checkImageView.isHidden = (eatnote.isVisited) ? false : true
        
        
        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        // Configure the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(red: 68, green: 86, blue: 245)
        tableView.contentInsetAdjustmentBehavior = .always
        
        // tap gesture
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
        return 6
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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailIconTextCell.self), for: indexPath) as! EatNoteDetailIconTextCell
            cell.iconImageView.image = UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = eatnote.location + eatnote.address
            cell.selectionStyle = .none
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailTextCell.self), for: indexPath) as! EatNoteDetailTextCell
            cell.descriptionLabel.text = eatnote.description
            cell.selectionStyle = .none
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailSeparatorCell.self), for: indexPath) as! EatNoteDetailSeparatorCell
            cell.titleLabel.text = "HOW TO GET HERE"
            cell.selectionStyle = .none
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EatNoteDetailMapCell.self), for: indexPath) as! EatNoteDetailMapCell
            //let addr = eatnote.location + eatnote.address
            cell.configure(location: eatnote.location + eatnote.address)
            
            
            return cell
        
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    



}
