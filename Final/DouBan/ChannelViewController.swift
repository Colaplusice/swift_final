//
//  ChannelViewController.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/20.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    @IBOutlet weak var tv: UITableView!

    override func viewDidLoad() {
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

extension ChannelViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "douban")
        cell.textLabel?.text="title:\(indexPath.row)"
        cell.detailTextLabel?.text="detail:\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView:UITableView,numberOfRowsInSection section:Int)->Int{
        print("select")
        return 10
    }
    func tableView(tableView:UITableView!,didSelectRowAtIndexPath indexPath: NSIndexPath!){
        print("选择了第\(indexPath.row)行")
    }
}



