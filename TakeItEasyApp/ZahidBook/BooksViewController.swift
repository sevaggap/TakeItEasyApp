import UIKit
import PDFKit
import WebKit

var genBookIMG = ["gb1", "gb2", "gb3", "gb4", "gb5"]
var techBookIMG = ["tb1", "tb2", "tb3", "tb4", "tb5"]
var recpBookIMG = ["rb1", "rb2", "rb3", "rb4", "rb5"]
var pdfView : PDFView? = nil

var searchedGen : [Books] = []
var searchedTech : [Books] = []
var searchedRecp : [Books] = []

var fetchBooks = FetchBooks()

var localBooks = ["general", "technical", "recipe"]

var genBooks = BookModel(items: [])
var techBooks = BookModel(items: [])
var recpBooks = BookModel(items: [])

var searching = false

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var CV1: UICollectionView!
    @IBOutlet weak var CV2: UICollectionView!
    @IBOutlet weak var CV3: UICollectionView!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedGen.removeAll()
        searchedTech.removeAll()
        searchedRecp.removeAll()
        if searchText == "" {
            searching = false
            print(searching)
            CV1.reloadData()
            CV2.reloadData()
            CV3.reloadData()
            
        } else {
            for genBook in genBooks.items {
                if genBook.volumeInfo.title.lowercased().contains(searchText.lowercased()){
                    searchedGen.append(genBook)
                }
            }
            for techBook in techBooks.items {
                if techBook.volumeInfo.title.lowercased().contains(searchText.lowercased()){
                    searchedTech.append(techBook)
                }
            }
            for recpBook in recpBooks.items {
                if recpBook.volumeInfo.title.lowercased().contains(searchText.lowercased()){
                    searchedRecp.append(recpBook)
                }
            }
        
            searching = true
            CV1.reloadData()
            CV2.reloadData()
            CV3.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            if searching {
                return searchedGen.count
            } else {
                return 5
            }
        case 1:
            if searching {
                return searchedTech.count
            } else {
                return 5
            }
        case 2 :
            if searching {
                return searchedRecp.count
            } else {
                return 5
            }
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //3 cells: Each cell represents a different topic of book
        
        if collectionView == self.CV1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! GeneralCollectionViewCell
            
            if searching {
                print("error here", searchedTech.count,indexPath.row)

                
                var url = searchedGen[indexPath.row].volumeInfo.imageLinks.smallThumbnail
                url = url.replacingOccurrences(of: "http", with: "https")
                
                let imageURL = URL(string: url)
                
                let getDataTask = URLSession.shared.dataTask(with: imageURL!, completionHandler: { data, _ , error in
                   let data = data!
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.bookImage.image = UIImage(data: data)
                    }
                })
                
                getDataTask.resume()
                
                
            } else {
                if indexPath.row < 4 {
                
                var url = genBooks.items[indexPath.row].volumeInfo.imageLinks.smallThumbnail
                url = url.replacingOccurrences(of: "http", with: "https")
                
                let imageURL = URL(string: url)
                
                let getDataTask = URLSession.shared.dataTask(with: imageURL!, completionHandler: { data, _ , error in
                   let data = data!
                    
                    DispatchQueue.main.async {
                        //let image = UIImage(data: data)
                        cell.bookImage.image = UIImage(data: data)
                    }
                })
                
                getDataTask.resume()
                } else {
                    cell.bookImage.image = UIImage(named: genBookIMG[indexPath.row])
                }
            }
            
            cell.contentMode = .scaleAspectFit
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: -1)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = true
            return cell
        } else if collectionView == self.CV2{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! TechnicalCollectionViewCell
            
            if searching {
                
                print("error here", searchedTech.count,indexPath.row)
                var url = searchedTech[indexPath.row].volumeInfo.imageLinks.smallThumbnail
                url = url.replacingOccurrences(of: "http", with: "https")
                
                let imageURL = URL(string: url)
                
                let getDataTask = URLSession.shared.dataTask(with: imageURL!, completionHandler: { data, _ , error in
                   let data = data!
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.bookImage.image = UIImage(data: data)
                    }
                })
                
                getDataTask.resume()
            
                
            } else {
                if indexPath.row < 4 {
                
                var url = techBooks.items[indexPath.row].volumeInfo.imageLinks.smallThumbnail
                url = url.replacingOccurrences(of: "http", with: "https")
                
                let imageURL = URL(string: url)
                
                let getDataTask = URLSession.shared.dataTask(with: imageURL!, completionHandler: { data, _ , error in
                   let data = data!
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.bookImage.image = UIImage(data: data)
                    }
                })
                
                getDataTask.resume()
                } else {
                    cell.bookImage.image = UIImage(named: techBookIMG[indexPath.row])
                }
            }
            
            cell.contentMode = .scaleAspectFit
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: -1)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = true
            return cell
        }else{
            //collectionView == self.CV3
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! RecipesCollectionViewCell
            
            if searching {
                print("error here", searchedTech.count,indexPath.row)

                var url = searchedRecp[indexPath.row].volumeInfo.imageLinks.smallThumbnail
                url = url.replacingOccurrences(of: "http", with: "https")
                
                let imageURL = URL(string: url)
                
                let getDataTask = URLSession.shared.dataTask(with: imageURL!, completionHandler: { data, _ , error in
                   let data = data!
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.bookImage.image = UIImage(data: data)
                    }
                })
                
                getDataTask.resume()
                
                
            } else {
                if indexPath.row < 4 {
                
                var url = recpBooks.items[indexPath.row].volumeInfo.imageLinks.smallThumbnail
                url = url.replacingOccurrences(of: "http", with: "https")
                
                let imageURL = URL(string: url)
                
                let getDataTask = URLSession.shared.dataTask(with: imageURL!, completionHandler: { data, _ , error in
                   let data = data!
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.bookImage.image = UIImage(data: data)
                    }
                })
                
                getDataTask.resume()
                } else {
                    cell.bookImage.image = UIImage(named: recpBookIMG[indexPath.row])
                }
            }

            cell.contentMode = .scaleAspectFit
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: -1)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = true
                return cell
                
        }
        
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.CV1{
            
            if searching {
                let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
    
                let secureLink = searchedGen[indexPath.row].volumeInfo.previewLink.replacingOccurrences(of: "http", with: "https")
               
                print(secureLink)
                webKitVC.bookLink = secureLink
               
                self.present(webKitVC, animated: true, completion: nil)
                
            } else {
                if indexPath.row < 4 {
                    
                    let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                    let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
        
                    let secureLink = genBooks.items[indexPath.row].volumeInfo.previewLink.replacingOccurrences(of: "http", with: "https")
                   
                    webKitVC.bookLink = secureLink
                   
                    self.present(webKitVC, animated: true, completion: nil)
                   
                } else {
                    //load local book
                    let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                    let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
                    pdfScreenVC.pdfName = localBooks[0]
                    self.present(pdfScreenVC, animated: true, completion: nil)
                }
            }
            
    }
        
        
        if collectionView == self.CV2{
            
            if searching {
                let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
    
                let secureLink = searchedTech[indexPath.row].volumeInfo.previewLink.replacingOccurrences(of: "http", with: "https")
               
                print(secureLink)
                webKitVC.bookLink = secureLink
               
                self.present(webKitVC, animated: true, completion: nil)
                
            } else {
                if indexPath.row < 4 {
                    
                    let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                    let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
        
                    let secureLink = techBooks.items[indexPath.row].volumeInfo.previewLink.replacingOccurrences(of: "http", with: "https")
                   
                    webKitVC.bookLink = secureLink
                   
                    self.present(webKitVC, animated: true, completion: nil)
                   
                } else {
                    //loads local book
                    let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                    let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
                    pdfScreenVC.pdfName = localBooks[1]
                    self.present(pdfScreenVC, animated: true, completion: nil)
                }
            }
    }
        
        if collectionView == self.CV3{
            
            if searching {
                let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
    
                let secureLink = searchedRecp[indexPath.row].volumeInfo.previewLink.replacingOccurrences(of: "http", with: "https")
               
                print(secureLink)
                webKitVC.bookLink = secureLink
               
                self.present(webKitVC, animated: true, completion: nil)
                
            } else {
                if indexPath.row < 4 {
                    
                    let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                    let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
        
                    let secureLink = recpBooks.items[indexPath.row].volumeInfo.previewLink.replacingOccurrences(of: "http", with: "https")
                   
                    webKitVC.bookLink = secureLink
                   
                    self.present(webKitVC, animated: true, completion: nil)
                   
                } else {
                    //loads local book
                    let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
                    let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
                    pdfScreenVC.pdfName = localBooks[2]
                    self.present(pdfScreenVC, animated: true, completion: nil)
                }
            }
    }
}
            

          override func viewDidLoad() {
              super.viewDidLoad()
              
              title = "Books"

              CV1.delegate = self
              CV1.dataSource = self
              
              CV2.delegate = self
              CV2.dataSource = self
              
              CV3.delegate = self
              CV3.dataSource = self
              
              searchBar.delegate = self
              
 
    }
    
    //Gives transparent nav bar
    func viewDidLoad_TransparentNavBar() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = appearance
        }

}
