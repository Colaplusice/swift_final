//
//  ShowDetailViewController.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/22.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    @IBOutlet weak var City_label: UILabel!
    var result:Weather!
    @IBOutlet weak var wind_speed: UILabel!
    @IBOutlet weak var feel_like: UILabel!
    @IBOutlet weak var humdity: UILabel!
    @IBOutlet weak var wind_direction: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var temp: UILabel!
    override func viewDidLoad() {
//        City_label.text=city_name
        config()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func config(){
        let dict=self.result.property_dict
        City_label.text=dict["name"]
        wind_speed.text="风速:"+dict["wind_speed"]!+"km/h"
        humdity.text="湿度:"+dict["humidity"]!
        feel_like.text="体感温度:"+dict["feels_like"]!+"ºC"
        wind_direction.text="风向:"+dict["wind_direction"]!
        pressure.text="气压:"+dict["pressure"]!+"Pa"
        temp.text="温度:"+dict["temperature"]!+"ºC"
        text.text=dict["text"]!
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
    
    

