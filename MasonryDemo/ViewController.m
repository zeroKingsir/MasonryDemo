//
//  ViewController.m
//  MasonryDemo
//
//  Created by G.Z on 16/5/13.
//  Copyright © 2016年 GZ. All rights reserved.
/*
 Masonry 第三方的库 可以实现 视图间的约束 主要用于屏幕适配
 
 约束：一个视图的位置是参考于另一个视图 两者间的的位置关系 称为一个约束
 
 masonry实现的原理 就是一个相对位置的设置
 类似于停靠模式
 
 */

#import "ViewController.h"
#import "Masonry.h"
//导入第三方头文件

@interface ViewController ()

@property (nonatomic,strong)UIView *redView;
@property (nonatomic,strong)UIView *blueView;
//两个View 分别添加约束 实现在不同的屏幕下 保持一个相对的位置

@property (nonatomic,assign)int countRed;//设置点击屏幕空白处 修改redView尺寸

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    [self testOne];
    
    
    self.countRed = 0;
    [self testTwo];
}
#pragma mark -- 案例一

- (void)testOne{
    
    //1.红色的view添加约束 self.view 父视图
    
    //(1)创建
    _redView = [[UIView alloc]init];
    //使用自动布局或者masonsy是需要设置确切的大小 如果设置了 自动布局或者masonsy会报错
    
    _redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_redView];
    
    //视图添加约束 必须是在该视图称为某个视图的子视图后
    
    
    //(2)添加约束
    
    //masonsy 添加约束的方法 mas_makeConstraints
    
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make用于记录约束的关系
        
        //a.添加左边界的约束
        
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        //redView左标边界 = self.view左边界 + 30
        
        //mas_equalTo 该函数内写的是nil 默认的参考边界是make的边
        
        //b.添加右边界的约束
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        //redView右边界 = self.view右边界 - 30
        
        //c.添加上边界的约束
        make.top.mas_equalTo(self.view.mas_top).offset(60);
        //redView的上边界 = self.view上边界 + 60
        
        //d.添加下边界的约束
        //        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-200);
        //redView的下边界 = self.view下边界 - 200
        
        
        //【注意】如果上下左右都添加约束 那么宽与高就能够根据参考的视图 self.view的大小确定值是多少
        
        //如果上下边界的中的某一个没有添加约束 redView的高度难以确定
        //可以添加一个高度的约束 保持redView的高不变
        
        //e.添加高的约束
        
        make.height.equalTo(@(150));
        //redView的高度保持150
        
        //f.添加宽的约束
        //左右边界其中的某一个没有添加约束时 难以确定具体的宽 可以添加一个宽度的约束
        //        make.width.equalTo(@(300));
        
    }];
    
    //2.蓝色的视图添加约束  redView 同等级的视图
    
    //(1)创建
    _blueView = [[UIView alloc]init];
    
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blueView];
    
    //(2)添加约束
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //a.添加左边界的约束
        make.left.mas_equalTo(_redView.mas_left);
        //blueView的左边界与_redView的保持一致
        
        //        make.left.mas_equalTo(_redView.mas_left).offset(20);
        //blueView的左边界 = redView的左边界 + 20
        
        //b.添加上边界的约束
        
        make.top.mas_equalTo(_redView.mas_bottom).offset(30);
        //blueView的上边界 = redView的下边界 + 30
        
        
        //c.设置固定的宽
        
        make.width.equalTo(@(100));
        
        //d.设置固定的高
        make.height.equalTo(@(100));
        
        
        
    }];
    
    
    //移除约束
    
    //    [_redView mas_remakeConstraints:^(MASConstraintMaker *make) {
    
    //    }];
    
    
}

#pragma mark -- 案例二

- (void)testTwo{
    
    //1.redView
    _redView = [[UIView alloc]init];
    
    _redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_redView];
    
    //(1)添加约束
    
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置相对于父视图上下左右边界的约束
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(60, 30, 20, 20));
        //top left bottom right
        //在父视图内部 就应该全部写正数
        
    }];
    
    //2.blueView
    
    _blueView = [[UIView alloc]init];
    
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blueView];
    
    //(1)添加约束
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //设置中心点 x y的坐标 宽高保持固定不变
        
        //a.中心点x处于self.view的中心
        make.centerX.equalTo(self.view.mas_centerX);
        
        //b.中心点y处于self.view的中心
        make.centerY.equalTo(self.view.mas_centerY);
        
        //设置固定的宽与高
        
        make.width.equalTo(@(100));
        make.height.equalTo(@(100));
        
        
        
    }];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    self.countRed ++;
    
    if (self.countRed%2==0) {
        
        //如果点击屏幕的空白 实现redView与blueView位置的改变 刷新视图上的约束
        //更新约束
        
        //blueView的参考系是redView 因此只要redView的位置改变 blueView也会跟着改变
        
        // mas_updateConstraints 用于更新约束通常该方法写在一个平移动画内 实现动画更新位置
        
        [UIView animateWithDuration:1 animations:^{
            
            [_redView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                //让上边界下移  其余的边界约束保持不变
                //需要跟新的边界设置写在这里 不需要更新的不写保持原样
                make.top.mas_equalTo(self.view.mas_top).offset(120);
                
                // 错误！！！！！           make.top.mas_equalTo(_redView.mas_top).offset(60);
                //注意：参考物可以写成nil 或者其他的视图 比如父视图 比如同等级视图 但是不能写成自己
                
                
            }];
            
        }];
    }else{
    
        //如果点击屏幕的空白 实现redView与blueView位置的改变 刷新视图上的约束
        //更新约束
        
        //blueView的参考系是redView 因此只要redView的位置改变 blueView也会跟着改变
        
        // mas_updateConstraints 用于更新约束通常该方法写在一个平移动画内 实现动画更新位置
        
        [UIView animateWithDuration:1 animations:^{
            
            [_redView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                //让上边界下移  其余的边界约束保持不变
                //需要跟新的边界设置写在这里 不需要更新的不写保持原样
                make.top.mas_equalTo(self.view.mas_top).offset(64);
                
                // 错误！！！！！           make.top.mas_equalTo(_redView.mas_top).offset(60);
                //注意：参考物可以写成nil 或者其他的视图 比如父视图 比如同等级视图 但是不能写成自己
                
                
            }];
            
        }];
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
