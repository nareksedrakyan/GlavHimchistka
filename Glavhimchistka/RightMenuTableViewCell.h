//
//  RightMenuTableViewCell.h
//  Glavhimchistka
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightMenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *underView;
@property (weak, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@end
