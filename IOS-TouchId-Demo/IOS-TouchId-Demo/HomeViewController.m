//
//  HomeViewController.m
//  IOS-TouchId-Demo
//
//  Created by 高帅 on 17/3/6.
//  Copyright © 2017年 高帅. All rights reserved.
//

#import "HomeViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onclickButton:(id)sender {
    //新建LAContext实例
    LAContext  *authenticationContext= [[LAContext alloc]init];
    NSError *error;
    //1:检查Touch ID 是否可用
    if ([authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"touchId 可用");
        //2:执行认证策略
        [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"需要验证您的指纹来确认您的身份信息" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"通过了Touch Id指纹验证");
            }else{
                NSLog(@"error===%@",error);
                NSLog(@"code====%d",error.code);
                 NSLog(@"errorStr ======%@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
                if (error.code == -2) {//点击了取消按钮
                    NSLog(@"点击了取消按钮");
                }else if (error.code == -3){//点输入密码按钮
                    NSLog(@"点输入密码按钮");
                }else if (error.code == -1){//连续三次指纹识别错误
                    NSLog(@"连续三次指纹识别错误");
                }else if (error.code == -4){//按下电源键
                    NSLog(@"按下电源键");
                }else if (error.code == -8){//Touch ID功能被锁定，下一次需要输入系统密码
                    NSLog(@"Touch ID功能被锁定，下一次需要输入系统密码");
                }
                NSLog(@"未通过Touch Id指纹验证");
            }
        }];
    }else{
        //todo goto 输入密码页面
        NSLog(@"error====%@",error);
        NSLog(@"抱歉，touchId 不可用");
    }
}





@end
