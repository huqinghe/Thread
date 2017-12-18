//
//  ViewController.m
//  Tips
//
//  Created by huqinghe on 2017/12/18.
//  Copyright © 2017年 huqinghe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)operration:(id)sender {
    /**
     *一发出的线程不能取消
     * 注意依赖
     **/
    
//    [self invationTest];
//    [self blockOperation];
    [self  dependcy];
}
/**
 * NSInvocationOperation
 */
-(void)invationTest
{
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run:) object:@"testInvation"];
    [invocation start];
}
-(void)blockOperation
{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"isMainThread=:%d",[[NSThread currentThread] isMainThread]);
    }];
    [blockOperation start];
}
-(void)run:(id)sender
{
    NSLog(@"sender=:%@",sender);
    NSLog(@"isMainThread=:%d",[[NSThread currentThread] isMainThread]);
}

-(void)dependcy
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1-----%@", [NSThread  currentThread]);
        sleep(3);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2-----%@", [NSThread  currentThread]);
    }];
    [op2 addDependency:op1];//让op2 依赖于 op1，则先执行op1，在执行op2
    [queue addOperation:op1];
    [queue addOperation:op2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
