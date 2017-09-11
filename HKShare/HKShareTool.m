//
//  HKShareTool.m
//  HKShare
//
//  Created by tony.kang on 2017/9/5.
//  Copyright © 2017年 tony.kang. All rights reserved.
//

#import "HKShareTool.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <TwitterKit/TwitterKit.h>
#import <WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"

@implementation HKShareTool

static HKShareTool *shareTool = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareTool = [[HKShareTool alloc] init];
    });
    return shareTool;
}

- (void)shareImageWithImageName:(NSString *)imageName ShareType:(HKShareType)shareType ViewController:(UIViewController *)viewController {
    
    switch (shareType) {
        case HKShareTypeFacebook:{
            FBSDKSharePhoto *sharePhoto = [FBSDKSharePhoto photoWithImage:[UIImage imageNamed:imageName] userGenerated:YES];
            FBSDKSharePhotoContent *sharePhotoContent = [[FBSDKSharePhotoContent alloc] init];
            sharePhotoContent.photos = @[sharePhoto];
            [FBSDKShareDialog showFromViewController:viewController withContent:sharePhotoContent delegate:nil];
        }
            break;
        case HKShareTypeTwitter:{
            TWTRComposer *composer = [[TWTRComposer alloc] init];
            if ([composer setImage:[UIImage imageNamed:imageName]]) {
                [composer showFromViewController:viewController completion:^(TWTRComposerResult result) { }];
            }
        }
            break;
        case HKShareTypeWechatSession:{
            WXMediaMessage *message = [WXMediaMessage message];
            [message setThumbImage:[UIImage imageNamed:imageName]];
            WXImageObject *imageObject = [WXImageObject object];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
            imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
            message.mediaObject = imageObject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
        }
            break;
        case HKShareTypeWechatMoment:{
            WXMediaMessage *message = [WXMediaMessage message];
            [message setThumbImage:[UIImage imageNamed:imageName]];
            WXImageObject *imageObject = [WXImageObject object];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
            imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
            message.mediaObject = imageObject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
        }
            break;
        case HKshareTypeTencent:{
            QQApiImageObject *imgObj = [QQApiImageObject objectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]] previewImageData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]] title:@"title" description:@"description"];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            NSLog(@"%d", sent);
        }
            break;
        case HKShareTypeSinaWeibo:{
            WBMessageObject *messageObject = [WBMessageObject message];
            WBImageObject *imageObject = [WBImageObject object];
            imageObject.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
            messageObject.imageObject = imageObject;
            WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
            authRequest.redirectURI = @"https://www.sina.com";
            authRequest.scope = @"all";
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject authInfo:authRequest access_token:@""];
            [WeiboSDK sendRequest:request];
        }
            break;
        default:
            break;
    }
}

- (void)shareLinkWithUrlStr:(NSString *)urlStr shareType:(HKShareType)shareType ViewController:(UIViewController *)viewController {
    
    switch (shareType) {
        case HKShareTypeFacebook:{
            FBSDKShareLinkContent *shareLinkContent = [[FBSDKShareLinkContent alloc] init];
            shareLinkContent.contentURL = [NSURL URLWithString:urlStr];
            [FBSDKShareDialog showFromViewController:viewController withContent:shareLinkContent delegate:nil];
        }
            break;
        case HKShareTypeTwitter:{
            TWTRComposer *composer = [[TWTRComposer alloc] init];
            if ([composer setURL:[NSURL URLWithString:urlStr]]) {
                [composer showFromViewController:viewController completion:^(TWTRComposerResult result) { }];
            }
        }
            break;
        case HKShareTypeWechatSession:{
            WXMediaMessage *message = [WXMediaMessage message];
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = urlStr;
            message.mediaObject = webpageObject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
        }
            break;
        case HKShareTypeWechatMoment:{
            WXMediaMessage *message = [WXMediaMessage message];
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = urlStr;
            message.mediaObject = webpageObject;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
        }
            break;
        case HKshareTypeTencent:{
            QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlStr] title:@"title" description:@"description" previewImageURL:nil];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObject];
            QQApiSendResultCode resultCode = [QQApiInterface sendReq:req];
            NSLog(@"%d", resultCode);
        }
            break;
        case HKShareTypeSinaWeibo:{
            WBMessageObject *messageObject = [WBMessageObject message];
            WBWebpageObject *webpage = [WBWebpageObject object];
            webpage.title = @"title";
            webpage.objectID = @"LJI";
            webpage.description = @"description";
            webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"12" ofType:@"jpg"]];
            webpage.webpageUrl = [urlStr mutableCopy];
            messageObject.mediaObject = webpage;
            WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
            authRequest.redirectURI = @"https://www.sina.com";
            authRequest.scope = @"all";
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject authInfo:authRequest access_token:@""];
            [WeiboSDK sendRequest:request];
        }
            break;
        default:
            break;
    }
}

@end
