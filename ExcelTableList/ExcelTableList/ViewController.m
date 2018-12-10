//
//  ViewController.m
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import "ViewController.h"
#import "ExcelView.h"


@interface ViewController () <ExcelViewDataSource>
@property (nonatomic, strong) NSArray * rankDataArr;
@property (nonatomic, strong) NSArray * fields;
@property (nonatomic, strong) ExcelView * excel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fields = @[@"aqi",@"primaryPollution",@"pm25",@"pm10",@"so2",@"no2",@"co",@"o3"];
    self.rankDataArr = @[@{@"pointname":@"党校",@"time":@"2018-10-15 09:00:00",@"aqi":@258,@"so2":@"9",@"no2":@"102",@"co":@"2.0",@"o3":@"7",@"pm25":@"208",@"pm10":@"286",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx县"},@{@"pointname":@"xxxx顺达燃气",@"time":@"2018-10-15 09:00:00",@"aqi":@246,@"so2":@"13",@"no2":@"108",@"co":@"2.9",@"o3":@"3",@"pm25":@"196",@"pm10":@"239",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx市"},@{@"pointname":@"xxxx环保局",@"time":@"2018-10-15 09:00:00",@"aqi":@245,@"so2":@"10",@"no2":@"87",@"co":@"2.2",@"o3":@"4",@"pm25":@"195",@"pm10":@"322",@"primaryPollution":@"PM2.5",@"fristGridName":@"县"},@{@"pointname":@"xxxx市第三小学",@"time":@"2018-10-15 09:00:00",@"aqi":@235,@"so2":@"19",@"no2":@"96",@"co":@"1.8",@"o3":@"2",@"pm25":@"185",@"pm10":@"269",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx市"},@{@"pointname":@"药材公司",@"time":@"2018-10-15 09:00:00",@"aqi":@233,@"so2":@"15",@"no2":@"89",@"co":@"2.0",@"o3":@"2",@"pm25":@"183",@"pm10":@"254",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx区"},@{@"pointname":@"xxxx师范学院人文楼",@"time":@"2018-10-15 09:00:00",@"aqi":@230,@"so2":@"9",@"no2":@"88",@"co":@"1.7",@"o3":@"13",@"pm25":@"180",@"pm10":@"251",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx区"},@{@"pointname":@"开发区便民服务中心",@"time":@"2018-10-15 09:00:00",@"aqi":@229,@"so2":@"21",@"no2":@"112",@"co":@"1.9",@"o3":@"11",@"pm25":@"178",@"pm10":@"294",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx市"},@{@"pointname":@"北京八中xxxx分校",@"time":@"2018-10-15 09:00:00",@"aqi":@224,@"so2":@"12",@"no2":@"93",@"co":@"1.2",@"o3":@"4",@"pm25":@"174",@"pm10":@"271",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx区"},@{@"pointname":@"开发区",@"time":@"2018-10-15 09:00:00",@"aqi":@220,@"so2":@"11",@"no2":@"71",@"co":@"1.9",@"o3":@"1",@"pm25":@"170",@"pm10":@"245",@"primaryPollution":@"PM2.5",@"fristGridName":@"开发区"},@{@"pointname":@"xxxx学院",@"time":@"2018-10-15 09:00:00",@"aqi":@211,@"so2":@"13",@"no2":@"86",@"co":@"1.8",@"o3":@"4",@"pm25":@"161",@"pm10":@"244",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx区"},@{@"pointname":@"北京经管学院xxxx校区",@"time":@"2018-10-15 09:00:00",@"aqi":@207,@"so2":@"10",@"no2":@"105",@"co":@"1.3",@"o3":@"6",@"pm25":@"157",@"pm10":@"283",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx县"},@{@"pointname":@"xxxx大学",@"time":@"2018-10-15 09:00:00",@"aqi":@204,@"so2":@"15",@"no2":@"93",@"co":@"1.7",@"o3":@"4",@"pm25":@"154",@"pm10":@"260",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx区"},@{@"pointname":@"xxxx县第二小学",@"time":@"2018-10-15 09:00:00",@"aqi":@184,@"so2":@"9",@"no2":@"76",@"co":@"1.2",@"o3":@"14",@"pm25":@"139",@"pm10":@"197",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx县"},@{@"pointname":@"xxxx环保局",@"time":@"2018-10-15 09:00:00",@"aqi":@182,@"so2":@"15",@"no2":@"83",@"co":@"1.9",@"o3":@"6",@"pm25":@"137",@"pm10":@"242",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx县"},@{@"pointname":@"交通局",@"time":@"2018-10-15 09:00:00",@"aqi":@180,@"so2":@"8",@"no2":@"74",@"co":@"1.7",@"o3":@"15",@"pm25":@"136",@"pm10":@"193",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx市"},@{@"pointname":@"xxxx卫生局",@"time":@"2018-10-15 09:00:00",@"aqi":@176,@"so2":@"13",@"no2":@"74",@"co":@"1.8",@"o3":@"14",@"pm25":@"133",@"pm10":@"250",@"primaryPollution":@"PM2.5",@"fristGridName":@"xxxx县"},@{@"pointname":@"xxxx县一中",@"time":@"2018-10-15 09:00:00",@"aqi":@153,@"so2":@"26",@"no2":@"54",@"co":@"1.8",@"o3":@"18",@"pm25":@"117",@"pm10":@"152",@"primaryPollution":@"PM2.5",@"fristGridName":@"县"}];
    
    self.excel = [[ExcelView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.excel.dataSource = self;
    _excel.leftTops = @[@"排名",@"城市名称"];
    _excel.rightTops = @[@"AQI",@"首要污染物",@"PM2.5",@"PM10",@"SO2",@"NO2",@"CO",@"O3"];
    [self.view addSubview:self.excel];
    [_excel creatView];
}

#pragma ExcelView delegate
- (NSInteger)excelView:(ExcelView *)excelView numberOfRowsInSection:(NSInteger)section {
    return self.rankDataArr.count;
}
- (NSString *)excelView:(ExcelView *)excelView leftCellForRowAtIndexPath:(NSIndexPath *)indexPath withColumn:(NSInteger)column {
    if (column == 0) {
        return [NSString stringWithFormat:@"%d",indexPath.row + 1];
    } else {
        NSDictionary * dic = self.rankDataArr[indexPath.row];
        return [dic objectForKey:@"pointname"];
    }
}
- (NSString *)excelView:(ExcelView *)excelView rightCellForRowAtIndexPath:(NSIndexPath *)indexPath withColumn:(NSInteger)column {
    if (self.rankDataArr.count > 0) {
        NSDictionary * dic = self.rankDataArr[indexPath.row];
        id obj = [dic objectForKey:self.fields[column]];
        return [NSString stringWithFormat:@"%@",obj];
    }
    return @"";
}
- (CGFloat)excelView:(ExcelView *)excelView widthForLeftRowInColumn:(NSInteger)column {
    if (column == 0) {
        return 50;
    } else {
        return 100;
    }
}
- (CGFloat)excelView:(ExcelView *)excelView widthForRightRowInColumn:(NSInteger)column {
    if (column == 0) {
        return 80;
    } else {
        return 120;
    }
}
- (CGFloat)excelView:(ExcelView *)excelView heightForContentInRow:(NSInteger)row {
    return 60;
}
- (CGFloat)heightForTopRowInExcelView:(ExcelView *)excelView {
    return 80;
}


@end
