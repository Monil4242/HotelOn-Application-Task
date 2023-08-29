//
//  FirstScreenViewController.swift
//  HotelOn Application
//
//  Created by monil sojitra on 27/08/23.
//

import UIKit


class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var addPopUp: UIView!
    
    @IBOutlet weak var tb: UITableView!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    private var dataOfLists: [MyList] = []
    private var myList: MyList!
    private var indexPath: IndexPath!
    private var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        addPopUp.layer.cornerRadius = 30.5
        addPopUp.layer.shadowColor = UIColor.gray.cgColor
        addPopUp.layer.shadowOpacity = 4.4
        addPopUp.layer.shadowRadius = 6.0
        cell()

        
    }
     func cell() {
        
        tb.register(UINib(nibName: "StartUpTableViewCell", bundle: nil), forCellReuseIdentifier: "StartUpTableViewCell")
        tb.delegate = self
        tb.dataSource = self
        tb.showsVerticalScrollIndicator = false
        tb.separatorStyle = .none
    }
     func Alert(with index: IndexPath) {
        let alert = UIAlertController(title: "Are you sure", message: "You want to remove this list", preferredStyle: .alert)
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            dataOfLists.remove(at: index.row)
            tb.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
//         UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
//             dataOfLists.remove(at: indexPath.row)
//             tb.reloadData()
//         }
//         UIAlertAction(title: "Cancel", style: .default)
        present(alert, animated: true)
    }
   
    
    
    @IBAction func addButtonAction(_ sender: Any) {
        let add = storyboard?.instantiateViewController(withIdentifier: "SecondScreenViewController") as! SecondScreenViewController
        add.delegate = self
        addPopUp.isHidden = true
        present(add, animated: true)
    }
   
    
}
extension FirstScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOfLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StartUpTableViewCell") as! StartUpTableViewCell
        let arr = dataOfLists[indexPath.row]
        cell.img.image = arr.image
        cell.TitleLabel.text = arr.title
        cell.subLabel.text = arr.dedscription
        cell.dotButton.tag = indexPath.row
        cell.indexPath = indexPath
        cell.delegate = self
        self.indexPath = indexPath
        return cell
    }
    
       
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Alert(with: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let add = storyboard?.instantiateViewController(withIdentifier: "SecondScreenViewController") as! SecondScreenViewController
        addPopUp.isHidden = true
        add.buttonTitle = true
        add.delegate = self
        add.image1 = dataOfLists[indexPath.row].image
        add.name = dataOfLists[indexPath.row].title
        add.ownername = dataOfLists[indexPath.row].dedscription
        add.typehotel = dataOfLists[indexPath.row].type
        add.location = dataOfLists[indexPath.row].location
        add.index = indexPath.row
        self.indexPath = indexPath
        present(add, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
extension FirstScreenViewController: AddListVcDelegate {
    func passMyList(with list: MyList) {
        addPopUp.isHidden = false
        img.isHidden = true
        label.isHidden = true
        
        if dataOfLists.isEmpty {
            dataOfLists.append(list)
            tb.reloadData()
        } else {
            if list.index == indexPath.row {
                dataOfLists[indexPath.row] = list
                tb.reloadData()
            } else {
                dataOfLists.append(list)
                tb.reloadData()
            }
        }
    }

    func setButtonState() {
        addPopUp.isHidden = false
    }
}

extension FirstScreenViewController: AddListTableViewCellDelegate {
    func editlist(with index: IndexPath) {
        let addListVc = storyboard?.instantiateViewController(withIdentifier: "SecondScreenViewController") as! SecondScreenViewController
        addPopUp.isHidden = true
        addListVc.buttonTitle = true
        addListVc.delegate = self
        addListVc.image1 = dataOfLists[index.row].image
        addListVc.name = dataOfLists[index.row].title
        addListVc.ownername = dataOfLists[index.row].dedscription
        addListVc.typehotel = dataOfLists[index.row].type
        addListVc.location = dataOfLists[index.row].location
        addListVc.index = index.row
        self.indexPath = index
        present(addListVc, animated: true)
    }
    
    func deleteList(with index: IndexPath) {
       Alert(with: index)
    }
}


