//
//  LoginItem.h
//  Silent But Deadly
//
//  Created by Alexandre on 08/05/13.
//  Copyright (c) 2013 dcgod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginItem : NSObject

+ (BOOL)willStartAtLogin;
+ (void)setStartAtLogin:(BOOL)enabled;

@end
