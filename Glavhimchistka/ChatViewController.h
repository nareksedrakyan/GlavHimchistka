//
//  ChatViewController.h
//  Glavhimchistka
//
//  Created by Admin on 12.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"

@interface ChatViewController : BaseViewController<UITextFieldDelegate>
@property(nonatomic,strong)UITableView*messageTypesTableView;
@property (weak, nonatomic) IBOutlet UITextField *typeOfMessageTextField;
- (IBAction)sendButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;

@end
