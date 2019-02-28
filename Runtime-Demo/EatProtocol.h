//
//  EatProtocol.h
//  Runtime-Demo
//
//  Created by drore on 2019/2/28.
//  Copyright © 2019 lxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayProtocol.h"
#import "SingProtocol.h"
#import "RunProtocol.h"

@protocol EatProtocol <RunProtocol,SingProtocol,PlayProtocol>

@end

