//
//  EDChartsPolylineViewController.m
//  EchartsDemo
//
//  Created by mason on 2017/7/11.
//
//

#import "EDChartsPolylineViewController.h"
#import "EchartsDemo-Bridging-Header.h"
#import <Masonry/Masonry.h>

@interface EDChartsPolylineViewController ()
<
ChartViewDelegate
>

@property (nonatomic, strong) LineChartView *chartView;

@end

@implementation EDChartsPolylineViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createPolyline];
}


- (void)createPolyline {
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = NO;
    
    // x-axis limit line
    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
    llXAxis.lineWidth = 4.0;
    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
    llXAxis.labelPosition = ChartLimitLabelPositionRightBottom;
    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
    
    //[_chartView.xAxis addLimitLine:llXAxis];
    
    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    _chartView.xAxis.gridLineDashPhase = 0.f;
    
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"Upper Limit"];
    ll1.lineWidth = 4.0;
    ll1.lineDashLengths = @[@5.f, @5.f];
    ll1.labelPosition = ChartLimitLabelPositionRightTop;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
    ll2.lineWidth = 4.0;
    ll2.lineDashLengths = @[@5.f, @5.f];
    ll2.labelPosition = ChartLimitLabelPositionRightBottom;
    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
    [leftAxis addLimitLine:ll1];
    [leftAxis addLimitLine:ll2];
    leftAxis.axisMaximum = 200.0;
    leftAxis.axisMinimum = -50.0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    _chartView.rightAxis.enabled = NO;
    
    //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
    //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
    
//    BalloonMarker *marker = [[BalloonMarker alloc]
//                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                             font: [UIFont systemFontOfSize:12.0]
//                             textColor: UIColor.whiteColor
//                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//    marker.chartView = _chartView;
//    marker.minimumSize = CGSizeMake(80.f, 40.f);
//    _chartView.marker = marker;
    
    _chartView.legend.form = ChartLegendFormLine;
    
//    _sliderX.value = 45.0;
//    _sliderY.value = 100.0;
//    [self slidersValueChanged:nil];
    [self setDataCount:1 range:10];
    
    [_chartView animateWithXAxisDuration:2.5];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 3;
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
        
        set1.drawIconsEnabled = NO;
        
        set1.lineDashLengths = @[@5.f, @2.5f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
        [set1 setColor:UIColor.blackColor];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineDashLengths = @[@5.f, @2.5f];
        set1.formLineWidth = 1.0;
        set1.formSize = 15.0;
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
}


//- (void)createPolyline {
//    //初始化折线图对象
//    self.LineChartView = [[LineChartView alloc] init];
//    self.LineChartView.delegate = self;//设置代理
//    [self.view addSubview:self.LineChartView];
//    [self.LineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width-20, 300));
//        make.center.mas_equalTo(self.view);
//    }];
//    self.LineChartView.backgroundColor =  [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
//    self.LineChartView.noDataText = @"暂无数据";
//    
//    //设置折线图外观样式
//    //设置交互样式
//    self.LineChartView.scaleYEnabled = NO;//取消Y轴缩放
//    self.LineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
//    self.LineChartView.dragEnabled = YES;//启用拖拽图标
//    self.LineChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
//    self.LineChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
//    
//    //设置X轴样式
//    ChartXAxis *xAxis = self.LineChartView.xAxis;
//    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
//    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
//    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
////    xAxis.spaceBetweenLabels = 4;//设置label间隔
//    xAxis.labelTextColor = [UIColor blueColor];//label文字颜色
//    
//    //设置Y轴样式
//    self.LineChartView.rightAxis.enabled = NO;//不绘制右边轴
//    ChartYAxis *leftAxis = self.LineChartView.leftAxis;//获取左边Y轴
//    leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
//    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
////    leftAxis.showOnlyMinMaxEnabled = NO;//是否只显示最大值和最小值
//    leftAxis.axisMinValue = 0;//设置Y轴的最小值
////    leftAxis.startAtZeroEnabled = YES;//从0开始绘制
//    leftAxis.axisMaxValue = 105;//设置Y轴的最大值
//    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
//    leftAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//Y轴线宽
//    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
////    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];//自定义格式
////    leftAxis.valueFormatter.positiveSuffix = @" $";//数字后缀单位
//    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
//    leftAxis.labelTextColor = [UIColor redColor];//文字颜色
//    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
//
//    //设置网格线样式
//    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
//    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
//    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
//    
//    //添加限制线
//    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
//    limitLine.lineWidth = 2;
//    limitLine.lineColor = [UIColor greenColor];
//    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
//    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
//    limitLine.valueTextColor = [UIColor colorWithHexString:@"#057748"];//label文字颜色
//    limitLine.valueFont = [UIFont systemFontOfSize:12];//label字体
//    [leftAxis addLimitLine:limitLine];//添加到Y轴上
//    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在折线图的后面
//    
//    //设置折线图描述及图例样式
//    [self.LineChartView setDescriptionText:@"折线图"];//折线图描述
//    [self.LineChartView setDescriptionTextColor:[UIColor darkGrayColor]];
//    self.LineChartView.legend.form = ChartLegendFormLine;//图例的样式
//    self.LineChartView.legend.formSize = 30;//图例中线条的长度
//    self.LineChartView.legend.textColor = [UIColor darkGrayColor];//图例文字颜色
//}


//- (LineChartData *)setData{
//    
//    int xVals_count = 12;//X轴上要显示多少条数据
//    double maxYVal = 100;//Y轴的最大值
//    
//    //X轴上面需要显示的数据
//    NSMutableArray *xVals = [[NSMutableArray alloc] init];
//    for (int i = 0; i < xVals_count; i++) {
//        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
//    }
//    
//    //对应Y轴上面需要显示的数据
//    NSMutableArray *yVals = [[NSMutableArray alloc] init];
//    for (int i = 0; i < xVals_count; i++) {
//        double mult = maxYVal + 1;
//        double val = (double)(arc4random_uniform(mult));
//        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:val xIndex:i];
//        [yVals addObject:entry];
//    }
//    LineChartDataSet *set1 = nil;
//    if (self.LineChartView.data.dataSetCount > 0) {
//        LineChartData *data = (LineChartData *)self.LineChartView.data;
//        set1 = (LineChartDataSet *)data.dataSets[0];
//        set1.yVals = yVals;
//        return data;
//    }else{
//        //创建LineChartDataSet对象
//        set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"lineName"];
//        //设置折线的样式
//        set1.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
//        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
//        set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
//        [set1 setColor:[self colorWithHexString:@"#007FFF"]];//折线颜色
//        set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
//        //折线拐点样式
//        set1.drawCirclesEnabled = NO;//是否绘制拐点
//        set1.circleRadius = 4.0f;//拐点半径
//        set1.circleColors = @[[UIColor redColor], [UIColor greenColor]];//拐点颜色
//        //拐点中间的空心样式
//        set1.drawCircleHoleEnabled = YES;//是否绘制中间的空心
//        set1.circleHoleRadius = 2.0f;//空心的半径
//        set1.circleHoleColor = [UIColor blackColor];//空心的颜色
//        //折线的颜色填充样式
//        //第一种填充样式:单色填充
//        //        set1.drawFilledEnabled = YES;//是否填充颜色
//        //        set1.fillColor = [UIColor redColor];//填充颜色
//        //        set1.fillAlpha = 0.3;//填充颜色的透明度
//        //第二种填充样式:渐变填充
//        set1.drawFilledEnabled = YES;//是否填充颜色
//        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
//                                    (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
//        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
//        set1.fillAlpha = 0.3f;//透明度
//        set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
//        CGGradientRelease(gradientRef);//释放gradientRef
//        
//        //点击选中拐点的交互样式
//        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
//        set1.highlightColor = [self colorWithHexString:@"#c83c23"];//点击选中拐点的十字线的颜色
//        set1.highlightLineWidth = 1.0/[UIScreen mainScreen].scale;//十字线宽度
//        set1.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
//        
//        //将 LineChartDataSet 对象放入数组中
//        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//        [dataSets addObject:set1];
//        
//        
//        //添加第二个LineChartDataSet对象
//        //        LineChartDataSet *set2 = [set1 copy];
//        //        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
//        //        for (int i = 0; i < xVals_count; i++) {
//        //            double mult = maxYVal + 1;
//        //            double val = (double)(arc4random_uniform(mult));
//        //            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:val xIndex:i];
//        //            [yVals2 addObject:entry];
//        //        }
//        //        set2.yVals = yVals2;
//        //        [set2 setColor:[UIColor redColor]];
//        //        set2.drawFilledEnabled = YES;//是否填充颜色
//        //        set2.fillColor = [UIColor redColor];//填充颜色
//        //        set2.fillAlpha = 0.1;//填充颜色的透明度
//        //        [dataSets addObject:set2];
//        
//        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
//        LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
//        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];//文字字体
//        [data setValueTextColor:[UIColor grayColor]];//文字颜色
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        //自定义数据显示格式
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        [formatter setPositiveFormat:@"#0.0"];
//        [data setValueFormatter:formatter];
//        
//        
//        return data;
//    }
//    
//}

@end
