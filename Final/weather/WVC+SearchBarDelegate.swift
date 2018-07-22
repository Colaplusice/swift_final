//
//  WeatherVC+SearchBarDelegate.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/21.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import Foundation
import UIKit
//进行searchBar操作的代理
extension WeatherViewController:UISearchBarDelegate{
    
    @objc func dismissskeyboard(){
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissskeyboard()
        
        if !searchBar.text!.isEmpty{
            UIApplication.shared.isNetworkActivityIndicatorVisible=true
            print(searchBar.text!)
            self.get_result(cityname: searchBar.text!)
         
        }
    }
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}
