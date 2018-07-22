# 期末项目

## 图片浏览器

功能要求: 

根据拖动滑动条来改变图片的浏览顺序

根据图片的改变动态改变图片的文字描述

增加一个滑动条实现图片的放大和缩小

实现夜间模式和白天模式的切换

## 天气预报
功能要求:
全国一些城市的天气预报显示
通过搜索输入框来进行天气查询，可支持全球3万多城市的天气查询
支持拼音查询，汉字查询
支持详细内容查询，点击cell跳转进入详细内容的显示，有风速，风向，体感温度，实际温度，湿度，气压等详细数据的显示
###新知天气

https://api.seniverse.com/v3/weather/now.json?key=gf1eymq6ekmdcys8&location=%E6%B5%8E%E5%8D%97&language=zh-Hans&unit=c

##私人豆瓣fm
实现音乐播放器功能:歌曲名，演唱者，图片显示，切换歌曲，拖动进度条功能
采用豆瓣FM接口，可以向用户随机推荐歌曲。如果不喜欢即可切换下一首

api：

https://douban.fm/j/mine/playlist?type=n&channel=1&from=mainsite

https://douban.com/j/app/radio/channels

### 主界面

viewcontroller    是播放界面

channelcontroller  是显示列表的界面

从viewcontroller按button跳转过去

controller.swift和storyboard的联系

- 在storyboard中添加的按钮可以在controller中添加响应事件
- @IBoutlet应该是没什么卵用吧

Outlets let you refer to your interface elements in code, but you still need a way to respond whenever the user interacts with the elements. That’s where actions come in. 

#### api

查看channel的种类

https://www.douban.com/j/app/radio/channels

请求channel  每次一首歌

https://douban.fm/j/mine/playlist?type=n&channel=1&from=mainsite

channel=1为channel的参数

加搜索关键字

https://douban.fm/j/explore/search?query=%E5%BC%A0%E6%9D%B0&limit=20&start=0


3. 图片排列
根据选择的行数不同来排列不同的图片
实现视频上的要求
4. 浏览器，访问苹果官网的首页


