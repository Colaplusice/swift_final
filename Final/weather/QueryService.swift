//
//  QueryService.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/21.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import Foundation

class QueryService {
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Weather]?, String) -> ()
    var weathers: [Weather] = []
    var errorMessage = ""
    let defaultSession=URLSession(configuration: .default)
    var dataTask:URLSessionTask?
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        
//        dataTask?.cancel()
        if var urlCompoents = URLComponents(string: "https://api.seniverse.com/v3/weather/now.json"){
            urlCompoents.query = "key=gf1eymq6ekmdcys8&location=\(searchTerm)&language=zh-Hans&unit=c"
            //      如果无法通过，运行 括号内的代码
            guard let url=urlCompoents.url else{
                return
            }
            dataTask=defaultSession.dataTask(with: url){
                //          defer 在未来某个时刻运行代码块
                data,response,error in defer{
                    self.dataTask = nil
                }
                if let error = error{
                    self.errorMessage+="dataTask error "+error.localizedDescription+"\n"
                }
                    //          请求成功 将数据下传
                else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200{
                    self.updateSearchResults(data)
                }
                DispatchQueue.main.async {
                    completion(self.weathers,self.errorMessage)
                }
            }
        }
        dataTask?.resume()
//        等到底下更新好数据后,返回weather作为调用方法的返回值
        DispatchQueue.main.async {
            completion(self.weathers, self.errorMessage)
        }
    }
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
//        weathers.removeAll()
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
//        解析json数据
        var index = 0
        for WeatherDictionary in array{
            if let WeatherDictionary = WeatherDictionary as? JSONDictionary,
                let location = WeatherDictionary["location"] as? JSONDictionary,
                       let last_update=WeatherDictionary["last_update"]     as? String,
                let now = WeatherDictionary["now"] as? JSONDictionary {
                do {
                    var property_dict=Dictionary<String,String>()
                    for (key,value) in location{
                        property_dict[key]=value as? String
                    }
                    for (key,value) in now{
                        property_dict[key]=value as? String
                    }
                    property_dict["last_update"]=last_update
                    
                weathers.append(Weather(property_dict: property_dict))
//                    把请求添加在weather数组中
//                    weathers.append(Weather(place: city_name
//                        , day: last_update, temp: temp ,situation:weather))
//                    print("success")
                    index += 1
                }
            }
                    else{
                    errorMessage += "something is None\n"
            }
//                else {
//                errorMessage += "Problem parsing trackDictionary\n"
//            }
        }
    }
}
