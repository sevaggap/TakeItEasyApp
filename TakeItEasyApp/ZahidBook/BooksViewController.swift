import UIKit
import PDFKit
import WebKit



//var bookIMG = ["hp1", "hp2", "hp3"]
var bookData = ["hpbook1", "hpbook2", "hpbook3"]
var genBookIMG = ["gb1", "gb2", "gb3", "gb4"]
var techBookIMG = ["tb1", "tb2", "tb3", "tb4"]
var recBookIMG = ["rb1", "rb2", "rb3", "rb4"]
var pdfView : PDFView? = nil


//var bookLink : String?
var genBookLink : [String]?
var techBookLink : [String]?
var recBookLink : [String]?


class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var CV1: UICollectionView!
    @IBOutlet weak var CV2: UICollectionView!
    @IBOutlet weak var CV3: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genBookIMG.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
            
            
            
        default:
            print("No Book")
        }
    }
}
        
    

          override func viewDidLoad() {
              super.viewDidLoad()
              
              viewDidLoad_TransparentNavBar()
             // viewDidLoad_PopulateCurrentUserName()
              
              title = "Books"

              CV1.delegate = self
              CV1.dataSource = self
              
              CV2.delegate = self
              CV2.dataSource = self
              
              CV3.delegate = self
              CV3.dataSource = self
              
              var fetchBooks = FetchBooks()
//              var imgLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
//              var volInfo = VolumeInfo(title: "", description: "")
//              var books = Books(id: "", selfLink: "")
//              var bModel = BookModel(items: [books])
              
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
                          genBookLink?.append(item.volumeInfo.previewLink)
                              
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
                              techBookLink?.append(item.volumeInfo.previewLink)
                              
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
                          recBookLink?.append(item.volumeInfo.previewLink)
                              
                          }
                      }
                }
            })
              
             // var timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateBooks), userInfo: nil, repeats: true)
              
//             let generalBooks = FetchBooks.fetchBooks.getGeneral()
//             let technicalBooks = FetchBooks.fetchBooks.getTechnical()
//             let recipesBooks = FetchBooks.fetchBooks.getRecipes()
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
//            // TODO: - Uncomment the following two lines to populate user name in the nav bar
//            CurrentUser.user.updateCurrentUserName()
//            navItemUserName.title = CurrentUser.user.name
    
    
    
    }
    

    



//extension BooksViewController : UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize()
//    }
//}


