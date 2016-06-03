//
//  UtilsMacro.h
//  NewProject
//
//  Created by 金晓浩 on 16/5/11.
//  Copyright © 2016年 XiaoHaoJin. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h



/* 获取iOS系统版本号*/
#define IS_IOS_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
// 判断当前系统版本是否是 7.0
#define IsIOS7_Or_Latter                    ([[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0?1:0)
#define IsIOS8_Or_Latter                    ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0?1:0)

// CFBundleVersion，标识（发布或未发布）的内部版本号  CFBundleShortVersionString  标识应用程序的发布版本号。
#define XYAppBundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/** 屏幕的宽度是6Plus或者更宽 */
#define ScreenWidthIs_6Plus_OrWider [UIScreen mainScreen].bounds.size.width >= 414

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
// 获取UIApplication 代理对象
#define ApplicationDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define NoticDefaultCenter                  [NSNotificationCenter defaultCenter]
#define UserDefaults

#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define SelfNavBar                          self.navigationController.navigationBar
#define SelfTabBar                          self.tabBarController.tabBar
#define SelfNavBarHeight                    self.navigationController.navigationBar.bounds.size.height
#define SelfTabBarHeight                    self.tabBarController.tabBar.bounds.size.height
#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define SelfDefaultToolbarHeight            self.navigationController.navigationBar.frame.size.height

/**
  #ifdef语句1
  //程序2
  #endif
  可翻译为：如果宏定义了语句1则执行程序2。
 */
/** NSLog的包装 */
#ifdef DEBUG

#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else
#define DLog( s, ... )
#endif

/* 设置UI属性 */
// 加载图片
#define LOAD_IMAGE(exp) [UIImage imageNamed:exp]
// 设置 font
#define LOAD_FONTSIZE(exp) [UIFont systemFontOfSize:exp]
// 加载color
#define LOAD_COLOR(exp) [UIColor colorWithHexString:exp]

#define HEX(string) [UIColor colorWithHexString:string]
//Image
#define UNCACHE_IMAGE(iamgeName)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iamgeName ofType:@"png"]]

#define kImgName(name) [UIImage imageNamed:name]


/* 颜色相关 */
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define UI_COLOR_FROM_RGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

//自定义字体
#define kDINBold(font) [UIFont fontWithName:@"DIN-Bold" size:font]
#define kDINMedium(font) [UIFont fontWithName:@"DIN-Medium" size:font]
#define kDINRegular(font) [UIFont fontWithName:@"DIN-Regular" size:font]
#define kNeoSansStdBold(font) [UIFont fontWithName:@"NeoSansStd-Bold" size:font]

/* 字符串 */
/** 格式化字符串的包装 */
#define FormatString( format, ... ) [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define NSStringFromInt(intValue) [NSString stringWithFormat:@"%d",intValue]
// 判断字符串是否为空
#define kIsNull(exp) ((exp == nil || exp == NULL || ([exp isKindOfClass:[NSString class]] && [exp length] == 0))?1:0)
// 判断两个字符串是否相等
#define kProtocol(p1, p2) ([p1 isEqualToString:p2])

//网络请求状态
#define kResponseStatus        [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"Status"]]
#define kResponseStatusFlag    [kResponseStatus isEqualToString:@"0"]?YES:NO

// 判断返回正误码
#define kMessBool(b) (b? @"true":@"false")
#define kProBool(p) (p? @"1":@"0")

/* 尺寸 */
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define RectMaxX(f)                         CGRectGetMaxX(f)
#define RectMaxY(f)                         CGRectGetMaxY(f)
#define RectMinX(f)                         CGRectGetMinX(f)
#define RectMinY(f)                         CGRectGetMinY(f)
#define RectX(f)                            f.frame.origin.x
#define RectY(f)                            f.frame.origin.y
#define RectWidth(f)                        f.bounds.size.width
#define RectHeight(f)                       f.bounds.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)
#define TabBarHeight                        49.0f
#define NaviBarHeight                       44.0f

/* 声明属性 */
#define Strong_Property(type, name) @property (nonatomic, strong) type *name;
#define Copy_Property(type, name) @property (nonatomic, copy) type *name;
#define Block_Property(type, name) @property (nonatomic, copy) type name;
#define Weak_Property(type, name) @property (nonatomic, weak) type *name;
#define Delegate_Property(delegateName,name)   @property (nonatomic, weak) id<delegateName> name;
#define Assign_Property(type, name) @property (nonatomic, assign) type name;

#define UITableView_Property(name) @property (nonatomic, strong) UITableView *name;
#define UIButton_Property(name) @property (nonatomic, strong) UIButton *name;
#define UILabel_Property(name) @property (nonatomic, strong) UILabel *name;

#define NSDictionary_Property(name) @property (nonatomic, strong) NSDictionary *name;
#define NSArray_Property(name) @property (nonatomic, strong) NSArray *name;
#define NSMutableArray_Property(name) @property (nonatomic, strong) NSMutableArray *name;
#define NSString_Property(name) @property (nonatomic, copy) NSString *name;
#define NSInteger_Property(name) @property (nonatomic, assign) NSInteger name;
#define NSUInteger_Property(name) @property (nonatomic, assign) NSUInteger name;
#define BOOL_Property(name) @property (nonatomic, assign) BOOL name;
#define CGFloat_Property(name) @property (nonatomic, assign) CGFloat name;


// 初始化属性
#define initNSArray(obj) obj = [NSArray array]
#define initNSMutableArray(obj) obj = [NSMutableArray array]

/** 弱引用 */
#define WS __weak typeof(self) weakSelf = self
#define WeakObj(obj) __weak typeof(obj) weakObj = obj
/** 强引用 */
#define SWS __weak typeof(weakSelf) strongSelf = weakSelf
#define StrongObj(obj) __strong typeof(obj) strongObj = obj


#import <UIKit/UIKitDefines.h>
// 检测 window的通知
//UIKIT_EXTERN NSString *const UIWindowDidBecomeVisibleNotification; // 当window激活时并展示在界面的时候触发，返回空
//UIKIT_EXTERN NSString *const UIWindowDidBecomeHiddenNotification;  // 当window隐藏的时候触发，暂时没有实际测，返回空
//UIKIT_EXTERN NSString *const UIWindowDidBecomeKeyNotification;     // 当window被设置为keyWindow时触发，返回空
//UIKIT_EXTERN NSString *const UIWindowDidResignKeyNotification;     // 当window的key位置被取代时触发，返回空
//// 检测键盘的通知
//UIKIT_EXTERN NSString *const UIKeyboardWillShowNotification;
//UIKIT_EXTERN NSString *const UIKeyboardDidShowNotification;
//UIKIT_EXTERN NSString *const UIKeyboardWillHideNotification;
//UIKIT_EXTERN NSString *const UIKeyboardDidHideNotification;
//UIKIT_EXTERN NSString *const UIKeyboardWillChangeFrameNotification  NS_AVAILABLE_IOS(5_0);
//UIKIT_EXTERN NSString *const UIKeyboardDidChangeFrameNotification   NS_AVAILABLE_IOS(5_0);

#endif /* UtilsMacro_h */
