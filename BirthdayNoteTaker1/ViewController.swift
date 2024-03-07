
import UIKit

class ViewController: UIViewController {

    //Views
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //Variables
    var isImageFirst = true
    
    //--------------------------------------------- Methods ------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //if user saved a name and birthday, show it.
        nameLabel.text = "Name:\(UserDefaults.standard.object(forKey: "name") ?? "")"
        birthdayLabel.text = "Surname:\(UserDefaults.standard.object(forKey: "surname") ?? "")"
                
        //Tap gesture racognizer
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        imageView.addGestureRecognizer(tap)                                                           //ViewDidLoad
                
        //Hide keyboard
             let tap2 = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap2)
    }

    //----------------------------------------------------------------------------------------------------
    
    //"Both first name and surname text fields must be filled in "
    @IBAction func saveButton(_ sender: Any) {
        
        if(nameTextField.text! == "" && surnameTextField.text! == ""){
            
            alerts(title: "Ooops!", message: "You've to fill name and surname fields.")
            
        }else if(nameTextField.text! == ""){
            
            alerts(title: "Ooops!", message: "You've to fill name field.")                              //Save Button
            
        }else if(surnameTextField.text! == ""){
            
            alerts(title: "Ooops!", message: "You've to fill surname field.")
            
        }else{
    
            UserDefaults.standard.setValue(nameTextField.text!, forKey: "name")
            UserDefaults.standard.setValue(surnameTextField.text!, forKey: "surname")
            
            nameLabel.text = "Name: \(nameTextField.text!)"
            birthdayLabel.text = "Surname: \(surnameTextField.text!)"
        }
    }
   
    //------------------------------------------------------------------------------------------------------
    
    //I will use this method to show alert after click the save button
    func alerts(title: String, message: String){
        
        let emptyFieldAlert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
                    
        let okayButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                    
        emptyFieldAlert.addAction(okayButton)                                                             //Alerts
                    
        self.present(emptyFieldAlert, animated: true, completion: nil)
    }
    
    //------------------------------------------------------------------------------------------------------
    
    @objc func imageClicked(){
        if(isImageFirst == true){
            imageView.image = UIImage(named: "2.png")
            isImageFirst = false
                                                                                                          //Change image
        }else{
            imageView.image = UIImage(named: "1.png")
            isImageFirst = true
        }
    }
    
    //-----------------------------------------------------------------------------------------------------
    
    @objc func dismissKeyboard() {
                
        //Causes the view (or one of its embedded text fields) to resign the first responder status.        //Hide keyboard
        view.endEditing(true)
    }
    
    //------------------------------------------------------------------------------------------------------
    
    
    @IBAction func deleteButton(_ sender: Any) {
        
        
        if(nameLabel.text! == "Name:" || birthdayLabel.text! == "Birthday:"){

            //if it don't have saved name and birthday, show this alert
            alerts(title: "Ooops!", message: "You don't have any saved name")
            
        }else{
                        
            //if there is a saved name and birthday, show the attention message after click delete
            let deleteAlert = UIAlertController(title:"Attention!", message:"You clicked delet button,This action cannot be undone. Are you sure?", preferredStyle: UIAlertController.Style.alert)
            
            let deleteButton = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) { UIAlertAction in
                
                UserDefaults.standard.removeObject(forKey: "name")
                UserDefaults.standard.removeObject(forKey: "surname")
                
                self.nameLabel.text = "Name:"
                self.birthdayLabel.text = "Surname:"
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            deleteAlert.addAction(cancelButton)
            deleteAlert.addAction(deleteButton)
            
            self.present(deleteAlert, animated: true, completion: nil)
        }
        
    }
    
                          
}

