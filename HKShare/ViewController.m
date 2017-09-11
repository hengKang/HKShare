//
//  ViewController.m
//  HKShare
//
//  Created by tony.kang on 2017/9/5.
//  Copyright © 2017年 tony.kang. All rights reserved.
//

#import "ViewController.h"
#import "HKShareTool.h"
#import <WXApi.h>
#import "WeiboSDK.h"
#import "WBHttpRequest.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Test");
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*分享链接
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"https://www.baidu.com/"];
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];*/
    
    /*分享图片
    FBSDKSharePhoto *sharePhoto = [FBSDKSharePhoto photoWithImage:[UIImage imageNamed:@"12.jpg"] userGenerated:YES];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[sharePhoto];
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];*/
    
    
    
//    if ([composer setImage:[UIImage imageNamed:@"12.jpg"]]) {
//        
//        [composer showFromViewController:self completion:^(TWTRComposerResult result) {
//            
//        }];
////    }
    HKShareTool *shareTool = [HKShareTool shareInstance];
    [shareTool shareImageWithImageName:@"13.png" ShareType:HKShareTypeSinaWeibo ViewController:self];
    
//    HKShareTool *shareTool = [HKShareTool shareInstance];
//    [shareTool shareImageWithImageName:@"13.png" ShareType:HKShareTypeWechatMoment ViewController:self];
//    HKShareTool *shareTool = [HKShareTool shareInstance];
//    [shareTool shareLinkWithUrlStr:@"http://weibo.com/p/1001603849727862021333?rightmod=1&wvr=6&mod=noticeboard" shareType:HKShareTypeSinaWeibo ViewController:self];
    
//    NSArray* permissions = [NSArray arrayWithObjects:
//                            kOPEN_PERMISSION_GET_USER_INFO,
//                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                            kOPEN_PERMISSION_ADD_SHARE,
//                            nil];
//    if ([tencentOAuth authorize:permissions]) {
//        NSLog(@"qq应用已授权");
//    }
    
//    
//        HKShareTool *shareTool = [HKShareTool shareInstance];
//        [shareTool shareLinkWithUrlStr:@"https://www.baidu.com/" shareType:HKshareTypeTencent ViewController:self];
//    WBMessageObject *message = [WBMessageObject message];
//    message.text = @"测试";
//    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//    authRequest.redirectURI = @"https://www.sina.com";
//    authRequest.scope = @"all";
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:@""];
//    [WeiboSDK sendRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
