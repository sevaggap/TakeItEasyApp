import UIKit

class FetchBooks {
    
    static var fetchBooks = FetchBooks()
    
    //user id and api token for books

    let generalURL = "https://www.googleapis.com/books/v1/users/103200976680999862226/bookshelves/1001/volumes?&key=AIzaSyDAxOFabzmbB-DXIUmc0Gam69zqEKKxf94"
    
    let technicalURL = "https://www.googleapis.com/books/v1/users/103200976680999862226/bookshelves/1002/volumes?&key=AIzaSyDAxOFabzmbB-DXIUmc0Gam69zqEKKxf94"
    
    let recipesURL = "https://www.googleapis.com/books/v1/users/103200976680999862226/bookshelves/1003/volumes?&key=AIzaSyDAxOFabzmbB-DXIUmc0Gam69zqEKKxf94"
    
    
    
    
    
    func getGeneral(completion: @escaping(Result<BookModel, Error>) -> Void){
        
        var result : BookModel?
     URLSession.shared.dataTask(with: URL(string: generalURL)!, completionHandler: { data, resp,err in
         
            guard let data = data, err == nil else{
                //print("Error in result")
                return
            }
            //print(resp)
            
            do{
                print("in books ", data)
                result = try JSONDecoder().decode(BookModel.self, from: data)
                completion(.success(result!))
               // print("in result ", result)
            }
            catch let err{
                //print(err)
                
            }
            guard let json = result else{
                //print("Error in result")
                return
            }
        //  print("Books are ", json.items)
            
        }).resume()
       
        
    }
    
    func getTechnical(completion: @escaping(Result<BookModel, Error>) -> Void){
        
        var result : BookModel?
     URLSession.shared.dataTask(with: URL(string: technicalURL)!, completionHandler: { data, resp,err in
         
            guard let data = data, err == nil else{
                //print("Error in result")
                return
            }
            //print(resp)
            
            do{
                print("in books ", data)
                result = try JSONDecoder().decode(BookModel.self, from: data)
                completion(.success(result!))
               // print("in result ", result)
            }
            catch let err{
                //print(err)
                
            }
            guard let json = result else{
                //print("Error in result")
                return
            }
        //  print("Books are ", json.items)
            
        }).resume()
       
        
    }
    
    func getRecipes(completion: @escaping(Result<BookModel, Error>) -> Void){
        
        var result : BookModel?
     URLSession.shared.dataTask(with: URL(string: recipesURL)!, completionHandler: { data, resp,err in
         
            guard let data = data, err == nil else{
                //print("Error in result")
                return
            }
            //print(resp)
            
            do{
                print("in books ", data)
                result = try JSONDecoder().decode(BookModel.self, from: data)
                completion(.success(result!))
               // print("in result ", result)
            }
            catch let err{
                //print(err)
                
            }
            guard let json = result else{
                //print("Error in result")
                return
            }
        //  print("Books are ", json.items)
            
        }).resume()
       
        
    }
    
    
//    struct BookModel: Decodable {
//        let items: [Books]
//
//    }
//
//    //structs for
//
//    struct Books: Decodable {
//        let id : String
//        let selfLink : String
//        let volumeInfo : VolumeInfo
//
//
//    }
//
//    struct VolumeInfo: Decodable{
//         let title : String
//         let description : String
//         let imageLinks : ImageLinks
//         let previewLink : String
//
//    }
//
//    struct ImageLinks : Decodable{
//        let smallThumbnail : String
//        let thumbnail : String
//    }
//}
}
