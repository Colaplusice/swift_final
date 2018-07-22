//  ViewController.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/11.
//  Copyright ©2018年 樊佳亮. All right reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var budledir:String?

    @IBOutlet weak var view1: UIImageView!
    @IBOutlet weak var slider_1: UISlider!
    
    @IBOutlet weak var swichBar: UISwitch!
    @IBOutlet weak var Imageslider: UISlider!
    @IBOutlet weak var label_1: UILabel!

    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var setting_button: UIButton!
    @IBOutlet weak var label_2: UILabel!
    
    var listdata:NSDictionary?
    var array=[String]()

    
    
    
// 设置是否是夜间模式
    @IBAction func Controll_light(_ sender: UISwitch) {

        if sender.isOn{
            self.view.backgroundColor=UIColor.darkGray
            
            self.label_2.textColor=UIColor.white
            self.label_1.textColor=UIColor.white

        }
        else{
            self.view.backgroundColor=UIColor.white
            self.label_1.textColor=UIColor.white
            self.label_2.textColor=UIColor.black

        }
        
    }
    
//    设置图片大小
    @IBAction func controll_image(_ sender: UISlider) {
        view1.transform=CGAffineTransform(scaleX: CGFloat(sender.value), y: CGFloat(sender.value))
    }
    
    @IBAction func klj(_ sender: Any) {
        let fullsize=UIScreen.main.bounds.size
        let width=fullsize.width
        let height=fullsize.height
        print(width)
        print(height)
        UIView.setAnimationDuration(1.0)
        UIView.beginAnimations(nil, context: nil)
        var a=view_1.center

        if view_1.frame.origin.y==self.view.frame.size.height{
            a.y-=view_1.frame.height
        }
        else{
            a.y+=view_1.frame.height
        }
        view_1.center=a
    }
    
    
 
    @IBAction func slider_action(_ sender: Any) {
        let value=Int(slider_1.value)
            label_1.text=("\(value+1)/16")
        let imagarr=UIImage(named: "\(String(value)).jpeg")
        view1.image=imagarr
        label_2.text=array[value]
    }
    override func viewDidLoad() {
//        slider_1.minimumValue=0
//        slider_1.maximumValue=15
        if let  budledir=Bundle.main.path(forResource: "image_message", ofType: "plist"){
            if let formlist=NSArray(contentsOfFile: budledir) as? [String]{
             array=formlist
            }
            else{
                print("null")
            }
        }
        
        self.label_2.text=array[0]
//        listdata=NSDictionary(contentsOfFile: budledir!)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from anib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

