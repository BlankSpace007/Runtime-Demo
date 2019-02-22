//
//  Person.h
//  Runtime-Demo
//
//  Created by drore on 2019/2/20.
//  Copyright © 2019 lxp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject
//实例方法
-(void)function1;

-(void)function2:(NSString*)p1;

-(NSString*)function3;

-(NSString*)function4:(NSString*)p1;
//类方法
+(void)classFunction1;

+(void)classFunction2:(NSString*)p1;

+(NSString*)classFunction3;

+(NSString*)classFunction4:(NSString*)p1;
@end

