#import <UIKit/UIKit.h>
#import "VENCalculatorInputView.h"

@protocol VENCalculatorTapDelegate <NSObject>
@optional
- (void)calculatorInputViewDidTapConfirmKey:(VENCalculatorInputView *)calculatorInputView;
- (void)calculatorInputViewDidTapFunctionKey:(VENCalculatorInputView *)calculatorInputView;
@end

@interface VENCalculatorInputTextField : UITextField <VENCalculatorInputViewDelegate>

/**
 The locale to use for the decimal separator.
 Defaults to locale for current device.
 */
@property (strong, nonatomic) NSLocale *locale;

//点击确定按钮 代理
@property (nonatomic, weak) __weak id<VENCalculatorTapDelegate> tapDelegate;

@end
