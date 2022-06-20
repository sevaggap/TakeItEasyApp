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
    
    func getDataSearch(url: URL,completion: @escaping(Result<DataMusic , Error>) -> Void)
    {
       
        var result : DataMusic?
        URLSession.shared.dataTask(with: url, completionHandler:{ data, resp, err in
            
            guard let data = data, err == nil else{
                completion(.failure(err!))
                print(err!)
                return
            }
            print(resp)
            
            do{
                print("in data ", data)
                result = try JSONDecoder().decode(DataMusic.self, from: data)
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

    struct DataMusic: Decodable {
        let data : [MusicModel]
    }
struct MusicModel: Decodable {
 
  let id: Int
  let title: String
  let preview: String
    let album: album

}
    struct album: Decodable
    {
        let cover_medium: String
    }
}
