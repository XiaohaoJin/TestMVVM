//
//  JJRadioListModel.h
//  TestMVVM
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJRadioListModel : NSObject

Copy_Property(NSString, coverimg)
Copy_Property(NSString, tingid)
Strong_Property(NSString, title)
Copy_Property(NSString, musicUrl)

@end
