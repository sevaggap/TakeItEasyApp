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
        
        modeChange()
        
        mainMusicImage.isUserInteractionEnabled = true
        forward.isUserInteractionEnabled = true
        backward.isUserInteractionEnabled = true
        
        playPause.isUserInteractionEnabled = true
        mainMusicImage.image = UIImage(imageLiteralResourceName: "Deezer")
        
        var sView = UIView()
        setBorder(subView: sView, size: mainMusicImage.frame.size)
        mainMusicImage.addSubview(sView)
        mainMusicLabel.text! = "Deezer"
        
        playPause.image = UIImage(systemName: "pause.fill")
    
        
        circleImg.layer.shadowColor = custColor
        circleImg.layer.shadowOpacity = 1.0
        circleImg.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        circleImg.layer.shadowRadius = 2.0
        
        circleImage2.layer.shadowColor = custColor
        circleImage2.layer.shadowOpacity = 1.0
        circleImage2.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        circleImage2.layer.shadowRadius = 2.0
        
        circleImage3.layer.shadowColor = custColor
        circleImage3.layer.shadowOpacity = 1.0
        circleImage3.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        circleImage3.layer.shadowRadius = 2.0
    }
    func modeChange()
    {
        if traitCollection.userInterfaceStyle == .dark
        {
    imageViewBackground.image = UIImage(named: "TakeItEasyBackground-Dark")

    circleImg.tintColor = UIColor.systemIndigo
    circleImage2.tintColor = UIColor.systemIndigo
    circleImage3.tintColor = UIColor.systemIndigo
    playPause.tintColor = UIColor.white
    } else {
    imageViewBackground.image = UIImage(named: "TakeItEasyBackground")
    circleImg.tintColor = UIColor.white
    circleImage2.tintColor = UIColor.white
    circleImage3.tintColor = UIColor.white
    playPause.tintColor = UIColor.systemIndigo
    }
        
    }
}









