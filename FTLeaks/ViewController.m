//
//  ViewController.m
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "FTLeakObjectA.h"
#import "FTLeakObjectB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  FTLeakObjectA *obja = [[FTLeakObjectA alloc] init];
  FTLeakObjectB *objb = [[FTLeakObjectB alloc] init];
  obja.objb = objb;
  objb.obja = obja;
//  char *buf1 = @encode(int **);
//  printf("%s",buf1);
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  SecondViewController *second = [[SecondViewController alloc] init];
  [self.navigationController pushViewController:second animated:YES];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
