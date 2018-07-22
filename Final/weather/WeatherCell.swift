//
//  WeatherCell.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/21.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import UIKit
class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherlabel: UILabel!
    @IBOutlet weak var citylable: UILabel!
    @IBOutlet weak var templabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!
   // {"results":[{"location":{"id":"WX4FBXXFKE4F","name":"北京","country":"CN","path":"北京,北京,中国","timezone":"Asia/Shanghai","timezone_offset":"+08:00"},"now":{"text":"晴间多云","code":"5","temperature":"30","feels_like":"27","pressure":"1000","humidity":"32","visibility":"2.8","wind_direction":"西南","wind_direction_degree":"241","wind_speed":"12.61","wind_scale":"3","clouds":"30","dew_point":""},"last_update":"2018-06-22T11:01:00+08:00"}]}
    func configure(weather:Weather){
        let dict=weather.property_dict
        if let place=dict["name"],
        let temp=dict["temperature"],
            let text=dict["text"],
        let time=dict["last_update"]
        {
            print("true")
                    citylable.text=place
                    weatherlabel.text=text
                    timelabel.text=time
                    templabel.text=temp+"ºC"
        }
        else{
            print(weather.property_dict)
            print("config is wrong")
        }
//

    }

}
