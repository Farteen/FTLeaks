//
//  UIView+FTLeaksQuery.h
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTLeaksQueryProtocol.h"

@interface UIView (FTLeaksQuery)<FTLeaksQueryProtocol>


- (BOOL)isVisible;

- (BOOL)isInViewStack;



@end
