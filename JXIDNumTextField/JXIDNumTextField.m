//
//  JXIDNumTextField.m
//  Snwdai
//
//  Created by 张明辉 on 16/5/9.
//  Copyright © 2016年 张明辉. All rights reserved.
//

#import "JXIDNumTextField.h"

@implementation JXIDNumTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.largeIndex = 18;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.largeIndex = 18;
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
        //符合0-9  A-Z  a-z
        if ((character >= 48 && character <= 57)
            || (character >= 65 && character <= 90)
            || (character >= 97 && character <= 122)) {
        } else {
            return NO;
        }
    }
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
