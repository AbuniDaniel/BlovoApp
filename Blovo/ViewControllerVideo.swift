//
//  ViewControllerVideo.swift
//  Blovo
//
//  Created by user215931 on 5/7/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewControllerVideo: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Video"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "reclama glovo", ofType: "mp4")!))
        
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        player.play()
    }
    
}
