//
//  FTLeakObjectA.h
//  FTLeaks
//
//  Created by Glasses on 14/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FTLeakObjectB;
@interface FTLeakObjectA : NSObject
@property (nonatomic, strong) FTLeakObjectB *objb;
@end
