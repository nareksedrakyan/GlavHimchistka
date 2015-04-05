//
//  MailCell.h
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@end
