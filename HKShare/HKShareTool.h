//
//  HKShareTool.h
//  HKShare
//
//  Created by tony.kang on 2017/9/5.
//  Copyright © 2017年 tony.kang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HKShareTypeFacebook = 0,
    HKShareTypeTwitter,
    HKShareTypeWechatSession,
    HKShareTypeWechatMoment,
    HKshareTypeTencent,
    HKShareTypeSinaWeibo
} HKShareType;

@interface HKShareTool : NSObject

+ (instancetype)shareInstance;
- (void)shareImageWithImageName:(NSString *)imageName ShareType:(HKShareType)shareType ViewController:(UIViewController *)viewController;
- (void)shareLinkWithUrlStr:(NSString *)urlStr shareType:(HKShareType)shareType ViewController:(UIViewController *)viewController;

@end
