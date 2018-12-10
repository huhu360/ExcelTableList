//
//  ExcelCell.m
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import "ExcelCell.h"
#import "SubtypeView.h"
#import "Constant.h"

@interface ExcelCell ()


@end

@implementation ExcelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self prepareLayout];
    }
    return self;
}

- (void)prepareLayout {
    NSInteger num = 1;
    // 获取需要显示的列数
    NSNumber * number = [[NSUserDefaults standardUserDefaults] objectForKey:@"column"];
    num = [number integerValue];
    self.labelArr = [NSMutableArray arrayWithCapacity:12];
    self.contentView.backgroundColor = backColor;
    for (int i = 0; i < num; i++) {
        SubtypeView * headView = [[SubtypeView alloc] initWithFrame:CGRectZero];
        //         headView.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        headView.backgroundColor = [UIColor whiteColor];
        headView.text = [NSString stringWithFormat:@"%d",i];
        [self.contentView addSubview:headView];
        [self.labelArr addObject:headView];
    }
}


@end
