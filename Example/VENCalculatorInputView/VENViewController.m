//
//  VENViewController.m
//  VENCalculatorInputView
//
//  Created by Davy on 03/10/2016.
//  Copyright (c) 2016 Davy. All rights reserved.
//

#import "VENViewController.h"
#import "VENCalculatorInputTextField.h"

@interface VENViewController ()

@end

@implementation VENViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	VENCalculatorInputTextField *tf = [[VENCalculatorInputTextField alloc]init];
	tf.backgroundColor = [UIColor redColor];
	tf.frame = CGRectMake(0, 0, 100, 30);
	[self.view addSubview:tf];
    
    NSString *path = [NSBundle mainBundle].resourcePath;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
