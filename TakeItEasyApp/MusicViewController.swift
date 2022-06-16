//
//  MusicViewController.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-09.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var animateImageView: UIImageView!
    
    @IBOutlet weak var mainMusicLabel: UILabel!
    @IBOutlet weak var mainMusicImage: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playPause: UIImageView!
    
    
    
    var playBool = false
    var uCell : MusicCollectionViewCell?
    var musicList = ["Deezer", "Sky", "Hawaii", "Enchante", "Sun is Shining"]
    var Audio : AVAudioPlayer?
    var timer : Timer?
    var mModel : MusicModel?
    
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
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
       
        var cell2 = collectionView.cellForItem(at: indexPath) as! MusicCollectionViewCell
        cell2.animationDelay = 0.5
        cell2.animateCell()
//        cell2.dest_y = mainMusicImage.center.y
//        cell2.dest_x = mainMusicImage.center.x
//        animateCellImg(cell_x: cell2.center.x, cell_y: collectionView.center.y, musLbl: cell2.musicLabel.text!)
    }
    
//    func animateCellImg(cell_x : Double, cell_y : Double, musLbl : String){
//        animateImageView.image = UIImage(imageLiteralResourceName: musLbl)
//        animateImageView.center.x = cell_x
//        animateImageView.center.y = cell_y
//
//        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn, animations: {
//            self.animateImageView.center.x = self.mainMusicImage.center.x
//            self.animateImageView.center.y = self.mainMusicImage.center.y
//        }, completion: nil)
//
//       // animateImageView.
//
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        
        player?.pause()
        
        var t = CMTime.zero
        player?.seek(to: t)
        
        player?.play()
        
        playBool = true
        
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
        cell.animationDelay = 2.0
        cell.animateCell()
        
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
    
    
    
    @IBAction func playPauseAction(_ sender: Any) {
       playback()
    }
    
    func playback(){
        if (playBool == true)
        {
           playPause.image = UIImage(systemName: "play.fill")
            playBool = false
            player?.pause()
        }
        else if (playBool == false)
        {
            playPause.image = UIImage(systemName: "pause.fill")
            playBool = true
            player?.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressCheck), userInfo:nil, repeats: true)
        }
        
    }
    
    @objc func progressCheck(){
      //  progressBar.progress = Float(Audio!.currentTime/Audio!.duration)
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMusicImage.isUserInteractionEnabled = true
        playPause.isUserInteractionEnabled = true
        mainMusicImage.image = UIImage(imageLiteralResourceName: "Deezer")
        mainMusicImage.layer.shadowColor = UIColor.black.cgColor
        mainMusicImage.layer.shadowOpacity = 1.0
        mainMusicImage.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        mainMusicImage.layer.shadowRadius = 2.0
        
        mainMusicImage.layer.masksToBounds = false
        mainMusicImage.layer.cornerRadius = 20
        
        mainMusicLabel.text! = "Deezer"
        
        var mUrl = URL(string: "https://api.deezer.com/track/3135556")!
        playPause.image = UIImage(systemName: "pause.fill")
        getData(url: mUrl, completion: { result in
            switch result{
            case .failure(let error):
                print("sw", error)
            case .success(let res):
                self.mModel = res
                print()
                let sURL = URL(string: self.mModel!.preview)
                self.setMusicAV(musicUrl: sURL!)
        }
        
        })
        
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkUpdates), userInfo: nil, repeats: true)
        
        //let sUrl = URL(string: musicData!.preview)
       
        
        //
        
        //setMusic(song: URL(fileURLWithPath: filePath))
        // Do any additional setup after loading the view.
    }
    
    @objc func checkUpdates(){
        if (mModel != nil)
        {
            mainMusicLabel.text = mModel?.title
        }
            
    }
    
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


