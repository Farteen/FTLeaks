//
//  NSObject+FTLeaks.h
//  FTLeaks
//
//  Created by FarTeen on 07/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTLeaksQueryProtocol.h"
@class FTLeaksAssistant;

@interface NSObject (FTLeaks)<FTLeaksQueryProtocol>

@property (nonatomic, strong) FTLeaksAssistant  *leaksAssistant;

@end
