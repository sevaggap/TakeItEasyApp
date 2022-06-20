//
//  MusicPlayer.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-16.
//

import Foundation
import AVFoundation


extension MusicViewController{
    
    func setMusicAV(musicUrl : URL){
        playerItem = AVPlayerItem(url: musicUrl)
        player = AVPlayer(playerItem: playerItem)
       
    }
}
