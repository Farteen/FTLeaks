//
//  FTLeakObjectB.h
//  FTLeaks
//
//  Created by Glasses on 14/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FTLeakObjectA;
@interface FTLeakObjectB : NSObject
@property (nonatomic, strong) FTLeakObjectA *obja;
@end
