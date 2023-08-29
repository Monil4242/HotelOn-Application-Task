//
//  AddListVc.swift
//  Cardog
//
//  Created by Arpit Thummar on 26/08/23.
//

import UIKit

protocol AddListVcDelegate: AnyObject {
    func passMyList(with list: MyList)
    func setButtonState()
}

class AddListVc: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var descriptionTextFeild: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    private var myList: MyList!
    private let datePicker = UIDatePicker()
    var titleText = String()
    var descriptionText = String()
    var date = String()
    var buttonTitle: Bool = false
    var image = UIImage()
    var index = -1
    
    weak var delegate: AddListVcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupDatePicker()
    }
    
    private func setUp() {
        addButton.layer.cornerRadius = 8
        addButton.layer.borderWidth = 1.4
        addButton.layer.masksToBounds = true
        
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 1.4
        cancelButton.layer.masksToBounds = true
        
        addImageButton.layer.cornerRadius = 6
        addImageButton.layer.borderWidth = 1.5
        addImageButton.layer.masksToBounds = true
        
        activityIndicator.style = .large
        activityIndicator.isHidden = true
        
        [titleTextField, descriptionTextFeild, dateTextField].forEach { textFields in
            textFields?.delegate = self
        }
        
        dateTextField.keyboardType = .numbersAndPunctuation
        
        if buttonTitle {
            addButton.setTitle("Edit", for: .normal)
            addImageButton.layer.borderWidth = 0
            addImageButton.setTitleColor(.white, for: .normal)
            addImageButton.setTitle("Select New Image", for: .normal)
            selectedImageView.image = image
            titleTextField.text = titleText
            descriptionTextFeild.text = descriptionText
            dateTextField.text = date
        } else {
            addButton.setTitle("Add", for: .normal)
        }
    }
    
    
    private func getImageFromPhotos() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func getImageFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func setImagePicker() {
        let alert = UIAlertController(title: "Select Image", message: "You can select image with photos or camera.", preferredStyle: .alert)
        let photosButton = UIAlertAction(title: "Photos", style: .default) {_ in
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.getImageFromPhotos()
        }
        
        let cameraButton = UIAlertAction(title: "Camera", style: .default) {_ in
            self.getImageFromPhotos()
        }
        
        alert.addAction(photosButton)
        alert.addAction(cameraButton)
        present(alert, animated: true)
    }
    
    private func displayAlert() {
        let alert = UIAlertController(title: "Opps..!", message: "Please fill all list data", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { [self]_ in
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive) {[self] _ in
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    private func checkListData() {
        if selectedImageView == nil {
            displayAlert()
            
        } else if titleTextField.text == "" {
            displayAlert()
            
        } else if descriptionTextFeild.text == "" {
            displayAlert()
            
        } else if dateTextField.text == ""  {
            displayAlert()
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true) { [self] in
                    myList = MyList(image: selectedImageView.image!, title: titleText, dedscription: descriptionText, date: date, index: index)
                    print(titleText)
                    delegate?.passMyList(with: myList)
                    activityIndicator.stopAnimating()
                    activityIndicator.isHidden = true
                }
            }
        }
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelClicked() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
        setImagePicker()
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        checkListData()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.setButtonState()
    }
}

extension AddListVc: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case titleTextField:
            titleText = ""
            
        case descriptionTextFeild:
            descriptionText = ""
            
        case dateTextField:
            date = ""
            
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
            
        case titleTextField:
            if let text = textField.text {
                titleText = text
            }
            
        case descriptionTextFeild:
            if let text = textField.text {
                descriptionText = text
            }
            
        case dateTextField:
            if let text = textField.text {
                date = text
            }
            
        default:
            break
        }
    }
}

extension AddListVc: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        if let selectedImage = info[.originalImage] as? UIImage {
            selectedImageView.image = selectedImage
            addImageButton.layer.borderWidth = 0
            addImageButton.layer.borderColor = UIColor.clear.cgColor
            addImageButton.setTitleColor(.white, for: .normal)
            addImageButton.setTitle("Select New Image", for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
}
