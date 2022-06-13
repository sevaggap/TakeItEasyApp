import UIKit
import PDFKit



var bookIMG = ["hp1", "hp2", "hp3"]
var bookData = ["hpbook1", "hpbook2", "hpbook3"]
var pdfView : PDFView? = nil


class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var CV1: UICollectionView!
    @IBOutlet weak var CV2: UICollectionView!
    @IBOutlet weak var CV3: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookIMG.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.CV1{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! GeneralCollectionViewCell
        cell.bookImage.image = UIImage(named: bookIMG[indexPath.row])
            return cell
        }; if collectionView == self.CV2{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! TechnicalCollectionViewCell
            cell.bookImage.image = UIImage(named: bookIMG[indexPath.row])
            return cell
        }else{
            //collectionView == self.CV3
                       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! RecipesCollectionViewCell
                    cell.bookImage.image = UIImage(named: bookIMG[indexPath.row])
                return cell
                
    }
        
        
        
    }
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0 :
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
            pdfScreenVC.pdfName = bookData[indexPath.row]
            self.present(pdfScreenVC, animated: true, completion: nil)
            
        case 1:
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
            pdfScreenVC.pdfName = bookData[indexPath.row]
            self.present(pdfScreenVC, animated: true, completion: nil)

        case 2:
            
            let storyObject = UIStoryboard(name: "Zahid", bundle: nil)
            let pdfScreenVC = storyObject.instantiateViewController(withIdentifier: "pdfScreen") as! PdfScreenViewController
            pdfScreenVC.pdfName = bookData[indexPath.row]
            self.present(pdfScreenVC, animated: true, completion: nil)
            
            
        default:
            print("No Book")
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
    }
    

    

}

//extension BooksViewController : UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize()
//    }
//}


