//
//  HttpController.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/20.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import Foundation
class Httpcontroller {
    
    typealias JSONDictionary = [String:Any]
    typealias Result = ([Music]?,String)->()
    var music:[Music] = []
    
    //    var delegate:HttpProtocol?
    
    let defaultSession=URLSession(configuration: .default)
    var dataTask:URLSessionTask?
    var errorMessage=""
    
    func onSearch(url:String,completion:@escaping Result){
        dataTask?.cancel()
        if var urlcompoents = URLComponents(string: url)
        {
            guard let url=urlcompoents.url else{
                return
            }
            
            dataTask=defaultSession.dataTask(with: url){
                data,response,error in defer{
                    self.dataTask=nil
                }
                
                
                if let error = error{
                    self.errorMessage+="dataTask error"+error.localizedDescription+"\n"
                }
                    //                响应成功
                else if let data=data,
                    let response=response as? HTTPURLResponse,
                    response.statusCode == 200{
                    var result:JSONDictionary?
                    do {
                        result=try JSONSerialization.jsonObject(with: data, options: [])as? JSONDictionary
                        
                        self.updateSearchResult(data)
                        
                    }
                    catch let parseError as NSError{
                        self.errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                        return
                    }
                }
                //            这个地方是完成?
                DispatchQueue.main.async {
                    completion(self.music,self.errorMessage)
                }
            }
            dataTask?.resume()
            DispatchQueue.main.async {
                completion(self.music, self.errorMessage)
            }
            
        }
        
    }
    
    fileprivate func updateSearchResult(_ data: Data){
        var response: JSONDictionary?
        music.removeAll()
        do{
            response=try JSONSerialization.jsonObject(with: data, options: [])as? JSONDictionary
//            print(response!)
            
        }
        catch let parserError as NSError{
            errorMessage += "JSONSerialization error: \(parserError.localizedDescription)\n"
            return
        }
        
        guard let array=response!["song"] as? [Any] else{
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        var index=0
        for song_array in array{
            if let song_array=song_array as? JSONDictionary,
                let album_title=song_array["albumtitle"] as? String,
                let artist=song_array["artist"] as? String,
                let image_url=song_array["picture"]as? String,
                let play_url=song_array["url"] as? String
                
            {
                music.append(Music(name: album_title, artist: artist,image_url:image_url,play_url:play_url))
                index+=1
            }
            else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
}
