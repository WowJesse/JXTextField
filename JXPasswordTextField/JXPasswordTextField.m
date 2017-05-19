//
//  JXPasswordTextField.m
//  Snwdai
//
//  Created by 张明辉 on 16/4/27.
//  Copyright © 2016年 张明辉. All rights reserved.
//

#import "JXPasswordTextField.h"

@implementation JXPasswordTextField 
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.secureTextEntry = YES;
        self.largeIndex = 18;
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.secureTextEntry = YES;
        self.largeIndex = 18;
    }
    return self;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//  *****jesse  支付密码 6位数字
//    NSUInteger lengthOfString = string.length;//限制字符类型
//    NSUInteger proposedNewLength = textField.text.length - range.length + string.length; //限制字符长度
//    
//    
//    //限制输入的只能为数字
//    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
//        unichar character = [string characterAtIndex:loopIndex];
//        if (character < 48) return NO; // 48 unichar for 0
//        if (character > 57) return NO; // 57 unichar for 9
//    }
//    //限制字符长度
//    if (proposedNewLength > self.largeIndex) {
//        return NO;
//    }//限制长度
//    
//    if ([string isEqualToString:@"\n"]) {
//        [textField resignFirstResponder];
//        return NO;
//    }
//    return YES;
    
//  *****jesse  支付密码 18位数字 字母 字符
    NSUInteger lengthOfString = string.length;//限制字符类型
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length; //限制字符长度
    
//    //限制输入的只能为数字
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
        unichar character = [string characterAtIndex:loopIndex];
        //符合0-9  A-Z  a-z
        if ((character >= 48 && character <= 57)
            || (character >= 65 && character <= 90)
            || (character >= 97 && character <= 122)) {
        } else {
            return NO;
        }
    }
    //************
//    //限制输入
//    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
//        unichar character = [string characterAtIndex:loopIndex];
//        //符合 (space) - ~
//        if (character >= 32 && character <= 126) {
//        } else {
//            return NO;
//        }
//    }
    //************由于键盘只显示部分字符 故不做限制
    //限制字符长度
    if (proposedNewLength > self.largeIndex) {
        return NO;
    }//限制长度
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;

}
@end
