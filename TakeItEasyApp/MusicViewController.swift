//
//  MusicViewController.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-09.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var circleImage3: UIImageView!
    @IBOutlet weak var circleImage2: UIImageView!
    @IBOutlet weak var circleImg: UIImageView!
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    var custColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var animateImageView: UIImageView!
    
    @IBOutlet weak var mainMusicLabel: UILabel!
    @IBOutlet weak var mainMusicImage: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playPause: UIImageView!
    
    @IBOutlet weak var forward: UIImageView!
    @IBOutlet weak var backward: UIImageView!
    
    var tileSelected : Int = 0
    var playBool = true
    var uCell : MusicCollectionViewCell?
    var musicList = ["Deezer", "Sky", "Hawaii", "Enchante", "Sun is Shining"]
    var Audio : AVAudioPlayer?
    var timer : Timer?
    var mModel : MusicModel?
    var sURL = URL(string:"Sky")
    var mUrl = URL(string: "https://api.deezer.com/track/3135556")!
    
    func viewDidLoad_TransparentNavBar() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = appearance
        }

//    func viewDidLoad_PopulateCurrentUserName() {
//            // TODO: - Uncomment the following two lines to populate user name in the nav bar
//            CurrentUser.user.updateCurrentUserName()
//            navItemUserName.title = CurrentUser.user.name
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDidLoad_TransparentNavBar()
        //viewDidLoad_PopulateCurrentUserName()
        uiConfig()
        
        
       
        getData(url: mUrl, completion: { result in
            switch result{
            case .failure(let error):
                print("sw", error)
            case .success(let res):
                self.mModel = res
                print()
                self.sURL = URL(string: self.mModel!.preview)
                self.setMusicAV(musicUrl: self.sURL!)
                
        }
        
        })
        playBool = false
        playback()
        
        var timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(checkUpdates), userInfo: nil, repeats: true)
        
        //let sUrl = URL(string: musicData!.preview)
       
        
        //
        
        //setMusic(song: URL(fileURLWithPath: filePath))
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        
        cell.musicImage.image = UIImage(imageLiteralResourceName: musicList[indexPath.row])
        cell.musicImage.layer.cornerRadius = cell.musicImage.frame.height/2
        let sView = UIView()
        setBorder(subView: sView, size: cell.musicImage.frame.size)
        cell.musicImage.addSubview(sView)
        cell.musicImage.layer.masksToBounds = true
        cell.musicImage.layer.masksToBounds = true
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
        tileSelected = indexPath.row
        player?.pause()
        
        var t = CMTime.zero
        player?.seek(to: t)
        
        changeSong()
        
        player?.play()
        
        playBool = true
        
        playPause.image = UIImage(systemName: "pause.fill")
        
        
        
        
        mainMusicLabel.text = musicList[tileSelected]
        mainAnimated()
        
        
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
        cell.animationDelay = 1.0
        cell.animateCell()
        
        
    }
    
    
    
    @IBAction func playPauseAction(_ sender: UITapGestureRecognizer) {
       playback()
        
    }
    
    @IBAction func nextAction(_ sender: UITapGestureRecognizer) {
        print("next action")
        if(tileSelected == musicList.count-1)
        {
            tileSelected = 0
        }
        else
        {
            tileSelected += 1
        }

        player?.pause()

        var t = CMTime.zero
        player?.seek(to: t)
        changeSong()
        player?.play()
        playBool = true
        playPause.image = UIImage(systemName: "pause.fill")
        mainMusicLabel.text = musicList[tileSelected]
        mainAnimated()
        
    }
    
    @IBAction func prevAction(_ sender: UITapGestureRecognizer) {
        if(tileSelected == 0)
        {
            tileSelected = musicList.count-1
        }
        else
        {
            tileSelected -= 1
        }

        player?.pause()

        var t = CMTime.zero
        player?.seek(to: t)
        changeSong()
        player?.play()
        playBool = true
        playPause.image = UIImage(systemName: "pause.fill")
        mainMusicLabel.text = musicList[tileSelected]
        mainAnimated()
    }
    
    func playback(){
        playPause.tintColor = UIColor.systemIndigo
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
            
        }
        playPause.tintColor = UIColor.systemIndigo
        
    }
    
    func mainAnimated()
    {
       
        mainMusicImage.layer.cornerRadius = mainMusicImage.frame.height/2
        let sView = UIView()
        setBorder(subView: sView, size: mainMusicImage.frame.size)
        mainMusicImage.addSubview(sView)
        mainMusicImage.layer.masksToBounds = true
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.mainMusicImage.transform = CGAffineTransform(scaleX: -0.01, y: 1.0)
        }, completion: {
            _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.mainMusicImage.image = UIImage(imageLiteralResourceName: self.musicList[self.tileSelected])
                self.mainMusicImage.transform = .identity
            }, completion: nil)

        })
    }
    
    func setBorder(subView : UIView, size :CGSize) -> UIView
    {
                
                subView.frame.size = size

        subView.layer.cornerRadius = subView.frame.height/2
                subView.layer.borderColor = UIColor.gray.cgColor
                subView.layer.borderWidth = 2


        subView.layer.masksToBounds = true
        return subView
        
    }
    func changeSong()
    {
        if (tileSelected != 0)
        {
            let local_sURL = Bundle.main.url(forResource: musicList[tileSelected], withExtension: "mp3")
            setMusicAV(musicUrl: local_sURL!)
        }
        else{
            setMusicAV(musicUrl: sURL!)
        }
    }
    
    func progressCheck(){
        
        var currTime = player?.currentTime().seconds
        var duration = player?.currentItem?.duration.seconds
        
        print (currTime!)
        print (duration!)
        progressBar.progress = Float(currTime!/duration!)
        
    }
   
    
    
    @objc func checkUpdates(){
        if (mModel != nil && playerItem != nil && player != nil)
        {
            progressCheck()
            if tileSelected == 0
            {mainMusicLabel.text = mModel?.title}
        
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


