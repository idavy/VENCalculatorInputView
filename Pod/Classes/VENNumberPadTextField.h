//
//  NumberPadTextField.h
//  Keyboard
//
//  Created by FangWei on 16/5/23.
//  Copyright © 2016年 Dave. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NumberPadView;

@protocol  NumberPadDelegate <NSObject>

@optional
- (void)numberPadView:(NumberPadView *)padView didTapKey:(NSString *)key;
- (void)numberPadViewDidTapBackspace:(NumberPadView *)padView;
- (void)numberPadViewDidTapDelete:(NumberPadView *)padView;
@end

@interface NumberPadView : UIView <UIInputViewAudioFeedback>
@property (nonatomic,weak) __weak id<NumberPadDelegate> delegate;

- (void)showDotSign;
- (void)showNegativeSign;

@property (nonatomic,copy) void (^didTapKeyBlock)(NSString *key);
@property (nonatomic,copy) void (^didTapBackspaceBlock)();
@property (nonatomic,copy) void (^didTapDeleteBlock)();
@end


@interface VENNumberPadTextField : UITextField
@property (strong, nonatomic) NSLocale *locale;
@end


