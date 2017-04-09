//
//  SecondViewController.m
//  FTLeaks
//
//  Created by Glasses on 08/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "SecondViewController.h"
#import "Testing2View.h"
#import <FBRetainCycleDetector.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  Testing2View *view = [[Testing2View alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  view.backgroundColor = [UIColor redColor];
  [self.view addSubview:view];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    view.mocking = @"mocking";
  });
  
    // Do any additional setup after loading the view.
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
