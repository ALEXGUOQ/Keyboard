//
//  PoetryCell.m
//  Poetry Keyboard
//
//  Created by Paolo Furlan on 02/12/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFPoetryCell.h"

@implementation PFPoetryCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setLabel:(NSString *)text withFrame:(CGRect)frame
{
    self.backgroundColor=[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    self.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);

    if(!_lblPoetry){
        _lblPoetry=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];
        _lblPoetry.textColor=[UIColor whiteColor];
        _lblPoetry.backgroundColor=[UIColor clearColor];
        _lblPoetry.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
        _lblPoetry.textAlignment=NSTextAlignmentCenter;
        _lblPoetry.numberOfLines=-1;
        _lblPoetry.lineBreakMode=NSLineBreakByTruncatingTail;
        [self addSubview:_lblPoetry];
    }
    
    _lblPoetry.text=text;
    [_lblPoetry sizeToFit];
    
    CGRect frame2=_lblPoetry.frame;
    frame2.origin.x=frame.size.width/2-_lblPoetry.frame.size.width/2;
    _lblPoetry.frame=frame2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end