//
//  NewEatNoteController.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/27.
//

import UIKit

class NewEatNoteController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var NameTextField: RoundedTextField!{
        didSet{
            NameTextField.tag = 1
            NameTextField.becomeFirstResponder()
            NameTextField.delegate = self
        }
    }
    
    @IBOutlet var TypeTextField: RoundedTextField!{
        didSet{
            TypeTextField.tag = 2
            TypeTextField.delegate = self
        }
    }
    
    @IBOutlet var PhoneTextField: RoundedTextField!{
        didSet{
            PhoneTextField.tag = 3
            PhoneTextField.delegate = self
        }
    }
    
    @IBOutlet var LocationTextField: RoundedTextField!{
        didSet{
            LocationTextField.tag = 4
            LocationTextField.delegate = self
        }
    }
    
    @IBOutlet var AddressTextField: RoundedTextField!{
        didSet{
            AddressTextField.tag = 5
            AddressTextField.delegate = self
        }
    }
    
    @IBOutlet var DescriptionTextView: UITextView!{
        didSet{
            DescriptionTextView.tag = 6
            DescriptionTextView.layer.cornerRadius = 5.0
            DescriptionTextView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Configure navigation bar appearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Helvetica Neue Medium", size: 35.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont ]
        }
        
        // Disable the separator
        tableView.separatorStyle = .none

    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    
    // MARK: - UITableViewDelegate methods
    
    // Camera && Photo library
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            // Camera
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                (action)in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            // Photo Library
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            // Cancel
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true

        let trailingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)

    }
    
    // MARK: - Action method
    
    @IBAction func saveButtonTapped(sender: AnyObject){
        
        if NameTextField.text == ""{
            let alertController = UIAlertController(title: "Oops", message: " We can't proceed beacause your Name filed is blank", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        print("Name: \(NameTextField.text ?? "")")
        print("Type: \(TypeTextField.text ?? "")")
        print("Location: \(LocationTextField.text ?? "")")
        print("Address: \(AddressTextField.text ?? "")")
       
        print("Phone: \(PhoneTextField.text ?? "")")
        print("Description: \(DescriptionTextView.text ?? "")")
        
        dismiss(animated: true, completion: nil)
    }

}
