//
//  WTAlertView.h
//  WTAlertView
//
//  Created by wendiaoxu on 16/3/17.
//  Copyright © 2016年 wendiaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, WTAlertActionStyle) {
    WTAlertActionStyleDefault = 0,
    WTAlertActionStyleCancel,
};


#pragma mark - WTAlertAction
@interface WTAlertAction : NSObject

typedef void(^action)(WTAlertAction *action);

+(instancetype)alertActionWithTitle:(NSString *)title andActionStyle:(WTAlertActionStyle)actionStyle andAction:(action)action;

@end








#pragma mark - WTAlertView
typedef void(^buttonActions)(NSMutableArray *actions);
typedef void(^showWTView)(UIAlertController *alertC);

@interface WTAlertView : NSObject

+(instancetype)alertViewWithTitle:(NSString *)title Message:(NSString *)message ButtonActions:(buttonActions)actions showWTView:(showWTView)alertController;


@end
