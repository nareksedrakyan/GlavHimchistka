//
//  ChatViewController.h
//  Glavhimchistka
//
//  Created by Admin on 12.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"

@interface ChatViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)UITableView*messageTypesTableView;
@property(nonatomic,strong,getter=getId,setter=setTitleId:)NSString*id;
@property(nonatomic,strong)NSString*message_type;
@end
