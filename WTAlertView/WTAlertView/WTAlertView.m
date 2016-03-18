//
//  WTAlertView.m
//  WTAlertView
//
//  Created by wendiaoxu on 16/3/17.
//  Copyright © 2016年 wendiaoxu. All rights reserved.
//

#import "WTAlertView.h"



#pragma mark - WTAlertAction
@interface WTAlertAction ()
@property (nonatomic , strong) NSString *title;
@property (nonatomic) WTAlertActionStyle actionStyle;
@property (nonatomic , strong) action action;

@end

@implementation WTAlertAction

-(instancetype)init
{
    if (self = [super init]) {
        self.title = [[NSString alloc]init];
    }
    return self;
}
+(instancetype)alertActionWithTitle:(NSString *)title andActionStyle:(WTAlertActionStyle)actionStyle andAction:(action)action
{
    WTAlertAction *alt = [[WTAlertAction alloc]init];
    alt.title = title;
    alt.actionStyle = actionStyle;
    alt.action = action;
    return alt;
}
@end






#pragma mark - WTAlertView
@interface WTAlertView ()<UIAlertViewDelegate>

@property (nonatomic , strong) WTAlertView *alertView;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *message;
@property (nonatomic , strong) NSMutableArray *actions;
@property (nonatomic , strong) showWTView alertC;
@end

@implementation WTAlertView

-(instancetype)init
{
    if (self = [super init]) {
        self.title = [[NSString alloc]init];
        self.message = [[NSString alloc]init];
        self.actions = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)setAlertC:(showWTView)alertC
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        [self performAlertViewController:alertC];
    }
    else{
        [self performAlertView];
    }
}
+(instancetype)alertViewWithTitle:(NSString *)title Message:(NSString *)message ButtonActions:(buttonActions)actions showWTView:(showWTView)alertController
{
    WTAlertView *wt = [[WTAlertView alloc]init];
    wt.alertView = wt;
    wt.title = title;
    wt.message = message;
    actions(wt.actions);
    wt.alertC = alertController;
    
    return wt;
}


#pragma mark - 使用UIAlertViewController
-(void)performAlertViewController:(showWTView)alertC
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:UIAlertControllerStyleAlert];
    for (WTAlertAction *obj in self.actions) {
        UIAlertAction *objAction = [UIAlertAction actionWithTitle:obj.title style:(NSInteger)obj.actionStyle handler:^(UIAlertAction * _Nonnull action) {
            obj.action(obj);
        }];
        [alert addAction:objAction];
    }
    alertC(alert);
}


#pragma mark - 使用UIAlertView
-(void)performAlertView
{
    NSMutableString *cancelStr = [[NSMutableString alloc]init];
    NSException *e = [NSException exceptionWithName:@"NSInternalInconsistencyException" //给异常取一个名字
                                             reason:@"'WTAlertAction can only have one action with a style of WTAlertActionStyleCancel'" //异常被触发的原因
                                           userInfo:nil];//这个写nil就可以
    int cancelCount = 0;
    WTAlertAction *cancelObj = nil; //获取“取消”的对象
    @try {
        for (WTAlertAction *obj in self.actions) {

            if (obj.actionStyle == WTAlertActionStyleCancel) {
                [cancelStr setString:obj.title];
                cancelObj = obj;
                cancelCount ++;
            }
            if (cancelCount >= 2) {
                //如果有两个WTAlertActionStyleCancel 则抛出异常，
                @throw e;
            }
        }

    }
    @catch (NSException *exception) {
        @throw exception; //抛出抓到的异常
    }
    @finally {
        if (cancelCount == 0) {
            cancelStr = nil;
        }
        else if (cancelCount == 1){
            [self.actions removeObject:cancelObj];//移除数组原有的"取消"对象
            [self.actions insertObject:cancelObj atIndex:0];//将"取消"对象移动到数组开头
        }
            
    }
    
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:self.title message:self.message delegate:self cancelButtonTitle:cancelStr otherButtonTitles:nil];
        

    for (int i = 0; i < self.actions.count; i++) {
        WTAlertAction *obj = self.actions[i];
        if (obj.actionStyle != WTAlertActionStyleCancel) {
            [alt addButtonWithTitle:obj.title];
        }
    }

    [alt show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    WTAlertAction *obj = self.actions[buttonIndex];
    obj.action(obj);
}



@end
