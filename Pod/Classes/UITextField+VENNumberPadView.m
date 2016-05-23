//
//  UITextField+VENNumberPadView.m
//  Keyboard
//
//  Created by FangWei on 16/5/23.
//  Copyright © 2016年 Dave. All rights reserved.
//

#import "UITextField+VENNumberPadView.h"
#import "VENNumberPadTextField.h"

@implementation UITextField (VENNumberPadView)
- (void)setupNumberPadView:(BOOL)isShow
{
    if (!isShow) {
        self.inputView = nil;
    }
    else {
        if (self.inputView) {
            return;
        }
        NumberPadView *inputView = [[NumberPadView alloc]init];
        NSLocale *locale = [NSLocale currentLocale];
        NSString *decimalSeparator = [locale objectForKey:NSLocaleDecimalSeparator];
        
        __weak typeof(self)WeakSelf = self;
        inputView.didTapKeyBlock = ^(NSString *key){
            if ([key isEqualToString:decimalSeparator]) {
                if ([WeakSelf.text containsString:decimalSeparator]) {
                    return;
                }
            }
            [WeakSelf insertText:key];
        };
        inputView.didTapBackspaceBlock = ^{
            [WeakSelf deleteBackward];
        };
        inputView.didTapDeleteBlock = ^{
            WeakSelf.text = @"";
        };
        
        self.inputView = inputView;
    }
}
@end
