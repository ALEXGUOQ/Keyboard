//
//  ViewController.m
//  Poetry Keyboard
//
//  Created by Paolo Furlan on 02/12/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "ViewController.h"

#import "PoetryCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *arrayDesc;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    
    arrayDesc=[NSArray arrayWithObjects:NSLocalizedString(@"Open your device Settings", nil), NSLocalizedString(@"General", nil), NSLocalizedString(@"Keyboard", nil), NSLocalizedString(@"Keyboards", nil), NSLocalizedString(@"Add new Keyboard", nil), @"PoetryKey", nil];

    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, arrayDesc.count*44)];
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.tableFooterView=[[UIView alloc] init];
    tableView.userInteractionEnabled=NO;
    tableView.layer.cornerRadius=5.0;
    tableView.layer.masksToBounds=YES;
    tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.separatorColor=[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [self.view addSubview:tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayDesc.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PoetryCell *cell=(PoetryCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell){
        cell=[[PoetryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.lblNumber.text=[NSString stringWithFormat:@"%d", (int)indexPath.row+1];
    
    cell.lblDesc.text=[NSString stringWithFormat:@"%@", [arrayDesc objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end