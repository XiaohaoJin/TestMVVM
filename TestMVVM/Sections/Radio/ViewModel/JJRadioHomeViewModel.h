//
//  JJRadioHomeViewModel.h
//  MVVMTest
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJBaseViewModel.h"
#import "JJRadioHomeModel.h"

#define imageArrayFileName @"RadioHomeLiscoverListImageDataArray.archiver"
#define dataArrayFileName @"RadioHomeListDataArray.archiver"

@interface JJRadioHomeViewModel : JJBaseViewModel

Strong_Property(NSMutableArray<JJRadioHomeModel *>, dataArray);
Strong_Property(NSMutableArray<NSString *>, imageArray);

@end
