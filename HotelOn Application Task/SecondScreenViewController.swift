//
//  SecondScreenViewController.swift
//  HotelOn Application Task
//
//  Created by monil sojitra on 28/08/23.
//

import UIKit
protocol AddListVcDelegate: AnyObject {
    func passMyList(with list: MyList)
    func setButtonState()
}

class SecondScreenViewController: UIViewController {

    @IBOutlet weak var SelectImageView: UIImageView!
    
    @IBOutlet weak var HotelNameTextField: UITextField!
    
    @IBOutlet weak var HotelOwnerNameTextField: UITextField!
    
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBOutlet weak var SelectButtonOutlet: UIButton!
    
    @IBOutlet weak var AddButtonOt: UIButton!
    
    @IBOutlet weak var cancelButtonOt: UIButton!
    
    @IBOutlet weak var locationTextField: UITextField!
    private var myList: MyList!
    var name = String()
    var ownername = String()
    var typehotel = String()
    var location = String()
    var buttonTitle: Bool = false
    var image1 = UIImage()
    var index = -1
    
    weak var delegate: AddListVcDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadius()
  

    }
    func cornerRadius(){

        AddButtonOt.layer.cornerRadius = 8
        AddButtonOt.layer.borderWidth = 2
        AddButtonOt.layer.masksToBounds = true
        cancelButtonOt.layer.cornerRadius = 8
        cancelButtonOt.layer.borderWidth = 1.4
        cancelButtonOt.layer.masksToBounds = true
        
        SelectButtonOutlet.layer.cornerRadius = 6
        SelectButtonOutlet.layer.borderWidth = 1.5
        SelectButtonOutlet.layer.masksToBounds = true
        
        [HotelNameTextField, HotelOwnerNameTextField, typeTextField,locationTextField].forEach { textFields in
            textFields?.delegate = self
        }
        
        
        if buttonTitle {
            AddButtonOt.setTitle("Edit", for: .normal)
            SelectButtonOutlet.layer.borderWidth = 0
            SelectButtonOutlet.setTitleColor(.white, for: .normal)
            SelectButtonOutlet.setTitle("Select New Image", for: .normal)
            SelectImageView.image = image1
            HotelNameTextField.text = name
            HotelOwnerNameTextField.text = ownername
            typeTextField.text = typehotel
            locationTextField.text = location
        } else {
            AddButtonOt.setTitle("Add", for: .normal)
        }
    }
    private func getImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func getImageCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func setImagePicker() {
        let alert = UIAlertController(title: "Select Image", message: "You can select image with photos or camera.", preferredStyle: .alert)
        let photosButton = UIAlertAction(title: "Photos", style: .default) {_ in
            self.getImage()
        }

        let cameraButton = UIAlertAction(title: "Camera", style: .default) {_ in
            self.getImage()
        }
        
        alert.addAction(photosButton)
        alert.addAction(cameraButton)
        present(alert, animated: true)
    }
    
    private func Alert() {
        let alert = UIAlertController(title: "Please Enter Detailes.", message: "Please fill all list data", preferredStyle: .alert)
        UIAlertAction(title: "Ok", style: .default)
        UIAlertAction(title: "Cancel", style: .destructive)
        present(alert, animated: true)
        
    }
    

    @IBAction func SelectImageButtonAction(_ sender: Any) {
        setImagePicker()
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        check()
    }
   
    @IBAction func cancelButtonACtion(_ sender: Any) {
        dismiss(animated: true)
        delegate?.setButtonState()
    }
    private func check() {
        if SelectImageView == nil {
            Alert()
            
        } else if HotelNameTextField.text == "" {
            Alert()
            
        } else if HotelOwnerNameTextField.text == "" {
            Alert()
            
        } else if typeTextField.text == ""  {
            Alert()
            
        }
        else if locationTextField.text == ""  {
            Alert()
            
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true) { [self] in
                    myList = MyList(image: SelectImageView.image!, title: name, dedscription: ownername,type: typehotel,location: location,index: index)
                    print(name)
                    delegate?.passMyList(with: myList)
                }
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension SecondScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
      
        
        if let selectedImage = info[.originalImage] as? UIImage {
            SelectImageView.image = selectedImage
            SelectButtonOutlet.layer.borderWidth = 0
            SelectButtonOutlet.layer.borderColor = UIColor.clear.cgColor
            SelectButtonOutlet.setTitleColor(.white, for: .normal)
            SelectButtonOutlet.setTitle("Select New Image", for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension SecondScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case HotelNameTextField:
            name = ""
            
        case HotelOwnerNameTextField:
            ownername = ""
            
        case typeTextField:
            typehotel = ""
            
        case locationTextField:
            location = ""
            
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
            
        case HotelNameTextField:
            if let text = textField.text {
                name = text
            }
            
        case HotelOwnerNameTextField:
            if let text = textField.text {
                ownername = text
            }
            
        case typeTextField:
            if let text = textField.text {
                typehotel = text
            }
        case locationTextField:
            if let text = textField.text {
                location = text
            }
            
        default:
            break
        }
    }
}
