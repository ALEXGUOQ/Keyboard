//
//  KeyboardViewController.m
//  PoetryKey
//
//  Created by Paolo Furlan on 02/12/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "KeyboardViewController.h"

#import "AYUIButton.h"

@interface KeyboardViewController () {
    NSTimer *myTimer;
    
    NSArray *arrayPoetry;
    
    float yBtn;
}

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewDidAppear:(BOOL)animated {
    
    arrayPoetry=[NSArray arrayWithObjects:
                 @"\"Hope\" is the thing with feathers\nThat perches in the soul\nAnd sings the tune without the words\nAnd never stops at all.",
                 @"I celebrate myself, and sing myself,\nAnd what I assume you shall assume,\nFor every atom belonging to me\nas good belongs to you.",
                 nil];
    
    [self loadGraphics];
}

-(void)loadGraphics
{
    UIScrollView *scroll=[self scrollViewPoetry];
    [self.view addSubview:scroll];
    
    UIView *vBottom=[self viewBottom];
    [self.view addSubview:vBottom];
}


#pragma mark - Scrollview
-(UIScrollView *)scrollViewPoetry
{
    UIScrollView *s=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
    s.backgroundColor=[UIColor clearColor];
    s.showsVerticalScrollIndicator=NO;
    s.showsHorizontalScrollIndicator=NO;
    
    yBtn=0;
    for (int i=0; i<arrayPoetry.count; i++) {
        AYUIButton *btn=[self buttonPoetry:i];
        btn.tag=i;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [s addSubview:btn];
        [s setContentSize:CGSizeMake(s.frame.size.width, btn.frame.size.height+btn.frame.origin.y)];
    }
    
    return s;
}


-(AYUIButton *)buttonPoetry:(int)index
{
    AYUIButton *b=[[AYUIButton alloc] init];
    [b setBackgroundColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [b setBackgroundColor:[UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    b.contentEdgeInsets=UIEdgeInsetsMake(10, 10, 10, 10);
    b.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    b.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    
    NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [arrayPoetry objectAtIndex:index]] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGRect rect = [attributed boundingRectWithSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           context:nil];
    CGSize size = rect.size;
    
    [b setAttributedTitle:attributed forState:UIControlStateNormal];
    
    [b.titleLabel setNumberOfLines:-1];
    
    CGRect frame=b.frame;
    frame.origin.x=0;
    frame.origin.y=yBtn+1;
    frame.size.width=self.view.frame.size.width;
    frame.size.height=size.height+20;
    b.frame=frame;
    
    yBtn=b.frame.origin.y+b.frame.size.height;
    
    return b;
}


#pragma mark - Button pressed
-(void)buttonPressed:(AYUIButton *)btn
{
    int tag=(int)(btn.tag);
    
    [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%@", [arrayPoetry objectAtIndex:tag]]];
}

#pragma mark - Bottom part
-(UIView *)viewBottom
{
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    v.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.08];
    
    AYUIButton *btnNext=[self btnBottom:CGRectMake(10, 8, 40, 32.5)];
    UIImage *imageNext=[UIImage imageNamed:@"changeKeyboard"];
    UIImageView *imgNext=[[UIImageView alloc] initWithFrame:CGRectMake(btnNext.frame.size.width/2-imageNext.size.width/4, btnNext.frame.size.height/2-imageNext.size.height/4, imageNext.size.width/2, imageNext.size.height/2)];
    [imgNext setImage:imageNext];
    [btnNext addSubview:imgNext];
    [btnNext addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btnNext];
    
    AYUIButton *btnSpace=[self btnBottom:CGRectMake(btnNext.frame.size.width+20, 8, self.view.frame.size.width-70-(btnNext.frame.origin.x+btnNext.frame.size.width), 32.5)];
    [btnSpace setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnSpace.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [btnSpace setTitle:@"Space" forState:UIControlStateNormal];
    [btnSpace addTarget:self action:@selector(space) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btnSpace];
    
    UIButton *btnDelete=[self btnBottom:CGRectMake(self.view.frame.size.width-50, 8, 40, 32.5)];
    [btnDelete addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete addTarget:self action:@selector(deleteIsDown) forControlEvents:UIControlEventTouchDown];
    [btnDelete addTarget:self action:@selector(deleteisReleased) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *imageDelete=[UIImage imageNamed:@"delete"];
    UIImageView *imgDelete=[[UIImageView alloc] initWithFrame:CGRectMake(btnDelete.frame.size.width/2-imageDelete.size.width/4, btnDelete.frame.size.height/2-imageDelete.size.height/4, imageDelete.size.width/2, imageDelete.size.height/2)];
    [imgDelete setImage:imageDelete];
    [btnDelete addSubview:imgDelete];
    
    [v addSubview:btnDelete];
    
    return v;
}

-(AYUIButton *)btnBottom:(CGRect)frame
{
    AYUIButton *b=[[AYUIButton alloc] initWithFrame:frame];
    b.layer.cornerRadius=3.0;
    b.layer.masksToBounds=YES;
    [b setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    return b;
}


#pragma mark Control bottom
-(void)space
{
    [self.textDocumentProxy insertText:@" "];
}

-(void)delete:(id)sender {
    [self.textDocumentProxy deleteBackward];
}

- (void)deleteIsDown {
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(delete:) userInfo:nil repeats:YES];
}

- (void)deleteisReleased {
    if(myTimer){
        [myTimer invalidate];
        myTimer = nil;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}

@end