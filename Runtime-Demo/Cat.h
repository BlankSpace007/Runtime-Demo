//
//  Cat.h
//  Runtime-Demo
//
//  Created by drore on 2019/2/26.
//  Copyright © 2019 lxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
@interface Cat : NSObject
{
    @public
    int _age;

}
@property(nonatomic, copy)NSString* name;

@property(nonatomic, copy)NSString *breed;

@property(nonatomic, copy)NSString* style;

@end


