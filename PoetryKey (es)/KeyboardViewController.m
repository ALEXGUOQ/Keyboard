//
//  KeyboardViewController.m
//  PoetryKey
//
//  Created by Paolo Furlan on 02/12/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "KeyboardViewController.h"
#import "PFPoetryCell.h"
#import "AYUIButton.h"

@interface KeyboardViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSTimer *myTimer;
    
    NSArray *arrayPoetry;
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
                 @"Aenean lacinia bibendum nulla sed consectetur. Maecenas sed diam eget risus varius blandit sit amet non magna.",
                 @"Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Nullam id dolor id nibh ultricies vehicula ut id elit.",
                 @"Curabitur blandit tempus porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id elit non mi porta gravida at eget metus. Etiam porta sem malesuada magna mollis euismod.",
                 @"Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Nullam id dolor id nibh ultricies vehicula ut id elit. Vestibulum id ligula porta felis euismod semper. Aenean lacinia bibendum nulla sed consectetur. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
                 @"Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec ullamcorper nulla non metus auctor fringilla. Etiam porta sem malesuada magna mollis euismod. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Vestibulum id ligula porta felis euismod semper. Vestibulum id ligula porta felis euismod semper.",
                 @"Donec ullamcorper nulla non metus auctor fringilla. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Nullam quis risus eget urna mollis ornare vel eu leo. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Nullam quis risus eget urna mollis ornare vel eu leo. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
                 nil];
    
    [self loadGraphics];
}

-(void)loadGraphics
{
    UITableView *table=[self tableviewPoetry];
    [self.view addSubview:table];
    
    UIView *vBottom=[self viewBottom];
    [self.view addSubview:vBottom];
}


#pragma mark - Scrollview
-(UITableView *)tableviewPoetry
{
    UITableView *t=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
    t.backgroundColor=[UIColor clearColor];
    t.showsVerticalScrollIndicator=NO;
    t.delegate=self;
    t.dataSource=self;
    
    return t;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayPoetry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [arrayPoetry objectAtIndex:indexPath.row]] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGRect rect = [attributed boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, CGFLOAT_MAX)
                                           options:NSStringDrawingTruncatesLastVisibleLine
                                           context:nil];
    CGSize size = rect.size;
    
    
    return size.height+20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat
{
    PFPoetryCell *cell=(PFPoetryCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell){
        cell=[[PFPoetryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    
    [cell setLabel:[NSString stringWithFormat:@"%@", [arrayPoetry objectAtIndex:indexPat.row]] withFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%@", [arrayPoetry objectAtIndex:indexPath.row]]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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