//
//  MusicListCollectionViewCell.swift
//  SimpleMusic
//
//  Created by Kirill Shteffen on 05/12/2018.
//  Copyright © 2018 BlackBricks. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBAction func play(_ sender: UIButton) {
        if !audioPlayer.isPlaying {
        audioPlayer.play()
        playButton.setImage(UIImage(named: "Stop"), for: .normal)
        } else {
            audioPlayer.stop()
            playButton.setImage(UIImage(named: "Play"), for: .normal)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabels()
        let path = Bundle.main.path(forResource: "[BB]guitarRiff", ofType: "wav")
        let trackURL = URL(fileURLWithPath: path ?? "")
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            audioPlayer = try? AVAudioPlayer(contentsOf: trackURL)
            
        }
        
    }
    
    func setLabels(){
        albumCover.image = UIImage(named: "AlbumCover")
        songName.text = "Californication"
        artistName.text = "RHCP"
    }
}
