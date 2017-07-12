//
//  EDPolylineView.h
//  EchartsDemo
//
//  Created by mason on 2017/7/11.
//
//

#import <UIKit/UIKit.h>
#import "iOS-Echarts.h"

//折线数据对象
@interface EDPolylineModel : NSObject

/** 折线名称 */
@property (strong, nonatomic, nonnull) NSString *seriesName;
/** 转折点大小 */
@property (strong, nonatomic, nullable) NSString *symbolSize;
/** 转折点类型：方形、圆形、三角形 , 如果不指定，系统默认第一条为圆，第二条为方形，以此类推*/
@property (strong, nonatomic, nullable) PYSymbol symbol;
/** 线条宽度 */
@property (strong, nonatomic, nullable) NSString *lineWith;
/** 折线底部是否使用背景色填充 */
@property (assign, nonatomic, getter=isFillBockgroundColor) BOOL fillBockgroundColor;
/** 坐标点集合：非空 */
@property (strong, nonatomic, nonnull) NSArray *points;

@end

@interface EDPolylineView : UIView

/** 
 初始化
 如果不是使用该方法进行初始化，必须主动调用refreshData()方法
 */
- (instancetype _Nullable )initWithDataSource:(NSArray *_Nonnull)dataSource xAxisMenuArray:(NSArray *_Nonnull)xAxisMenuArray lineColorArray:(NSArray *_Nullable)lineColorArray splitNumber:(NSNumber *_Nullable)splitNumber yAxisMax:(NSNumber *_Nullable)yAxisMax yAxisMin:(NSNumber *_Nullable)yAxisMin;

/** 折线颜色:每一条折线对应相应的数据 : 16进制 默认：@"#20BCFC" : @"#ff6347" */
@property (strong, nonatomic, nullable) NSArray *lineColorArray;
/** X轴坐标数据：非空 */
@property (strong, nonatomic, nonnull) NSArray *xAxisMenuArray;
/**  Y轴坐标数据 : 完整的话，包含以下三个属性， 分割段数，默认为5 */
@property (strong, nonatomic, nonnull) NSNumber *splitNumber;
/** 设置最大值 */
@property (strong, nonatomic, nullable) NSNumber *yAxisMax;
/** 设置最小值 */
@property (strong, nonatomic, nullable) NSNumber *yAxisMin;
/** 是否显示提示框：点击图标，弹出透明背景框, 默认显示 */
@property (assign, nonatomic, getter=isShowTooltip) BOOL showTooltip;
/** 数据源：折线图数据 */
@property (strong, nonatomic, nonnull) NSArray <EDPolylineModel *>*dataSource;

/**
 刷新数据
 */
- (void)refreshData;
@end
