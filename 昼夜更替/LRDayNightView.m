

#import "LRDayNightView.h"

@interface LRDayNightView ()


@end

@implementation LRDayNightView



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 先根据背景透明度绘制背景，RGB全部0 就是黑
    UIColor *b = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.ba];
    [b setFill];
    // 绘制背景
    CGContextFillRect(ctx, self.bounds);
    
    //绘制太阳
    CGFloat rx = self.rx; //圆心X
    // 太阳的半径
    CGFloat ra = self.frame.size.width / 8.0;
    // View高度
    CGFloat h = self.frame.size.height;
    // View宽度
    CGFloat w = self.frame.size.width;
    // 根据抛物线关系通过圆心X算出圆心Y的值
    CGFloat ry = (2.0*h)/(w*w) *rx * self.rx - (2.0*h/ w) *rx + 0.5 * h;
    // 内部每个颜色条所产生的间距
    CGFloat margin = ra / self.colors.count;
    for (int i = 0; i<self.colors.count; i++) {
        // 从数组提取颜色
        [self.colorsun[i] setStroke];
        // 画各种颜色的圆，圆心不变，不同的颜色画不同的半径的圆
        CGContextAddArc(ctx, rx, ry, ra - margin*i, 0, M_PI * 2, 1);
        CGContextStrokePath(ctx);
    }
    // 海洋 //所有的颜色都是一条矩形
    for (int i = 0; i<self.colorb.count; i++) {
        //X坐标
        CGFloat x = 0;
        //每个矩形高度
        CGFloat h = self.frame.size.height/2 / self.colorb.count;
        
        //Y坐标根据数组位置往下移动
        CGFloat y = h * i + self.frame.size.height/2;
        [self.colorb[i] setFill];
        // 绘制矩形
        CGContextFillRect(ctx, CGRectMake(x, y, w, h));
    }
    
}



@end
