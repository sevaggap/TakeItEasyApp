//
//  MusicViewController.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-09.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mainMusicLabel: UILabel!
    @IBOutlet weak var mainMusicImage: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playPause: UIImageView!
    var playBool = false
    var uCell : MusicCollectionViewCell?
    var musicList = ["City Lights", "Sky", "Hawaii", "Enchante", "Sun is Shining"]
    var Audio : AVAudioPlayer?
    var timer : Timer?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        
        cell.musicImage.image = UIImage(imageLiteralResourceName: musicList[indexPath.row])
        
        cell.musicImage.layer.shadowColor = UIColor.black.cgColor
        cell.musicImage.layer.shadowOpacity = 1.0
        cell.musicImage.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        cell.musicImage.layer.shadowRadius = 2.0
        
        cell.musicImage.layer.masksToBounds = false
        cell.musicImage.layer.cornerRadius = 20
        cell.musicImage.contentMode = .scaleAspectFill
        cell.animationDelay = Double(indexPath.row)
        cell.musicLabel.text! = musicList[indexPath.row]
        cell.animateCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        
        Audio?.stop()
        
        Audio?.currentTime = 0
        
        Audio?.stop()
        
        playBool = true
        playback()
        playPause.image = UIImage(systemName: "pause.fill")
        
        
        
        //print (cell.musicLabel.text!)
//        mainMusicImage.image = UIImage(imageLiteralResourceName: musicList[indexPath.row])
//        mainMusicLabel.text! = musicList[indexPath.row]
//        UIView.animate(withDuration: 1, animations: {
//            self.mainMusicImage.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
//        }, completion: {
//            _ in
//            UIView.animate(withDuration: 1, animations: {
//                self.mainMusicImage.transform = .identity
//            }, completion: nil)
//
//        })
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.mainMusicImage.transform = CGAffineTransform(scaleX: -0.01, y: 1.0)
        }, completion: {
            _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.mainMusicImage.image = UIImage(imageLiteralResourceName: self.musicList[indexPath.row])
                self.mainMusicImage.transform = .identity
            }, completion: nil)

        })
        
    }
    
    func setMusic(song : URL) {
        do{
            try Audio = try AVAudioPlayer(contentsOf: song)
           
        }
        catch{
            print ("Audio Player Error")
        }
        
    
    }
    
    @IBAction func playPauseAction(_ sender: Any) {
       playback()
    }
    
    func playback(){
        if (playBool == true)
        {
           playPause.image = UIImage(systemName: "play.fill")
            playBool = false
            Audio?.stop()
        }
        else if (playBool == false)
        {
            playPause.image = UIImage(systemName: "pause.fill")
            playBool = true
            Audio?.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressCheck), userInfo:nil, repeats: true)
        }
        
    }
    
    @objc func progressCheck(){
        progressBar.progress = Float(Audio!.currentTime/Audio!.duration)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMusicImage.isUserInteractionEnabled = true
        playPause.isUserInteractionEnabled = true
        
        mainMusicImage.layer.shadowColor = UIColor.black.cgColor
        mainMusicImage.layer.shadowOpacity = 1.0
        mainMusicImage.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        mainMusicImage.layer.shadowRadius = 2.0
        
        mainMusicImage.layer.masksToBounds = false
        mainMusicImage.layer.cornerRadius = 20
        
        mainMusicLabel.text! = "City Lights"
        
        var filePath = Bundle.main.path(forResource: "Someday", ofType: "mp3")!
        
        setMusic(song: URL(fileURLWithPath: filePath))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
