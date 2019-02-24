//
//  Person+Actor.m
//  Runtime-Demo
//
//  Created by 李希朋 on 2019/2/23.
//  Copyright © 2019 lxp. All rights reserved.
//

#import "Person+Actor.h"
#import <objc/runtime.h>
static const char* key = "actingSkill";
@implementation Person (Actor)

-(void)setActingSkill:(float)actingSkill {
    NSNumber *actingSkillObjc = [NSNumber numberWithFloat:actingSkill];
    objc_setAssociatedObject(self, key, actingSkillObjc, OBJC_ASSOCIATION_RETAIN);
}

-(float)actingSkill {
    NSNumber *actingSkillObjc = objc_getAssociatedObject(self, key);
    return [actingSkillObjc floatValue];
}

@end
