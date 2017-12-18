//
//  LinkHelper.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/13.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface LinkHelper<__covariant ObjectType> : NSProxy

+ (id)help:(id)target;

- (const char*)objcTypeFromValueCodeOfNSString;
- (NSArray<NSString*>*)linkCodeSplite;

@end
