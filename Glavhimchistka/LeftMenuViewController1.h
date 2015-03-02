//
//  LeftMenuViewController1.h
//  Glavhimchistka
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "SlideNavigationController.h"
#import <UIKit/UIKit.h>
#import "RootTableViewCell.h"

@interface LeftMenuViewController1 : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)IBOutlet UITableView*leftTableView1;
@end
