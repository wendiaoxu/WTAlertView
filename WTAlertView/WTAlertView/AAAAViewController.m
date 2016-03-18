//
//  AAAAViewController.m
//  WTAlertView
//
//  Created by wendiaoxu on 16/3/17.
//  Copyright © 2016年 wendiaoxu. All rights reserved.
//

#import "AAAAViewController.h"
#import "WTAlertView.h"

@interface AAAAViewController ()<UIAlertViewDelegate>


@end

@implementation AAAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)showAction:(UIButton *)sender {
   

    
    
    [WTAlertView alertViewWithTitle:@"title" Message:@"message" ButtonActions:^(NSMutableArray *actions) {
        
        [actions addObject:[WTAlertAction alertActionWithTitle:@"sure" andActionStyle:WTAlertActionStyleDefault andAction:^(WTAlertAction *action) {
            NSLog(@"sure");
        }]];
        [actions addObject:[WTAlertAction alertActionWithTitle:@"canncel" andActionStyle:WTAlertActionStyleCancel andAction:^(WTAlertAction *action) {
            NSLog(@"canncel");
        }]];
        [actions addObject:[WTAlertAction alertActionWithTitle:@"other" andActionStyle:WTAlertActionStyleDefault andAction:^(WTAlertAction *action) {
            NSLog(@"other");
        }]];
        
    } showWTView:^(UIAlertController *alertC) {
        [self presentViewController:alertC animated:YES completion:nil];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
