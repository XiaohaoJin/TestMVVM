//
//  NetworkInterface.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/11.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#ifndef NetworkInterface_h
#define NetworkInterface_h

//#define QA_TEST // 连接测试库时打开此行注释

// 测试库地址
#define  HOST_TEST_DAMIAN  @"http://192.168.1.250:9001/"
//正式库地址
#define  HOST_LINE_DOMAIN  @"http://api2.pianke.me/"

//获取版本号
#define kGetLastAppVersion  @"api/config/getlastappversion"

/** 发现 */
//电台详情
#define ApiDiscoverList @"ting/radio/radio_list"
#define ApiDiscoverListOfList @"ting/radio_detail"
// 播放
#define ApiRadioDetailInfo @"ting/info"

#endif /* NetworkInterface_h */
