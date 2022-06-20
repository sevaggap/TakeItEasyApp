import UIKit
import PDFKit
import WebKit



var genBookIMG = ["gb1", "gb2", "gb3", "gb4", "gb5"]
var techBookIMG = ["tb1", "tb2", "tb3", "tb4", "tb5"]
var recBookIMG = ["rb1", "rb2", "rb3", "rb4", "rb5"]
var pdfView : PDFView? = nil


//var bookLink : String?
var genBookLink : [String]?
var techBookLink : [String]?
var recBookLink : [String]?


var localBooks = ["general", "technical", "recipe"]



var searching = false


class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var CV1: UICollectionView!
    @IBOutlet weak var CV2: UICollectionView!
    @IBOutlet weak var CV3: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recBookIMG.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //3 cells: Each cell represents a different topic of book
        
        if collectionView == self.CV1{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! GeneralCollectionViewCell
        cell.bookImage.image = UIImage(named: genBookIMG[indexPath.row])
            cell.contentMode = .scaleAspectFit
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: -1)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = true
            return cell
        }; if collectionView == self.CV2{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! TechnicalCollectionViewCell
            cell.bookImage.image = UIImage(named: techBookIMG[indexPath.row])
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
                    cell.bookImage.image = UIImage(named: recBookIMG[indexPath.row])
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
        switch indexPath.row{
        case 0 :
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
  
            webKitVC.bookLink = genBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            
            
        case 1:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
         
            webKitVC.bookLink = genBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            

        case 2:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
         
            webKitVC.bookLink = genBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            
        case 3:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
         
            webKitVC.bookLink = genBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            
        case 4:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
            pdfScreenVC.pdfName = localBooks[0]
            self.present(pdfScreenVC, animated: true, completion: nil)
            
            
            
        default:
            print("No Book")
        }
    }
        
        
        if collectionView == self.CV2{
        switch indexPath.row{
        case 0 :
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
         
            webKitVC.bookLink = techBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            
            
        case 1:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
          
            webKitVC.bookLink = techBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            

        case 2:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
            
            webKitVC.bookLink = techBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            
            
        case 3:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
         
            webKitVC.bookLink = genBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            
        case 4:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
            pdfScreenVC.pdfName = localBooks[1]
            self.present(pdfScreenVC, animated: true, completion: nil)
            
            
            
        default:
            print("No Book")
        }
    }
        
        
        if collectionView == self.CV3{
        switch indexPath.row{
        case 0 :
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
            webKitVC.bookLink = recBookLink![indexPath.row]
            self.present(webKitVC, animated: true, completion: nil)
            
        case 1:
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
            webKitVC.bookLink = recBookLink![indexPath.row]
            self.present(webKitVC, animated: true, completion: nil)

        case 2:
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
            webKitVC.bookLink = recBookLink![indexPath.row]
            self.present(webKitVC, animated: true, completion: nil)
            
        case 3:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let webKitVC = storyObject.instantiateViewController(withIdentifier: "webScreen") as! WebUIKit
         
            webKitVC.bookLink = recBookLink![indexPath.row]
            
            self.present(webKitVC, animated: true, completion: nil)
            
        case 4:
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
            pdfScreenVC.pdfName = localBooks[2]
            self.present(pdfScreenVC, animated: true, completion: nil)
            
            
        default:
            print("No Book")
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
              
              var fetchBooks = FetchBooks()

              
              fetchBooks.getGeneral(completion: {
                  result in
                  switch result{
                  case .failure(let error):
                      print("Error Message",error)
                  case .success(let res):
                      for item in res.items {
                          if genBookLink == nil{
                              genBookLink = [item.volumeInfo.previewLink]
                          }else{
                              var link = item.volumeInfo.previewLink
                              link = link.replacingOccurrences(of: "http", with: "https")
                          genBookLink?.append(link)
                              
                          }
                      }
                }
            })
              fetchBooks.getTechnical(completion: {
                  result in
                  switch result{
                  case .failure(let error):
                      print("Error Message",error)
                  case .success(let res):
                      for item in res.items {
                          if techBookLink == nil{
                              techBookLink = [item.volumeInfo.previewLink]
                          }else{
                              var link = item.volumeInfo.previewLink
                              link = link.replacingOccurrences(of: "http", with: "https")
                              techBookLink?.append(link)
                              
                          }
                      }
                }
            })
              fetchBooks.getRecipes(completion: {
                  result in
                  switch result{
                  case .failure(let error):
                      print("Error Message",error)
                  case .success(let res):
                      for item in res.items {
                          if recBookLink == nil{
                              recBookLink = [item.volumeInfo.previewLink]
                          }else{
                              var link = item.volumeInfo.previewLink
                              link = link.replacingOccurrences(of: "http", with: "https")
                          recBookLink?.append(link)
                              
                          }
                      }
                }
            })
              
 
    }
    
    @objc func updateBooks(){
//        if (bookLink != nil){
//
//            let newUrl = URL(string: "http://books.google.ca/books?id=xrD1iuM_2LgC&printsec=frontcover&hl=&source=gbs_api")
//            webKitView.load(URLRequest(url: newUrl!))
//            self.view = webKitView
            
        }
    
    //Gives transparent nav bar
    func viewDidLoad_TransparentNavBar() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = appearance
        }
    
    
//    func viewDidLoad_PopulateCurrentUserName() {
//            CurrentUser.user.updateCurrentUserName()
//            navItemUserName.title = CurrentUser.user.name
//
//}

//extension BooksViewController : UISearchBarDelegate{
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText : String){
//        bookData.removeAll()
//        print("in search")
//        if searchText == "" {
//            searching = false
//            FetchBooks.fetchBooks =
//        }
//    }
//}
    

    







}
