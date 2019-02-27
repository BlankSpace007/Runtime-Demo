//
//  Person.h
//  Runtime-Demo
//
//  Created by drore on 2019/2/20.
//  Copyright © 2019 lxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayProtocol.h"

@interface Person : NSObject<PlayProtocol>

@property(nonatomic,copy)NSString* name;

@end

