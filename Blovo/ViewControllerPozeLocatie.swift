//
//  ViewControllerPozeLocatie.swift
//  Blovo
//
//  Created by user215931 on 5/8/22.
//

import UIKit

class PozeLocatieCell: UICollectionViewCell{
    @IBOutlet weak var locatieImageView: UIImageView!
    
}

class ViewControllerPozeLocatie: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Poze Locatie"
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    let pozeLocatie = ["poza1", "poza2", "poza3", "poza4", "poza5", "poza6", ]
    
}

extension ViewControllerPozeLocatie: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! PozeLocatieCell
        
        cell.locatieImageView.image = UIImage(named: pozeLocatie[indexPath.row])
        
        return cell
    }
    
}


