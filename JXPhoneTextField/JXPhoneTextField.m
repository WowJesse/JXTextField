//
//  JXPhoneTextField.m
//  Snwdai
//
//  Created by 张明辉 on 16/4/28.
//  Copyright © 2016年 张明辉. All rights reserved.
//

#import "JXPhoneTextField.h"
#import <CoreText/CoreText.h>

@implementation JXPhoneTextField

- (instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger lengthOfString = string.length;//限制字符类型
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length; //限制字符长度
    
    //限制输入的只能为数字
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
        unichar character = [string characterAtIndex:loopIndex];
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57) return NO; // 57 unichar for 9
    }
    //限制字符长度
    if (proposedNewLength > 11) {
        return NO;
    }//限制长度
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
