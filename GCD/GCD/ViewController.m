//
//  ViewController.m
//  GCD
//
//  Created by huqinghe on 2017/12/18.
//  Copyright © 2017年 huqinghe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)testMethod:(id)sender {
    NSLog(@"==");
    [self queue];
}

-(void)queue
{
    /**创建自己的队列
     DISPATCH_QUEUE_SERIAL  穿行队列   ---总是串行执行的
     DISPATCH_QUEUE_CONCURRENT 并行队列
     */
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        sleep(3);
        NSLog(@"dispatch-1");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        NSLog(@"dspatch-2");
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"end");
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
