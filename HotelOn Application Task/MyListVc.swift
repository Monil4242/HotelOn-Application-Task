//
//  MyListVc.swift
//  Cardog
//
//  Created by Arpit Thummar on 26/08/23.
//

import UIKit

class MyListVc: UIViewController {
  
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    private var arrOfLists: [MyList] = []
    private var myList: MyList!
    private var indexPath: IndexPath!
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        addButton.layer.cornerRadius = 30
        addButton.layer.masksToBounds = true
        
        listTableView.register(UINib(nibName: "AddListTableViewCell", bundle: nil), forCellReuseIdentifier: "AddListTableViewCell")
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.showsVerticalScrollIndicator = false
        listTableView.separatorStyle = .none
    }
    
    private func displayAlert(with index: IndexPath) {
        let alert = UIAlertController(title: "Are you sure", message: "You want to remove this list", preferredStyle: .alert)
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            arrOfLists.remove(at: index.row)
            listTableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        present(alert, animated: true)
    }

    @IBAction func addButtonAction(_ sender: UIButton) {
        let addListVc = storyboard?.instantiateViewController(withIdentifier: "AddListVc") as! AddListVc      
        addListVc.delegate = self
        addButton.isHidden = true
        present(addListVc, animated: true)
    }
}
extension MyListVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddListTableViewCell") as! AddListTableViewCell
//        cell..image = arrOfLists[indexPath.row].image
//        cell..text = arrOfLists[indexPath.row].title
//        cell.dateLabel.text = arrOfLists[indexPath.row].date
//        cell.menuButton.tag = indexPath.row
//        cell.indexPath = indexPath
//        cell.delegate = self
//        self.indexPath = indexPath
        return cell
    }
    
       
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            displayAlert(with: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addListVc = storyboard?.instantiateViewController(withIdentifier: "AddListVc") as! AddListVc
        addButton.isHidden = true
        addListVc.buttonTitle = true
        addListVc.delegate = self
        addListVc.image = arrOfLists[indexPath.row].image
        addListVc.titleText = arrOfLists[indexPath.row].title
        addListVc.descriptionText = arrOfLists[indexPath.row].dedscription
        addListVc.date = arrOfLists[indexPath.row].date
        addListVc.index = indexPath.row
        self.indexPath = indexPath
        present(addListVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension MyListVc: AddListVcDelegate {
    func passMyList(with list: MyList) {
        addButton.isHidden = false
        emptyImageView.isHidden = true
        emptyLabel.isHidden = true
        
        if arrOfLists.isEmpty {
            arrOfLists.append(list)
            listTableView.reloadData()
        } else {
            if list.index == indexPath.row {
                arrOfLists[indexPath.row] = list
                listTableView.reloadData()
            } else {
                arrOfLists.append(list)
                listTableView.reloadData()
            }
        }
    }

    func setButtonState() {
        addButton.isHidden = false
    }
}

extension MyListVc: AddListTableViewCell {
    func editlist(with index: IndexPath) {
        let addListVc = storyboard?.instantiateViewController(withIdentifier: "AddListVc") as! AddListVc
        addButton.isHidden = true
        addListVc.buttonTitle = true
        addListVc.delegate = self
        addListVc.image = arrOfLists[index.row].image
        addListVc.titleText = arrOfLists[index.row].title
        addListVc.descriptionText = arrOfLists[index.row].dedscription
        addListVc.date = arrOfLists[index.row].date
        addListVc.index = index.row
        self.indexPath = index
        present(addListVc, animated: true)
    }
    
    func deleteList(with index: IndexPath) {
        displayAlert(with: index)
    }
}
