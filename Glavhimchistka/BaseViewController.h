//
//  BaseViewController.h
//  Glavhimchistka
//
//  Created by Admin on 20.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "RootTableViewCell.h"
#import "LeftMenuViewController1.h"
#import "LeftMenuViewController2.h"
#import "RightMenuViewController.h"
#import "SlideNavigationController.h"

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)BOOL isRightMenuButtonHidden;
-(void)showErrorAlertWithMessage:(NSString*)messageText;
@property(nonatomic,strong)UIImageView*loader;
@property (weak, nonatomic) IBOutlet UIButton *leftMenuButton;

@property (weak, nonatomic) IBOutlet UIButton *rightMenuButton;


- (IBAction)actionVK:(UIButton *)sender;

- (IBAction)actionInstagram:(UIButton *)sender;

- (IBAction)actionTwitter:(UIButton *)sender;

- (IBAction)actionGooglePlus:(UIButton *)sender;

- (IBAction)actionFacebook:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *vkButton;

@property (weak, nonatomic) IBOutlet UIButton *instagramButton;

@property (weak, nonatomic) IBOutlet UIButton *twitterButton;

@property (weak, nonatomic) IBOutlet UIButton *googlePlusButton;

@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

@property (weak, nonatomic) IBOutlet UITableView *rootTableView;

@end
