//
//  MusicViewController.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-09.
//

import UIKit
import AVFoundation


class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    var globalIndexPath : IndexPath?
    @IBOutlet weak var musicCV: UICollectionView!
    var search : Bool = false
    
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
    
    var stopAnimate : Bool = false
    var songChange : Bool = false
    var songNum : Int = 0
    var count : Int = 0
    var tileSelected : Int = 0
    var playBool = true
    var uCell : MusicCollectionViewCell?
    var musicList = ["Deezer", "Sky", "Hawaii", "Enchante", "Drive"]
    var musicListOriginal = ["Deezer", "Sky", "Hawaii", "Enchante", "Drive"]
    var Audio : AVAudioPlayer?
    var timer : Timer?
    var mModel : MusicModel?
    
    var sURL = URL(string:"Sky")
    var mUrl = URL(string: "https://api.deezer.com/track/1522223672")!
    var searchPlay : Bool = false
  
   
    
    func shuffle()
    {
        var randomInt = 1
        repeat{
         randomInt = Int.random(in: 0..<5)
        } while (randomInt == songNum)
        songNum = randomInt
        switch songNum{
        case 0:
            mUrl = URL(string: "https://api.deezer.com/track/3135556")!
        case 1:
            mUrl = URL(string: "https://api.deezer.com/track/1432930542")!
        case 2:
            mUrl = URL(string: "https://api.deezer.com/track/142706538")!
        case 3:
            mUrl = URL(string: "https://api.deezer.com/track/1703487577")!
        case 4:
            mUrl = URL(string: "https://api.deezer.com/track/1411181832")!
        case 5:
            mUrl = URL(string: "https://api.deezer.com/track/1765270907")!
        case 6:
            mUrl = URL(string: "https://api.deezer.com/track/435491482")!
        case 7:
            mUrl = URL(string: "https://api.deezer.com/track/86773062")!
        case 8:
            mUrl = URL(string: "https://api.deezer.com/track/1703487577")!
        case 9:
            mUrl = URL(string: "https://api.deezer.com/track/1614228152")!
        default:
            mUrl = URL(string: "https://api.deezer.com/track/8086136")!
        
            
        }
        
        getData(url: mUrl, completion: { result in
            switch result{
            case .failure(let error):
                print("sw", error)
            case .success(let res):
                self.mModel = res
                print()
                self.sURL = URL(string: self.mModel!.preview)
                self.songChange = true
                
                self.setMusicAV(musicUrl: self.sURL!)
                //for item in res.album
                
                self.getMusicImage(urlstring: (self.mModel?.album.cover_medium)!)
                self.changeSong()
            }
            })
    }
    
    func getMusicImage(urlstring : String)
    {
        let url = URL(string: urlstring)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async { [self] in
                
                var img = UIImageView()
                img.image = UIImage(data: data!)
                self.mainAnimated(img: img)
            }
        }
    }
    
    
    
    
 
    override func viewDidDisappear(_ animated: Bool)
    {
        player?.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.enablesReturnKeyAutomatically = true
        
      
        
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
                self.getMusicImage(urlstring: (self.mModel?.album.cover_medium)!)
                
                
        }
        
        })
        playBool = true
        playback()
        
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkUpdates), userInfo: nil, repeats: true)
        
        //let sUrl = URL(string: musicData!.preview)
       
        
        //
        
        //setMusic(song: URL(fileURLWithPath: filePath))
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        globalIndexPath = indexPath
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
        if (stopAnimate == false)
        {
        cell.animateCell()
        }
        
        
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
        //mainAnimated()
        
        
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
    }
    
    func playback(){
       
        if (playBool == true)
        {
           playPause.image = UIImage(systemName: "play.fill")
            playBool = false
            player?.pause()
        }
        else
        {
            playPause.image = UIImage(systemName: "pause.fill")
            playBool = true
            player?.play()
            
        }
                
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
           modeChange()
        
        
        }
    
    func mainAnimated(img : UIImageView)
    {
       
        mainMusicImage.layer.cornerRadius = mainMusicImage.frame.height/2
        let sView = UIView()
        setBorder(subView: sView, size: mainMusicImage.frame.size)
        mainMusicImage.addSubview(sView)
        mainMusicImage.layer.masksToBounds = true
        
        if img.image == mainMusicImage.image
        {
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
        else
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.mainMusicImage.transform = CGAffineTransform(scaleX: -0.01, y: 1.0)
            }, completion: {
                _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.mainMusicImage.image = img.image
                    self.mainMusicImage.transform = .identity
                }, completion: nil)

            })
            
        }
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
            print(tileSelected)
            mainAnimated(img: mainMusicImage)
            mainMusicLabel.text = musicList[tileSelected]
            setMusicAV(musicUrl: local_sURL!)
            
        }
        else{
          
            if (songChange == false)
            {
                
                shuffle()
                            }
            else
            {
                player?.play()
               // mainMusicLabel.text = musicList[tileSelected]
                //playBool = true
                
                
                
                
                songChange = false
            }
            
            //setMusicAV(musicUrl: sURL!)
        }
        
      
    }
    
    func progressCheck(){
        
        var currTime = player?.currentTime().seconds
        var duration = player?.currentItem?.duration.seconds
        
        
        progressBar.progress = Float(currTime!/duration!)
        
    }
   
    
    
    @objc func checkUpdates(){
       if tileSelected != 0
        {
           searchBar.placeholder = "Select Deezer to search for songs"
       }
        else
        {
            searchBar.placeholder = "Search for songs in Deezer"
        }
        if (searchPlay == true)
        {
            playPause.image = UIImage(systemName: "pause.fill")
            searchPlay = false
        }
      
        if (mModel != nil && playerItem != nil && player != nil)
        {
            progressCheck()
            if tileSelected == 0
            {mainMusicLabel.text = mModel?.title}
        }
          
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var count = 0
        for item in musicList
        {
            if item != "Deezer" && !item.lowercased().contains(searchText.lowercased())
            {
                musicList.remove(at: count)
            count -= 1
            }
            count += 1
        }
        stopAnimate = true
        if searchBar.text == ""
        {
            musicList = musicListOriginal
            stopAnimate = false
        }
        
        
        
        musicCV.reloadData()
       
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        musicList = musicListOriginal
        stopAnimate = true
        musicCV.reloadData()
        stopAnimate = false
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         
        print("hi")
       if(tileSelected == 0)
        {
           
           var str = searchBar.text!
           var strrep = str.replacingOccurrences(of: " ", with: "_")
           var newstr = "https://api.deezer.com/search?q=" + strrep
           var searchUrl = URL(string: newstr)
           print(searchUrl)
           getDataSearch(url: searchUrl!, completion: { result in
            switch result{
            case .failure(let error):
                print("sw", error)
            case .success(let res):
                self.mModel = res.data.first
                print()
                self.sURL = URL(string: self.mModel!.preview)
                self.songChange = true

                self.setMusicAV(musicUrl: self.sURL!)
                //for item in res.album

                self.getMusicImage(urlstring: (self.mModel?.album.cover_medium)!)
                self.player?.pause()
                self.player?.play()
                self.searchPlay = true
            }
            })
       }
        
        
    }
    
}
