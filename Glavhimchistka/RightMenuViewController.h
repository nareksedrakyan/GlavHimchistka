//
//  RightMenuViewController.h
//  Glavhimchistka
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end
