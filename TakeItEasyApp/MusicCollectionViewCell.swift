//
//  MusicCollectionViewCell.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-09.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicLabel: UILabel!
    var animationDelay: Double?
    
    func animateCell()
    {
        animationDelay! /= 2
        UIView.animate(withDuration: 0.5, delay: animationDelay!, options: .curveEaseOut, animations: {
            self.musicImage.center.y -= 50
        }, completion: {_ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.musicImage.center.y += 50
            }, completion: nil)
        })
    }
}
