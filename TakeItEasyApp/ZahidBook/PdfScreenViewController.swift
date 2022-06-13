import UIKit
import PDFKit

class PdfScreenViewController: UIViewController {
    
    var pdfName : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let pdfView = PDFView(frame: view.bounds)
       
        pdfView.autoScales = true
        let filePath = Bundle.main.url(forResource: pdfName, withExtension: "pdf")
        pdfView.document = PDFDocument(url: filePath!)
        
        view.addSubview(pdfView)
    }
    

}
