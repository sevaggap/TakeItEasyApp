//
//  DeezerAPI.swift
//  TakeItEasyApp
//
//  Created by James Suresh on 2022-06-16.
//

import Foundation

extension MusicViewController{

    

    
    func getData(url: URL,completion: @escaping(Result<MusicModel , Error>) -> Void)
    {
       
        var result : MusicModel?
        URLSession.shared.dataTask(with: url, completionHandler:{ data, resp, err in
            
            guard let data = data, err == nil else{
                completion(.failure(err!))
                print(err!)
                return
            }
            print(resp)
            
            do{
                print("in data ", data)
                result = try JSONDecoder().decode(MusicModel.self, from: data)
                completion(.success(result!))
                print("in result ", result)
                
            }
            catch let err{
                print(err)
                completion(.failure(err))
                
            }
            
            }).resume()
        print(result)
        
        
        
       
        
    }


struct MusicModel: Decodable {
 
  let id: Int
  let title: String
  let release_date: String
  let preview: String

}
}
