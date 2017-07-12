//
//  EDPolylineView.m
//  EchartsDemo
//
//  Created by mason on 2017/7/11.
//
//

#import "EDPolylineView.h"

@implementation EDPolylineModel

@end


@interface EDPolylineView()
//不添加这个，图表会显示不全，没找到原因，demo中是将图表添加在UIScrollView上的
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) WKEchartsView *echartView;
@property (strong, nonatomic) PYOption *option;

@end

@implementation EDPolylineView

- (instancetype)initWithDataSource:(NSArray *)dataSource xAxisMenuArray:(NSArray *)xAxisMenuArray lineColorArray:(NSArray *_Nullable)lineColorArray splitNumber:(NSNumber * _Nullable)splitNumber yAxisMax:(NSNumber * _Nullable)yAxisMax yAxisMin:(NSNumber * _Nullable)yAxisMin boundaryGap:(BOOL)boundaryGap showTooltip:(BOOL)showTooltip{
    if (self = [super init]) {
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.xAxisMenuArray = xAxisMenuArray;
        self.dataSource = dataSource;
        self.splitNumber = splitNumber;
        self.yAxisMax = yAxisMax;
        self.yAxisMin = yAxisMin;
        self.boundaryGap = boundaryGap;
        self.showTooltip = showTooltip;
        [self showLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.echartView.frame = self.bounds;
}

-(void)showLine {
    // 图表选项添加到图表上
    [self.echartView setOption:[self option]];
    [self.echartView loadEcharts];
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
}

- (void)setXAxisMenuArray:(NSArray *)xAxisMenuArray {
    _xAxisMenuArray = xAxisMenuArray;
}

- (void)refreshData {
    if (self.echartView) {
        [self.echartView hideLoading];
        [self.echartView refreshEchartsWithOption:self.option];
    }
}

- (PYOption *)option {
    /** 图表选项 */
    PYOption *option = [[PYOption alloc] init];
    //是否启用拖拽重计算特性，默认关闭
    option.calculable = NO;
    //数值系列的颜色列表(折线颜色)
    if (self.lineColorArray.count <= 0) {
        NSMutableArray *colorArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.dataSource.count; i++) {
            [colorArray addObject:i % 2 == 0 ? @"#20BCFC" : @"#ff6347"];
        }
        option.color = [colorArray copy];
    } else {
        option.color = [self.lineColorArray copy];
    }
    //图表背景色
    //option.backgroundColor = [[PYColor alloc] initWithColor:[UIColor orangeColor]];
    if (self.isShowTooltip) {
        /** 提示框 */
        PYTooltip *tooltip = [[PYTooltip alloc] init];
        // 触发类型 默认数据触发
        tooltip.trigger = PYTooltipTriggerItem;
        // 竖线宽度
        tooltip.axisPointer.lineStyle.width = @1;
        // 提示框 文字样式设置
        tooltip.textStyle = [[PYTextStyle alloc] init];
        tooltip.textStyle.fontSize = @12;
        // 添加到图标选择中
        option.tooltip = tooltip;
    }
    
    /** 图例 */
    PYLegend *legend = [[PYLegend alloc] init];
    // 设置数据
    legend.data = @[@"挂牌价",@"成交价"];
    // 添加到图标选择中
    // option.legend = legend;
    
    /** 直角坐标系内绘图网格, 说明见下图 */
    PYGrid *grid = [[PYGrid alloc] init];
    // 左上角位置
    grid.x = @(45);
    grid.y = @(20);
    // 右下角位置
    grid.x2 = @(20);
    grid.y2 = @(30);
    grid.borderWidth = @(0);//左右两边垂直线条size
    
    // 添加到图标选择中
    option.grid = grid;
    /** X轴设置 */
    PYAxis *xAxis = [[PYAxis  alloc] init];
    //横轴默认为类目型(就是坐标自己设置)
    xAxis.type = PYAxisTypeCategory;
    // 起始和结束两端空白:设置YES，则两边会产生空白，设置NO,则X轴从0坐标开始
    xAxis.boundaryGap = @(self.boundaryGap);
    // 分隔线:垂直分割线
    xAxis.splitLine.show = NO;
    // 坐标轴线:一条紧挨坐标轴的蓝色线
    xAxis.axisLine.show = NO;
    // X轴坐标数据
    NSArray *array = [self.xAxisMenuArray copy];
    xAxis.data = [array mutableCopy];
    // 坐标轴小标记
    xAxis.axisTick = [[PYAxisTick alloc] init];
    xAxis.axisTick.show = YES;
    
    // 添加到图标选择中
    option.xAxis = [[NSMutableArray alloc] initWithObjects:xAxis, nil];
    
    /** Y轴设置 */
    PYAxis *yAxis = [[PYAxis alloc] init];
    yAxis.axisLine.show = NO;
    // 纵轴默认为数值型(就是坐标系统生成), 改为 @"category" 会有问题, 读者可以自行尝试
    yAxis.type = PYAxisTypeValue;

    // 分割线类型
    // yAxis.splitLine.lineStyle.type = @"dashed";   //'solid' | 'dotted' | 'dashed' 虚线类型
    //单位设置,  设置最大值, 最小值
//    yAxis.axisLabel.formatter = @"{value} k";
    // Y轴坐标数据
    // 分割段数，默认为5
    yAxis.splitNumber = self.splitNumber;
    yAxis.max = self.yAxisMax;
    yAxis.min = self.yAxisMin;
    
    // 添加到图标选择中  ( y轴更多设置, 自行查看官方文档)
    option.yAxis = [[NSMutableArray alloc] initWithObjects:yAxis, nil];
    
    /** 定义坐标点数组 */
    NSMutableArray *seriesArray = [NSMutableArray array];
    //添加折线
    for (EDPolylineModel *lineModel in self.dataSource) {
        /** 第一条折线设置 */
        PYCartesianSeries *series = [[PYCartesianSeries alloc] init];
        series.name = lineModel.seriesName;
        // 类型为折线
        series.type = lineModel.seriesType;
        // 添加坐标点 y 轴数据 ( 如果某一点 无数据, 可以传 @"-" 断开连线 如 : @[@"7566", @"-", @"7571"]  )
        series.data = lineModel.points;
        
        if ([lineModel.seriesType isEqualToString:PYSeriesTypeLine]) {
            // 坐标点大小
            series.symbolSize = [GGUtil stringIsEmpty:lineModel.symbolSize]?@(1.5):[lineModel.symbolSize numberValue];
            // 坐标点样式, 设置连线的宽度
            series.itemStyle = [[PYItemStyle alloc] init];
            series.itemStyle.normal = [[PYItemStyleProp alloc] init];
            series.itemStyle.normal.lineStyle = [[PYLineStyle alloc] init];
            series.itemStyle.normal.lineStyle.width = [GGUtil stringIsEmpty:lineModel.lineWith]?@(1.5):[lineModel.lineWith numberValue];
            
            //填充背景色
            if (lineModel.isFillBockgroundColor) {
                PYAreaStyle *areaStyle = [[PYAreaStyle alloc] init];
                areaStyle.type = PYAreaStyleTypeDefault;
                PYItemStyleProp *itemStyleProp = [[PYItemStyleProp alloc] init];
                itemStyleProp.areaStyle = areaStyle;
                PYItemStyle *itemStyle = [[PYItemStyle alloc] init];
                itemStyle.normal = itemStyleProp;
                series.itemStyle = itemStyle;
            }
        } else if ([lineModel.seriesType isEqualToString:PYSeriesTypeBar]){
            series.barWidth = lineModel.barWidth;
        }
        [seriesArray addObject:series];
    }
    [option setSeries:seriesArray];
    return option;
}

- (WKEchartsView *)echartView {
    if (!_echartView) {
        _echartView = [[WKEchartsView alloc] initWithFrame:self.bounds];
        [self addSubview:_echartView];
    }
    return _echartView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width * 2, self.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.width * 2, self.height);
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

@end
