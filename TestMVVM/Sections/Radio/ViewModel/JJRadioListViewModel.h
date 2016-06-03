//
//  JJRadioListViewModel.h
//  TestMVVM
//
//  Created by 金晓浩 on 16/6/2.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#import "JJBaseViewModel.h"
#import "JJRadioListModel.h"

#define dataArrayFileName @"JJRadioListOfListViewModelDataArrayFileName"
#define imageArrayFileName @"JJRadioListOfListViewModelImageDataArrayFileName"
#define nameArrayFileName @"JJRadioListOfListViewModelNameDataArrayFileName"

@interface JJRadioListViewModel : JJBaseViewModel

Strong_Property(NSMutableArray<JJRadioListModel *>, dataArray)
Strong_Property(NSMutableArray<NSString *>, imageArray)
Strong_Property(NSMutableArray<NSString *>, nameArray)

Copy_Property(NSString, radioID)

@end
