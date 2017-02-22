//
//  NumberPadTextField.m
//  Keyboard
//
//  Created by FangWei on 16/5/23.
//  Copyright © 2016年 Dave. All rights reserved.
//

#import "VENNumberPadTextField.h"

@implementation NumberPadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 53*4);
        self.clipsToBounds = YES;
        [self addViews];
    }
    return self;
}
- (void)addViews
{
    UIView *baseView = [[UIView alloc]init];
    baseView.frame = CGRectMake(-0.5, -0.5, self.bounds.size.width+1, 53*4+1);
    baseView.clipsToBounds = YES;
    [self addSubview:baseView];
    
    CGFloat width = (self.bounds.size.width+1)/3.0;
    CGFloat heigh = 53;
    
    NSArray *titleArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"0", @""];
    NSArray *imageArray = @[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"VENCalculatorIconBackspace"];
    UIImage *highlightedImage = [self.class imageWithColor:[UIColor colorWithRed:210/255.0 green:213/255.0 blue:219/255.0 alpha:1]];
    UIImage *normalImage = [self.class imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
    
    for (NSInteger i = 0; i<12; i++) {
        NSInteger x = i/3;
        NSInteger y = i%3;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1].CGColor;
        CGFloat scale = [[UIScreen mainScreen] scale];
        btn.layer.borderWidth = 0.5/scale;
        btn.frame = CGRectMake(width*y, heigh*x, width, heigh);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(userDidTapKey:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:28];
        NSString *imageName = imageArray[i];
        if (![imageName isEqualToString:@""]) {
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        }
        btn.tag = 66+i;
        [baseView addSubview:btn];
    }
    UIButton *dianBtn = (UIButton *)[baseView viewWithTag:66+9];
    UIButton *backBtn = (UIButton *)[baseView viewWithTag:66+11];
    
    [dianBtn setBackgroundImage:normalImage forState:UIControlStateHighlighted];
    [dianBtn setBackgroundImage:highlightedImage forState:UIControlStateNormal];
    
    [backBtn setBackgroundImage:normalImage forState:UIControlStateHighlighted];
    [backBtn setBackgroundImage:highlightedImage forState:UIControlStateNormal];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteTap:)];
    [backBtn addGestureRecognizer:longPress];
}
- (void)deleteTap:(UILongPressGestureRecognizer *)pressGes
{
    if (pressGes.state == UIGestureRecognizerStateBegan) {
        [[UIDevice currentDevice] playInputClick];
        if ([self.delegate respondsToSelector:@selector(numberPadViewDidTapDelete:)]) {
            [self.delegate numberPadViewDidTapDelete:self];
            return;
        }
        if (self.didTapDeleteBlock) {
            self.didTapDeleteBlock();
        }
    }
}

- (void)userDidTapKey:(UIButton *)btn
{
    [[UIDevice currentDevice] playInputClick];
    if (btn.tag != 66+11) {
        if ([self.delegate respondsToSelector:@selector(numberPadView:didTapKey:)]) {
            [self.delegate numberPadView:self didTapKey:btn.titleLabel.text];
            return;
        }
        if (self.didTapKeyBlock) {
            self.didTapKeyBlock(btn.titleLabel.text);
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(numberPadViewDidTapBackspace:)]) {
            [self.delegate numberPadViewDidTapBackspace:self];
            return;
        }
        if (self.didTapBackspaceBlock) {
            self.didTapBackspaceBlock();
        }
    }
}

- (void)showDotSign
{
    UIButton *dianBtn = (UIButton *)[self viewWithTag:66+9];
    [dianBtn setTitle:@"." forState:UIControlStateNormal];
}
- (void)showNegativeSign
{
    UIButton *negativeBtn = (UIButton *)[self viewWithTag:66+9];
    [negativeBtn setTitle:@"-" forState:UIControlStateNormal];
}

+(UIImage *)imageWithColor:(UIColor *)aColor{
    return [self imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}
@end


#import "UITextField+VENCalculatorInputView.h"

@interface VENNumberPadTextField()<NumberPadDelegate>
@property (nonatomic, strong) NumberPadView *numberPadView;
@end

@implementation VENNumberPadTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
- (NumberPadView *)numberPadView
{
    if (!_numberPadView) {
        _numberPadView = [[NumberPadView alloc]init];
        _numberPadView.delegate = self;
    }
    return _numberPadView;
}
- (void)setupView
{
    self.locale = [NSLocale currentLocale];
    [self addNumberPad];
}
- (void)addNumberPad
{
    if (self.inputView == self.numberPadView) {
        return;
    }
    self.inputView = self.numberPadView;
}
- (void)removeNumberPad
{
    if (self.inputView == self.numberPadView) {
        self.inputView = nil;
    }
}


#pragma mark - NumberPadDelegate
- (void)numberPadView:(NumberPadView *)padView didTapKey:(NSString *)key
{
    if ([key isEqualToString:[self decimalSeparator]]) {
        if ([self.text containsString:[self decimalSeparator]]) {
            return;
        }
    }
    if ([key isEqualToString:[self negativeSign]]) {
        if ([self.text containsString:[self negativeSign]]) {
            return;
        }
    }
    
    [self insertText:key];
}
- (void)numberPadViewDidTapBackspace:(NumberPadView *)padView
{
    [self deleteBackward];
}
- (void)numberPadViewDidTapDelete:(NumberPadView *)padView
{
    self.text = @"";
}

- (void)switchNegativeSignAndPoint
{
    NumberPadView *inputView = self.numberPadView;
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

- (NSString *)decimalSeparator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}
- (NSString *)negativeSign {
    return @"-";
}
@end
