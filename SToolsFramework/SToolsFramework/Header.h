//
//  Header.h
//  customAlert
//
//  Created by HMC on 16/7/6.
//  Copyright © 2016年 SKing. All rights reserved.
//

#ifndef Header_h
#define Header_h

// 屏幕宽度
#define  ScreenWidth   [UIScreen mainScreen].bounds.size.width

// 屏幕高度
#define  ScreenHeight  [UIScreen mainScreen].bounds.size.height



//引入问题汇总

/*
 
 ①出现  Reason: image not found 问题
        dyld: Library not loaded: @rpath/SToolsFramework.framework/SToolsFramework
        Referenced from: /Users/songjinwei/Library/Developer/CoreSimulator/Devices/DE6CD560-AC41-491B-AD90-1F25CF9DF3A2/data/Containers/Bundle/Application/835AE85B-187C-4827-B965-E6DC09BEFEEF/customAlert.app/customAlert
        Reason: image not found
  解决办法: 工程的Targets -> General -> Embedded Binaries 点击加号 添加引入的 framework 即可;
 
 
 
 
 */






#endif /* Header_h */
