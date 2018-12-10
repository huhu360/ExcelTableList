//
//  ClassifyView.m
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import "ClassifyView.h"
#import "Constant.h"

@implementation ClassifyView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self creatView];
    }
    return self;
}

- (void)creatView {
    _titLabel = [[UILabel alloc] initWithFrame:self.bounds];
    //    label.text = _titString;
    _titLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titLabel];
    
}


@end
