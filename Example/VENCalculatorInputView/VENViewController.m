//
//  VENViewController.m
//  VENCalculatorInputView
//
//  Created by Davy on 03/10/2016.
//  Copyright (c) 2016 Davy. All rights reserved.
//

#import "VENViewController.h"
#import "VENCalculatorInputTextField.h"
#import "VENNumberPadTextField.h"

@interface VENViewController ()

@end

@implementation VENViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	VENNumberPadTextField *tf = [[VENNumberPadTextField alloc]init];
	tf.backgroundColor = [UIColor redColor];
	tf.frame = CGRectMake(10, 100, 100, 30);
	[self.view addSubview:tf];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
