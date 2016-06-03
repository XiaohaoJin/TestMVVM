//
//  JJRadioPlayerViewModel.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/15.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJBaseViewModel.h"
#import "JJRadioPlayerModel.h"

@interface JJRadioPlayerViewModel : JJBaseViewModel

Copy_Property(NSString, tingID)
Copy_Property(NSString, imageUrl)
Copy_Property(NSString, musicUrl)

@end
