//
//  EDHomeViewController.m
//  EchartsDemo
//
//  Created by mason on 2017/7/10.
//
//

#import "EDHomeViewController.h"
#import "iOS-Echarts.h"

@interface EDHomeViewController ()
<
UIScrollViewDelegate
>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PYZoomEchartsView *kEchartView;

@end

@implementation EDHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creatScrollView];
    
    [self showLineDemo];
    
    [self.kEchartView loadEcharts];
}

-(void)showLineDemo {
    
    /** 图表选项 */
    PYOption *option = [[PYOption alloc] init];
    //是否启用拖拽重计算特性，默认关闭
    option.calculable = NO;
    //数值系列的颜色列表(折线颜色)
    option.color = @[@"#20BCFC", @"#ff6347"];
    //图表背景色
    //option.backgroundColor = [[PYColor alloc] initWithColor:[UIColor orangeColor]];
    
    /** 提示框 */
    PYTooltip *tooltip = [[PYTooltip alloc] init];
    // 触发类型 默认数据触发
    tooltip.trigger = @"axis";
    // 竖线宽度
    tooltip.axisPointer.lineStyle.width = @1;
    // 提示框 文字样式设置
    tooltip.textStyle = [[PYTextStyle alloc] init];
    tooltip.textStyle.fontSize = @12;
    
    // 添加到图标选择中
    option.tooltip = tooltip;
    /** 图例 */
    PYLegend *legend = [[PYLegend alloc] init];
    // 设置数据
    legend.data = @[@"挂牌价",@"成交价"];
    
    // 添加到图标选择中
//    option.legend = legend;
    
    
    /** 直角坐标系内绘图网格, 说明见下图 */
    PYGrid *grid = [[PYGrid alloc] init];
    // 左上角位置
    grid.x = @(45);
    grid.y = @(20);
    // 右下角位置
    grid.x2 = @(20);
    grid.y2 = @(30);
    grid.borderWidth = @(0);
    
    // 添加到图标选择中
    option.grid = grid;
    
    /** X轴设置 */
    PYAxis *xAxis = [[PYAxis  alloc] init];
    //横轴默认为类目型(就是坐标自己设置)
    xAxis.type = @"category";
    // 起始和结束两端空白:设置YES，则两边会产生空白，设置NO,则X轴从0坐标开始
    xAxis.boundaryGap = @(NO);
    // 分隔线:垂直分割线
    xAxis.splitLine.show = NO;
    // 坐标轴线:一条紧挨坐标轴的蓝色线
    xAxis.axisLine.show = NO;
    // X轴坐标数据
    NSArray *array = @[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月" ] ;
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
    yAxis.type = @"value";
    // 分割段数，默认为5
    yAxis.splitNumber = @6;
    // 分割线类型
    // yAxis.splitLine.lineStyle.type = @"dashed";   //'solid' | 'dotted' | 'dashed' 虚线类型
    
    //单位设置,  设置最大值, 最小值
//     yAxis.axisLabel.formatter = @"{value} k";
     yAxis.max = @18;
     yAxis.min = @0;
    
    
    // 添加到图标选择中  ( y轴更多设置, 自行查看官方文档)
    option.yAxis = [[NSMutableArray alloc] initWithObjects:yAxis, nil];
    
    /** 定义坐标点数组 */
    NSMutableArray *seriesArr = [NSMutableArray array];
    
    /** 第一条折线设置 */
    PYCartesianSeries *series1 = [[PYCartesianSeries alloc] init];
    series1.name = @"挂牌价";
    // 类型为折线
    series1.type = @"line";
    // 坐标点大小
    series1.symbolSize = @(1.5);
    // 坐标点样式, 设置连线的宽度
    series1.itemStyle = [[PYItemStyle alloc] init];
    series1.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series1.itemStyle.normal.lineStyle = [[PYLineStyle alloc] init];
    series1.itemStyle.normal.lineStyle.width = @(1.5);
    // 添加坐标点 y 轴数据 ( 如果某一点 无数据, 可以传 @"-" 断开连线 如 : @[@"7566", @"-", @"7571"]  )
    series1.data = @[@"6", @"9", @"11", @"10", @"1", @"18", @"10", @"12", @"6", @"16", @"15", @"10"];
    
    [seriesArr addObject:series1];
    
    /** 第二条折线设置 */
    PYCartesianSeries *series2 = [[PYCartesianSeries alloc] init];
    series2.name = @"成交价";
    series2.type = @"line";
    series2.symbolSize = @(1.5);
    series2.symbol = PYSymbolCircle;//设定转折点显示的是圆点、方块、还是三角形等等
    //添加折线底部填充颜色
    series2.itemStyle = [[PYItemStyle alloc] init];
    series2.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series2.itemStyle.normal.areaStyle = [[PYAreaStyle alloc] init];
    
    series2.itemStyle.normal.lineStyle = [[PYLineStyle alloc] init];
    series2.itemStyle.normal.lineStyle.width = @(1.5);
    series2.data = @[@"16", @"9", @"1", @"10", @"1", @"18", @"10", @"2", @"16", @"6", @"15", @"10"];
    [seriesArr addObject:series2];
    
    [option setSeries:seriesArr];
    
    /** 初始化图表 */
    self.kEchartView = [[PYZoomEchartsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    // 添加到 scrollView 上
    [self.scrollView addSubview:self.kEchartView];
    // 图表选项添加到图表上
    [self.kEchartView setOption:option];
    
}


- (void)creatScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width , 300)];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
