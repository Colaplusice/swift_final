//
//  WeatherViewController.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/21.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SearchItem: UITabBarItem!
    
    @IBOutlet var mainview: UIView!
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissskeyboard))
        
        return recognizer
    }()
    var searchResults: [Weather] = []
    
    let queryService = QueryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hidesBottomBarWhenPushed=true
        tableview.tableFooterView = UIView()
        self.get_result(cityname: "北京")
        self.get_result(cityname: "上海")
        self.get_result(cityname: "广州")
        self.get_result(cityname: "济南")
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination=segue.destination as?ShowDetailViewController,let indexPath=tableview.indexPathForSelectedRow{
            destination.result=searchResults[indexPath.row]
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */
}

extension WeatherViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("底下调用了reload data")
//        print(searchResults.count)
        let cell:WeatherCell = tableView.dequeueReusableCell(for: indexPath)
        let weather = searchResults[indexPath.row]
        cell.configure(weather: weather)
        return cell
    }
    
    
    // When user taps cell, play the local file, if it's downloaded
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let city = searchResults[indexPath.row]
//        print(city.place)
//        显示动画效果
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func get_result(cityname:String){
        queryService.getSearchResults(searchTerm:cityname){
            result,errormessage in UIApplication.shared.isNetworkActivityIndicatorVisible=false
            
            if let result = result{
                self.searchResults=result
                print(self.searchResults.count)
                //                    重新加载数据
                self.tableview.reloadData()
                self.tableview.setContentOffset(CGPoint.zero, animated: false)
            }
            else{
                print("reload data is wrong")
            }
            
            if !errormessage.isEmpty{
                print("查找出现错误:"+errormessage)
            }
        }
    }

}

