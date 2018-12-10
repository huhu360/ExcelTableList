//
//  ExcelLeftView.m
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import "ExcelLeftView.h"
#import "Constant.h"

@interface ExcelLeftView () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation ExcelLeftView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareLayout];
    }
    
    return self;
}

- (void)prepareLayout {
    
    NSInteger num = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInExcelLeftView:)]) {
        num = [self.dataSource numberOfRowsInExcelLeftView:self];
    }
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    
    //    NSLog(@"%@---- %@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.tableV.frame));
    
    [self addSubview:self.tableV];
    
    self.tableV.delegate = self;
    
    self.tableV.dataSource = self;
    
    self.tableV.allowsSelection = NO;

    self.tableV.showsVerticalScrollIndicator = NO;
    self.tableV.showsHorizontalScrollIndicator = NO;
//    self.tableV.userInteractionEnabled = NO;
    self.tableV.bounces = NO;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableV registerClass:[ExcelLeftCell class] forCellReuseIdentifier:@"ExcelLeftCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInExcelLeftView:)]) {
        return [self.dataSource numberOfRowsInExcelLeftView:self];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExcelLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcelLeftCell" forIndexPath:indexPath];
    if ([self.dataSource respondsToSelector:@selector(excelLeftView:cellForRowAtIndexPath:)]) {
        cell.subtypeView.text = [self.dataSource excelLeftView:self cellForRowAtIndexPath:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellH = cellHeight;
    if ([self.dataSource respondsToSelector:@selector(heightForLeftCellHeightInRow:)]) {
        cellH = [self.dataSource heightForLeftCellHeightInRow:indexPath.row];
    }
    return cellH;
}


- (void)reloadData {
    [self.tableV reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableV.frame = self.bounds;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if ([self.dataSource respondsToSelector:@selector(layoutLeftListWithOffsetY:)]) {
        [self.dataSource layoutLeftListWithOffsetY:offsetY];
    }
}



@end

@implementation ExcelLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = backColor;
        self.subtypeView = [[SubtypeView alloc] init];
        self.subtypeView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.subtypeView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.subtypeView.frame = CGRectMake(0, 0, self.bounds.size.width-1, self.bounds.size.height - 1);
}

@end
