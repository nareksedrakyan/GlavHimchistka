//
//  CustomView.h
//  Glavhimchistka
//
//  Created by Admin on 15.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "CustomLabel.h"
#import <UIKit/UIKit.h>

@interface CustomView : UIView
@property (weak, nonatomic) IBOutlet CustomLabel *typeOfMessageLabel;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UIButton *SendButton;


@end
