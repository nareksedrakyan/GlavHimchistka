//
//  AppMenu.h
//  Glavhimchistka
//
//  Created by Admin on 22.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "LeftMenuViewController1.h"
#import "LeftMenuViewController2.h"
#import "RightMenuViewController.h"

#import <Foundation/Foundation.h>

@interface AppMenu : NSObject

@property(nonatomic,strong)LeftMenuViewController1*leftMenu1;
@property(nonatomic,strong)LeftMenuViewController2*leftMenu2;
@property(nonatomic,strong)RightMenuViewController*rightMenu;
+(AppMenu*)sharedAppMenu;
+(void)setAppMenu:(id)object;
@end
