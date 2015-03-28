//
//  AppMenu.m
//  Glavhimchistka
//
//  Created by Admin on 22.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "AppMenu.h"
#import "AppDelegate.h"

static AppMenu *appMenu;
@implementation AppMenu

+(void)setAppMenu:(id)object
{
    appMenu=object;
}

+(AppMenu*)sharedAppMenu
{
    
    if (appMenu == nil)
    {
        
        appMenu = [[super alloc] init];
       
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle:nil];
       
        appMenu.leftMenu1=(LeftMenuViewController1*)[mainStoryboard instantiateViewControllerWithIdentifier:@"LeftMenuViewController1"];
        
        appMenu.leftMenu2=(LeftMenuViewController2*)[mainStoryboard instantiateViewControllerWithIdentifier:@"Menu2"];
        
        appMenu.rightMenu=(RightMenuViewController*)[mainStoryboard
                                                 instantiateViewControllerWithIdentifier: @"RightMenu"];
    }
    
    return appMenu;
}
@end
