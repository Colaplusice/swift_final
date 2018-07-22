//
//  DoubanViewController.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/20.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//
import UIKit
import AVKit
class DoubanViewController: UIViewController {
    var audioPlayer:AVPlayerViewController=AVPlayerViewController()
    @IBOutlet weak var iv: UIImageView!
//    @IBOutlet weak var choose_channel: UILabel!

    @IBOutlet weak var play_button: UIButton!
    @IBOutlet weak var next_button: UIButton!
    @IBOutlet weak var play_time: UILabel!
    @IBOutlet weak var playslider: UISlider!
    
    
    @IBOutlet weak var artist_name: UILabel!
    @IBOutlet weak var song_name: UILabel!
    let pause_image=UIImage(named: "hp_player_btn_pause_highlight")
    let start_image=UIImage(named: "hp_player_btn_play_highlight")
    
    @IBAction func change_slider(_ sender: UISlider) {
        let second=Int64(sender.value)
        let target:CMTime=CMTimeMake(second, 1)
        self.audioPlayer.player?.seek(to: target)
        if self.audioPlayer.player?.rate==0{
            self.audioPlayer.player?.play()
        }
        print(sender.value)
    }
    var search_result:[Music]=[]
    var image_cache=Dictionary<String,UIImage>()
    //
    let eHttp = Httpcontroller()
    
//    playButton
    @IBAction func Play(_ sender: UIButton) {
        
        if search_result.count==0{
            return
        }
        guard (self.audioPlayer.player?.status) != nil else {
                    Play_all(music: search_result[0])
return
        }
//        print(self.audioPlayer.player?.status)
        if self.audioPlayer.player?.rate==0{
            self.audioPlayer.player?.play()
                 play_button.setBackgroundImage(pause_image, for: .normal)
        }
        else{
            self.audioPlayer.player?.pause()
                  play_button.setBackgroundImage(start_image, for: .normal)
        }
    }
    
    func get_the_music(){
    
        eHttp.onSearch(url: "https://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite"){
            result,errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let result = result{
                self.search_result=result
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
    }
    
    @IBAction func Next_song(_ sender: UIButton) {
    get_the_music()
        Play_all(music: self.search_result[0])
    }
    override func viewDidLoad() {
        get_the_music()
        if self.search_result.count>0{
            Play_all(music: self.search_result[0])
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func Play_all(music:Music){
        //        如果在缓存中存在
        let image_url=music.image_url
        let song_url=music.play_url
        
        let artist_name=music.artist
        let song_name=music.name
        
        if let image=self.image_cache[image_url] as UIImage?{
            self.iv.image=image
            print("从缓存中取得")
        }
        else{
            print("重新下载")
            let image_url=URL(string:image_url)
            let request:URLRequest=URLRequest(url:image_url!)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: { (response:URLResponse?, data:Data?, error:Error?)-> Void in
                if let image=UIImage(data: data!){
                    self.iv.image=image
                }
            })
        }
            var var_url=song_url
            let off5=song_url.index(of: ":")
            var_url.insert("s", at: off5!)
            self.audioPlayer.entersFullScreenWhenPlaybackBegins = false
            self.audioPlayer.exitsFullScreenWhenPlaybackEnds = false
            //        present(self.audioPlayer, animated: true, completion: nil)
            let urls=URL(string: var_url)
            
            if let urls = urls {
                let play_item=AVPlayerItem(url: urls)
                let player=AVPlayer(playerItem: play_item)
                let duration:CMTime=play_item.asset.duration
                let seconds:Float64=CMTimeGetSeconds(duration)
                
                playslider.maximumValue=Float(seconds)
                playslider.minimumValue=0
                playslider.isContinuous=false
                self.audioPlayer.player=player
                
                player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1,1), queue: DispatchQueue.main){
                    (CMTime) -> Void in
                    if self.audioPlayer.player?.currentItem?.status == .readyToPlay{
                        let current_time=CMTimeGetSeconds(self.audioPlayer.player!.currentTime())
                        self.playslider.value=Float(current_time)
                        let all:Int=Int(current_time)
                        let mins=Int(all/60)%60
                        let second=all%60
                        let times=String.init(format: "%02d:%02d",mins,second)
                        //                    print(times)
                        self.play_time.text=times
                    }
                }
                player.play()
            }
            else{
                return
            }
        self.artist_name.text=artist_name
        self.song_name.text=song_name
//        let image=
        self.play_button.setBackgroundImage(pause_image, for: .normal)
        }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//extension DoubanViewController:UITableViewDelegate,UITableViewDataSource{
//    //设置数据
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        print("choose")
//        let cell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "douban")
//        let rowdata:Music=self.search_result[indexPath.row]
//
//        let name=rowdata.name
//        let artist=rowdata.artist
//        //        iamge
//        cell.textLabel?.text="歌名:\(name)"
//        cell.detailTextLabel?.text="创作者:\(artist)"
//
//        let image=self.image_cache[rowdata.image_url] as UIImage?
//
//        if image == nil{
//            let image_url=URL(string:self.search_result[indexPath.row].image_url)
//            let request:URLRequest=URLRequest(url:image_url!)
//            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: { (response:URLResponse?, data:Data?, error:Error?)-> Void in
//                let image=UIImage(data:data!)
//                cell.imageView?.image=image
//            self.image_cache[rowdata.image_url]=image
//                        self.onSetImage(url: self.search_result[0].image_url)
//            //            self.tv.reloadData()
//                    })
//        }
//        else{
//            cell.imageView?.image=image
//        }
//
////        onSetAudio(url: music_url)
//
//        return cell
//    }
//    //返回数据的行数
//    func tableView(_ tableView:UITableView,numberOfRowsInSection section:Int)->Int{
//        return search_result.count
//    }
//    //选择数据时响应的方法
//    func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
//        print("选择了第\(indexPath.row)行")
//        let url = self.search_result[indexPath.row].play_url
//        onSetAudio(url: url)
//    }
//}
