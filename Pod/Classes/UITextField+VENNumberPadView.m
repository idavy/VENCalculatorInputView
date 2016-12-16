//
//  UITextField+VENNumberPadView.m
//  Keyboard
//
//  Created by FangWei on 16/5/23.
//  Copyright © 2016年 Dave. All rights reserved.
//

#import "UITextField+VENNumberPadView.h"
#import "VENNumberPadTextField.h"
#import "UITextField+VENCalculatorInputView.h"

@implementation UITextField (VENNumberPadView)
- (void)setupNumberPadView:(BOOL)isShow
{
    if (!isShow) {
        self.inputView = nil;
        [self removeObserver:self forKeyPath:@"selectedTextRange"];
        [self removeTarget:self action:@selector(editingAction) forControlEvents:UIControlEventAllEvents];
    }
    else {
        if (self.inputView) {
            return;
        }
        
        [self addObserver:self forKeyPath:@"selectedTextRange" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [self addTarget:self action:@selector(editingAction) forControlEvents:UIControlEventAllEvents];
        
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
            if ([key isEqualToString:[WeakSelf negativeSign]]) {
                if ([WeakSelf.text containsString:[WeakSelf negativeSign]]) {
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"selectedTextRange"])
    {
        [self editingAction];
    }
}
- (void)editingAction
{
    NumberPadView *inputView = (NumberPadView *)self.inputView;
    [inputView showDotSign];
    if (self.text.length == 0) {
        [inputView showNegativeSign];
    }
    else {
        if ([self.text containsString:[self negativeSign]]) {
            [inputView showDotSign];
        }
        else {
            NSRange range = [self selectedNSRange];
            if (range.location == 0) {
                [inputView showNegativeSign];
            }
        }
    }
}
- (NSString *)negativeSign {
    return @"-";
}


- (BOOL)observerKeyPath:(NSString *)key
{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath]) {
            return YES;
        }
    }
    return NO;
}

- (void)dealloc
{
    if ([self observerKeyPath:@"selectedTextRange"]) {
        [self removeObserver:self forKeyPath:@"selectedTextRange"];
    }
}
@end
