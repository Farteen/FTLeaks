//
//  FTLeaksAssistant.h
//  FTLeaks
//
//  Created by Glasses on 08/04/2017.
//  Copyright © 2017 organization. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTObjectShadow : NSObject

/// 内存泄露的对象
@property (nonatomic, weak) id                  weakOwner;
/// 存在内存泄漏已经发送
@property (nonatomic, assign) BOOL              aliveIsSent;
@property (nonatomic, copy) NSString            *ownerName;

@end
