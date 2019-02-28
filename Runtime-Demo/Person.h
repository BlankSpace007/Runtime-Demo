//
//  Person.h
//  Runtime-Demo
//
//  Created by drore on 2019/2/20.
//  Copyright © 2019 lxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayProtocol.h"
#import "EatProtocol.h"
@interface Person : NSObject<PlayProtocol,EatProtocol>

@property(nonatomic,copy)NSString* name;

@end

