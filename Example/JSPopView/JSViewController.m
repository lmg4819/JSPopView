//
//  JSViewController.m
//  JSPopView
//
//  Created by lmg4819 on 12/21/2018.
//  Copyright (c) 2018 lmg4819. All rights reserved.
//

#import "JSViewController.h"
#import <JSPopView/JSPopView.h>
#import "JSSecondViewController.h"


@interface JSViewController ()

@end

@implementation JSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *sender = [[UIButton alloc]init];
    sender.frame = CGRectMake(0, 0, 200, 44);
    [sender setTitle:@"弹框" forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor yellowColor];
    sender.center = self.view.center;
    [sender addTarget:self action:@selector(senderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
}

- (void)senderBtnClicked:(UIButton *)sender
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 70)];
    label.text = @"点击后车辆移除\n并为您减少推荐此类车源";
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5;
    label.font = [UIFont systemFontOfSize:18];
    label.layer.masksToBounds = YES;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
  JSPopView *popView =  [JSPopView popUpContentView:label direct:PopViewDirection_PopUpTop onView:sender offset:-60 triangleView:nil animation:YES];
    __weak typeof(self) weakSelf = self;
    popView.didRemovedFromeSuperView = ^{
        JSSecondViewController *secondVC = [[JSSecondViewController alloc]init];
        [weakSelf presentViewController:secondVC animated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
