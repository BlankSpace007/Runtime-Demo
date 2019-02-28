//
//  SingProtocol.h
//  Runtime-Demo
//
//  Created by drore on 2019/2/28.
//  Copyright © 2019 lxp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SingProtocol <NSObject>

@required
-(void)singFolkSongs;
+(void)singRockSongs;
@property(nonatomic,copy)NSString* folkSongs;
@property(nonatomic,copy,class)NSString* rockSongs;
@optional
-(void)singPopularSongs;
+(void)singMetalSongs;
@property(nonatomic,copy)NSString* popularSongs;
@property(nonatomic,copy,class)NSString* metalSongs;

@end

