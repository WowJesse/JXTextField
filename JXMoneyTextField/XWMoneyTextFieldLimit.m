//
//  XWMoneyTextFieldLimit.m
//  XWMoneyTextField
//
//  Created by smile.zhang on 16/3/10.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWMoneyTextFieldLimit.h"

@interface XWMoneyTextFieldLimit ()
@property (nonatomic, strong) NSString *tempText;
@property (nonatomic, assign) NSRange tempRange;
@property (nonatomic, strong) NSString *tempString;
@end

@implementation XWMoneyTextFieldLimit

- (instancetype)init{
    if (self = [super init]) {
        _max = @"99999.99";
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_delegate && [_delegate respondsToSelector:@selector(xwMoneyTextFieldDidEndEditing:)]) {
        [_delegate xwMoneyTextFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    _tempText = textField.text;
    _tempRange = range;
    _tempString = string;
    
    if (string && string.length > 0) {
        // 输入
        if (_tempText.length == 0) {
            if ([string isEqualToString:@"."]) {
                _tempText = @"0";
                return YES;
            }else{
                //当文本框本来没值的时候 判断是否大于最大值
                if ([_tempText?:EMPTY_STRING stringByAppendingString:string?:EMPTY_STRING].floatValue > [_max floatValue]) {
                    return NO;
                }
                return YES;
            }
            
        }else if (_tempText.length == 1){
            if ([_tempText isEqualToString:@"0"]) {
                if ([string isEqualToString:@"."]) {
                    return YES;
                }else{
                    return NO;
                }
            }
        }
        // 输入后不可超过 '99999.99'
        if ([_tempText?:EMPTY_STRING stringByAppendingString:string?:EMPTY_STRING].floatValue > [_max floatValue]) {
            return NO;
        }
        // 不可超过_max位
        if (_tempText.length >= _max.length) {
            return NO;
        }
        
        NSRange docRange = [_tempText rangeOfString:@"."];
        if (docRange.location != NSNotFound) {
            // 已输入小数点, 禁止再输入小数点
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            // 小数点后位数
            NSUInteger decimals = _tempText.length - (docRange.location + docRange.length);
            if (decimals == 2) {
                // 小数点后两位,禁止输入任何字符
                return NO;
            }else if (decimals == 1){
                // 小数点后一位,禁止输入 '0'
                if ([string isEqualToString:@"0"]) {
                    return NO;
                }
            }
        }else{
            if (_tempText.length == 0) {
                // 第一位
                if ([string isEqualToString:@"."] || [string isEqualToString:@"0"]) {
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

#pragma mark TextFieleActions
- (void)valueChanged:(UITextField *)textField {
    
    NSRange docRange = [_tempText rangeOfString:@"."];
    if (_tempString && _tempString.length > 0) {
        
        // 输入
        if (docRange.location != NSNotFound) {
            // 有小数点
            textField.text = [NSString stringWithFormat:@"%@%@",_tempText,_tempString];
        }else{
            // 无小数点
            if ([_tempString isEqualToString:@"."]) {
                // 是小数点
                textField.text = [NSString stringWithFormat:@"%@%@",_tempText,_tempString];
            }else{
                // 不是小数点
                textField.text = [NSString stringWithFormat:@"%lld",[_tempText longLongValue] * 10 + [_tempString longLongValue]];
            }
        }
    }else{
        // 删除
        textField.text = [_tempText substringToIndex:_tempText.length - 1];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(xwMoneyTextFieldValueChanged:)]) {
        [_delegate xwMoneyTextFieldValueChanged:textField];
    }
}

@end
