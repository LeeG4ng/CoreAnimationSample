//
//  ViewController.m
//  CoreAnimationSample
//
//  Created by Gary Lee on 2017/11/15.
//  Copyright © 2017年 LeeG4ng. All rights reserved.
//

#import "ViewController.h"
#import <math.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) UIButton *aBtn;
@property (nonatomic, strong) UIButton *bBtn;
@property (nonatomic, strong) UIButton *cBtn;
@property (nonatomic, strong) UIButton *dBtn;
@property (nonatomic, strong) UIButton *eBtn;
@property (nonatomic, strong) UIView *darkView;

@property (nonatomic, assign) CGPoint centerPoint;

@property (nonatomic) BOOL boom;
@property (nonatomic) BOOL highlight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _boom = NO;
    _highlight = NO;
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, 100, 300, 60)];
    text.text = @"Core Animation Sample";
    text.textAlignment = NSTextAlignmentCenter;
    text.editable = NO;
    text.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:text];
    
    _centerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _centerBtn.backgroundColor = [UIColor lightGrayColor];
    [_centerBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    _centerPoint = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100);
    _centerBtn.frame = CGRectMake(0, 0, 100, 100);
    _centerBtn.layer.cornerRadius = _centerBtn.frame.size.width/2;
    _centerBtn.layer.masksToBounds = YES;
    _centerBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _centerBtn.layer.position = _centerPoint;
    [_centerBtn addTarget:self action:@selector(didClickCenterBtn) forControlEvents:UIControlEventTouchUpInside];

    _aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _aBtn.tag = 1;
    [_aBtn setImage:[UIImage imageNamed:@"account"] forState:UIControlStateNormal];
    _aBtn.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    _aBtn.frame = CGRectMake(0, 0, 50, 50);
    _aBtn.layer.cornerRadius = _aBtn.frame.size.width/2-15;
    _aBtn.layer.masksToBounds = YES;
    [self.view addSubview:_aBtn];
    _aBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _aBtn.layer.position = _centerPoint;
    [_aBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _bBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _bBtn.tag = 2;
    [_bBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    _bBtn.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    _bBtn.frame = CGRectMake(0, 0, 50, 50);
    _bBtn.layer.cornerRadius = _bBtn.frame.size.width/2-15;
    _bBtn.layer.masksToBounds = YES;
    [self.view addSubview:_bBtn];
    _bBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _bBtn.layer.position = _centerPoint;
    [_bBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _cBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cBtn.tag = 3;
    [_cBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
    _cBtn.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    _cBtn.frame = CGRectMake(0, 0, 50, 50);
    _cBtn.layer.cornerRadius = _cBtn.frame.size.width/2-15;
    _cBtn.layer.masksToBounds = YES;
    [self.view addSubview:_cBtn];
    _cBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _cBtn.layer.position = _centerPoint;
    [_cBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _dBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _dBtn.tag = 4;
    [_dBtn setImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
    _dBtn.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    _dBtn.frame = CGRectMake(0, 0, 50, 50);
    _dBtn.layer.cornerRadius = _dBtn.frame.size.width/2-15;
    _dBtn.layer.masksToBounds = YES;
    [self.view addSubview:_dBtn];
    _dBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _dBtn.layer.position = _centerPoint;
    [_dBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _eBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _eBtn.tag = 5;
    [_eBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    _eBtn.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    _eBtn.frame = CGRectMake(0, 0, 50, 50);
    _eBtn.layer.cornerRadius = _eBtn.frame.size.width/2-15;
    _eBtn.layer.masksToBounds = YES;
    [self.view addSubview:_eBtn];
    _eBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _eBtn.layer.position = _centerPoint;
    [_eBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_centerBtn];
    
    _darkView = [[UIView alloc] initWithFrame:self.view.frame];
    _darkView.backgroundColor = [UIColor blackColor];
    _darkView.alpha = 0.0f;
    [self.view insertSubview:_darkView belowSubview:_aBtn];
}

- (CGPoint)calculateEndPointWithBtn:(UIButton *)btn {
    NSInteger radius = 150;
    return CGPointMake(_centerPoint.x - radius*cosf(btn.tag*M_PI/6), _centerPoint.y - radius*sinf(btn.tag*M_PI/6));
}

- (void)didClickCenterBtn {
    if(_boom) {
        _boom = NO;
        
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _darkView.alpha = 0.0f;
        } completion:nil];
        
        [_aBtn.layer addAnimation:[self foldWithBtn:_aBtn] forKey:@"aBtnFold"];
        [_bBtn.layer addAnimation:[self foldWithBtn:_bBtn] forKey:@"bBtnFold"];
        [_cBtn.layer addAnimation:[self foldWithBtn:_cBtn] forKey:@"cBtnFold"];
        [_dBtn.layer addAnimation:[self foldWithBtn:_dBtn] forKey:@"dBtnFold"];
        [_eBtn.layer addAnimation:[self foldWithBtn:_eBtn] forKey:@"eBtnFold"];
        _aBtn.layer.position = _centerPoint;
        _bBtn.layer.position = _centerPoint;
        _cBtn.layer.position = _centerPoint;
        _dBtn.layer.position = _centerPoint;
        _eBtn.layer.position = _centerPoint;
        
        CABasicAnimation *centerBtnRotateBack = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        centerBtnRotateBack.fromValue = @(M_PI_4);
        centerBtnRotateBack.toValue = @0;
        centerBtnRotateBack.duration = 0.2f;
        CAKeyframeAnimation *scaleSmaller = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleSmaller.values = @[@1.3, @0.9, @1.0];
        scaleSmaller.keyTimes = @[@0.0, @0.8, @1.0];
        scaleSmaller.duration = 0.2f;
        CAAnimationGroup *centerBtnFold = [CAAnimationGroup animation];
        centerBtnFold.animations = @[centerBtnRotateBack, scaleSmaller];
        centerBtnFold.duration = 0.2f;
        centerBtnFold.fillMode = kCAFillModeForwards;
        centerBtnFold.removedOnCompletion = NO;
        [_centerBtn.layer addAnimation:centerBtnFold forKey:@"centerBtnBoom"];
    } else {
        _boom = YES;
        
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _darkView.alpha = 0.2f;
        } completion:nil];
        
        [_aBtn.layer addAnimation:[self boomWithBtn:_aBtn] forKey:@"aBtnBoom"];
        [_bBtn.layer addAnimation:[self boomWithBtn:_bBtn] forKey:@"bBtnBoom"];
        [_cBtn.layer addAnimation:[self boomWithBtn:_cBtn] forKey:@"cBtnBoom"];
        [_dBtn.layer addAnimation:[self boomWithBtn:_dBtn] forKey:@"dBtnBoom"];
        [_eBtn.layer addAnimation:[self boomWithBtn:_eBtn] forKey:@"eBtnBoom"];
        _aBtn.layer.position = [self calculateEndPointWithBtn:_aBtn];
        _bBtn.layer.position = [self calculateEndPointWithBtn:_bBtn];
        _cBtn.layer.position = [self calculateEndPointWithBtn:_cBtn];
        _dBtn.layer.position = [self calculateEndPointWithBtn:_dBtn];
        _eBtn.layer.position = [self calculateEndPointWithBtn:_eBtn];
        
        CABasicAnimation *centerBtnRotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        centerBtnRotate.fromValue = @0;
        centerBtnRotate.toValue = @(M_PI_4);
        centerBtnRotate.duration = 0.2f;
        CAKeyframeAnimation *scaleLarger = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleLarger.values = @[@1.0, @1.4, @1.3];
        scaleLarger.keyTimes = @[@0.0, @0.8, @1.0];
        scaleLarger.duration = 0.2f;
        CAAnimationGroup *centerBtnBoom = [CAAnimationGroup animation];
        centerBtnBoom.animations = @[centerBtnRotate, scaleLarger];
        centerBtnBoom.duration = 0.2f;
        centerBtnBoom.fillMode = kCAFillModeForwards;
        centerBtnBoom.removedOnCompletion = NO;
        [_centerBtn.layer addAnimation:centerBtnBoom forKey:@"centerBtnBoom"];
    }
}

- (CABasicAnimation *)moveOutWithBtn:(UIButton *)btn {
    CABasicAnimation *moveOut = [CABasicAnimation animationWithKeyPath:@"position"];
    moveOut.fromValue = [NSValue valueWithCGPoint:_centerPoint];
    moveOut.toValue = [NSValue valueWithCGPoint:[self calculateEndPointWithBtn:btn]];
    moveOut.duration = 0.2f;
    moveOut.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return moveOut;
}

- (CAAnimationGroup *)boomWithBtn:(UIButton *)btn {
    CABasicAnimation *rotateWhenBoom = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateWhenBoom.fromValue = @0;
    rotateWhenBoom.toValue = @(M_PI*2.0);
    rotateWhenBoom.duration = 0.2f;
    rotateWhenBoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *boom = [CAAnimationGroup animation];
    boom.animations = @[[self moveOutWithBtn:btn], rotateWhenBoom];
    boom.duration = 0.2f;
    boom.fillMode = kCAFillModeForwards;
    boom.removedOnCompletion = NO;
    return boom;
}

- (CABasicAnimation *)moveInWithBtn:(UIButton *)btn {
    CABasicAnimation *moveIn = [CABasicAnimation animationWithKeyPath:@"position"];
    moveIn.toValue = [NSValue valueWithCGPoint:_centerPoint];
    moveIn.fromValue = [NSValue valueWithCGPoint:[self calculateEndPointWithBtn:btn]];
    moveIn.duration = 0.2f;
    moveIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return moveIn;
}

- (CAAnimationGroup *)foldWithBtn:(UIButton *)btn {
    CABasicAnimation *rotateWhenFold = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateWhenFold.fromValue = @0;
    rotateWhenFold.toValue = @(-M_PI*2.0);
    rotateWhenFold.duration = 0.2f;
    rotateWhenFold.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *fold = [CAAnimationGroup animation];
    fold.animations = @[[self moveInWithBtn:btn], rotateWhenFold];
    fold.duration = 0.2f;
    fold.fillMode = kCAFillModeForwards;
    fold.removedOnCompletion = NO;
    return fold;
}

- (void)didClickBtn:(UIButton *)btn {
    if(!_highlight) {
        _highlight = YES;
        [self.view viewWithTag:btn.tag].backgroundColor = [UIColor colorWithRed:0.69 green:0.96 blue:0.40 alpha:1.00];
    } else {
        _highlight = NO;
        [self.view viewWithTag:btn.tag].backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
