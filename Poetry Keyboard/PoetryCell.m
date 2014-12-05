//
//  PoetryCell.m
//  Poetry Keyboard
//
//  Created by Paolo Furlan on 05/12/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PoetryCell.h"

@implementation PoetryCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        self.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
        self.backgroundColor=[UIColor whiteColor];
        
        _lblNumber=[[UILabel alloc] initWithFrame:CGRectMake(20, self.frame.size.height/2-10, 20, 20)];
        _lblNumber.backgroundColor=[UIColor colorWithRed:84.0/255.0 green:147.0/255.0 blue:233.0/255.0 alpha:1.0];
        _lblNumber.layer.cornerRadius=10.0;
        _lblNumber.layer.masksToBounds=YES;
        _lblNumber.textColor=[UIColor whiteColor];
        _lblNumber.textAlignment=NSTextAlignmentCenter;
        _lblNumber.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
        [self addSubview:_lblNumber];
        
        _lblDesc=[[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.frame.size.width-60, self.frame.size.height)];
        _lblDesc.backgroundColor=[UIColor clearColor];
        _lblDesc.textColor=[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0];
        _lblDesc.textAlignment=NSTextAlignmentLeft;
        _lblDesc.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
        [self addSubview:_lblDesc];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end