//
//  UIConfigMusic.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-16.
//

import Foundation
import UIKit

extension MusicViewController{
    func uiConfig(){
        
        mainMusicImage.isUserInteractionEnabled = true
        playPause.isUserInteractionEnabled = true
        mainMusicImage.image = UIImage(imageLiteralResourceName: "Deezer")
        
        
        mainMusicImage.layer.shadowColor = custColor
        mainMusicImage.layer.shadowOpacity = 1.0
        mainMusicImage.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        mainMusicImage.layer.shadowRadius = 2.0
        
        mainMusicImage.layer.masksToBounds = false
        mainMusicImage.layer.cornerRadius = 20
        
        mainMusicLabel.text! = "Deezer"
        
        playPause.image = UIImage(systemName: "pause.fill")
        playPause.tintColor = UIColor.systemIndigo
        
        circleImg.layer.shadowColor = custColor
        circleImg.layer.shadowOpacity = 1.0
        circleImg.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        circleImg.layer.shadowRadius = 2.0
    }
}
