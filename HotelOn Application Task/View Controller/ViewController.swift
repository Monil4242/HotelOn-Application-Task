//
//  ViewController.swift
//  HotelOn Application
//
//  Created by monil sojitra on 27/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    var time = Timer()
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var getStartedoutlet: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        progressBar.isHidden = true
        detailLabel.isHidden = true
        cornerRadius()
       
    }
    func progress(){
        var a : Float = 0.0
        self.progressBar.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { _ in
            a += 0.01
            self.progressBar.progress = a
            if self.progressBar.progress == 1.0{
                self.progressBar.progress = 0.0
                self.navigate()
                self.time.invalidate()
            }
        })
    }
    func cornerRadius(){
        getStartedoutlet.layer.borderColor = UIColor.black.cgColor
        getStartedoutlet.layer.borderWidth = 2
        getStartedoutlet.layer.cornerRadius = 5
        getStartedoutlet.layer.masksToBounds = true
    }
    func navigate(){
        let n = storyboard?.instantiateViewController(withIdentifier: "FirstScreenViewController") as! FirstScreenViewController
        navigationController?.pushViewController(n, animated: true)
    }

    @IBAction func getStartedButtonAction(_ sender: Any) {
        progressBar.isHidden = false
        detailLabel.isHidden = false
        progress()
    }
    
}

