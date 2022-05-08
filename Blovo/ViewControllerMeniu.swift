//
//  ViewControllerMeniu.swift
//  Blovo
//
//  Created by user215931 on 5/8/22.
//

import UIKit

struct Meniu {
    var nume: String
    var pret: String
    var imaginee: String
}

class MeniuTableViewCell: UITableViewCell {
    @IBOutlet weak var numeLabel: UILabel!
    @IBOutlet weak var pretLabel: UILabel!
    @IBOutlet weak var imagineView: UIImageView!
    
}


class ViewControllerMeniu: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Meniu"
        configure()
    }
    
    func configure(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    let produse = [
        Meniu(nume: "Hamburger", pret: "4.70 LEI", imaginee: "Hamburger"),
        Meniu(nume: "Cheeseburger", pret: "4.90 LEI", imaginee: "Cheeseburger"),
        Meniu(nume: "Big Mac", pret: "11,00 LEI", imaginee: "Big_Mac"),
        Meniu(nume: "Big Tasty", pret: "18,30 LEI", imaginee: "Big_Tasty"),
    ]
    
}

extension ViewControllerMeniu: UITableViewDataSource, UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! MeniuTableViewCell

        let meniu = self.produse[indexPath.row]
        cell.numeLabel?.text = meniu.nume
        cell.pretLabel?.text = meniu.pret
        cell.imagineView?.image = UIImage(named: meniu.imaginee)

        return cell
    }
    
}
