//
//  Picture_layoutViewController.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/27.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//
import UIKit
class Picture_layoutViewController: UIViewController {
    @IBAction func Segment_controll(_ sender: UISegmentedControl) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        let columns=sender.selectedSegmentIndex+2
        let max=self.view.subviews.count
        
        let screen_width:Int=Int(self.view.frame.width);
//        let screen_height:Int=Int(self.view.frame.height);
        let icon_size=50
        let margin=(screen_width-(columns*icon_size))/columns
            for  i in 1...max-1{
            let current_view=self.view.subviews[i]
                let current_frame=CGRect(x: CGFloat(((i-1)%columns)*(margin+icon_size)+margin/2), y: CGFloat(((i-1)/columns)*(margin+50)+100), width: 50, height: 50)
            current_view.frame=current_frame
        }
    }
    override func viewDidLoad() {
        for  i in 0...9{
            let Str=String(format:"01%d.png",i)
                    let image=UIImage(named:Str)
            if let image = image{
                let a:UIImageView=UIImageView(image: image)
                a.frame=CGRect(x: CGFloat((i%3)*100+50), y: CGFloat((i/3)*100+100), width: 60, height: 60)
                self.view.addSubview(a)
            }
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
