//
//  PoetryCell.h
//  Poetry Keyboard
//
//  Created by Paolo Furlan on 02/12/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoetryCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblPoetry;

-(void)setLabel:(NSString *)text withFrame:(CGRect)frame;

@end