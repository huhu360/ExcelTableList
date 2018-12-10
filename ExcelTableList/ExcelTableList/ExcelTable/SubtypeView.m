//
//  SubtypeView.m
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import "SubtypeView.h"

@implementation SubtypeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.adjustsFontSizeToFitWidth = YES;
    }
    
    return self;
}
@end
