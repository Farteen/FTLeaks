//
//  UIResponder+ResponderChain.h
//  FTLeaks
//
//  Created by Glasses on 08/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (ResponderChain)

- (UIViewController *)nearestViewController;

- (UINavigationController *)nearestNavigationController;

@end
