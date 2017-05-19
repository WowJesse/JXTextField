//
//  JXUserNameTextField.m
//  Snwdai
//
//  Created by 张明辉 on 16/5/11.
//  Copyright © 2016年 张明辉. All rights reserved.
//

#import "JXUserNameTextField.h"

@implementation JXUserNameTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.largeIndex = 20;
    }
    return self;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length; //限制字符长度
    //限制字符长度
    if (proposedNewLength > self.largeIndex) {
        textField.text = [[textField.text?:EMPTY_STRING stringByAppendingString:string] substringToIndex:self.largeIndex];
        return NO;
    }//限制长度
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}



@end
