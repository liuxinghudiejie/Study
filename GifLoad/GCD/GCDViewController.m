//
//  GCDViewController.m
//  GifLoad
//
//  Created by xxlc on 2017/12/5.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
@property (nonatomic,strong)dispatch_source_t timer;
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个串行队列
    dispatch_queue_t sreialQueue =dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);//一个串行队列，第一个参数是唯一标示，第二个表示串行队列
    
    //创建一个并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("test.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);//一个并行队列
    
   
    //创建一个异步队列，第一个参数是队列，这里获取了系统提供的全局队列（第一个参数是优先级，第二个暂时为0）；
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
   /* [self createQueue_concurrent_sync];
    [self createQueue_serial_sycn];
    [self createQueue_concurrent_async];
    [self createQueue_serial_asycn];*/
   /* [NSThread performSelector:@selector(createQueue_concurrent_async) withObject:nil afterDelay:5];
    [NSThread performSelector:@selector(createQueue_serial_asycn) withObject:nil afterDelay:10];
    [NSThread performSelector:@selector(createQueue_serial_sycn) withObject:nil afterDelay:15];*/
    
    [self createGroupQueue];
    
    
   

}
#pragma mark  主队列 + 同步执行
- (void)createQueue_main_sync{//放在主线程会死锁(这个方法放在分线程就不会死锁了)
    //这是因为我们在主线程中执行这段代码。我们把任务放到了主队列中，也就是放到了主线程的队列中。而同步执行有个特点，就是对于任务是立马执行的。那么当我们把第一个任务放进主队列中，它就会立马执行。但是主线程现在正在处理syncMain方法，所以任务需要等syncMain执行完才能执行。而syncMain执行到第一个任务的时候，又要等第一个任务执行完才能往下执行第二个和第三个任务。那么，现在的情况就是syncMain方法和第一个任务都在等对方执行完毕。这样大家互相等待，所以就卡住了
    NSLog(@"执行开始执行了吗");
    dispatch_queue_t main_sync_queue = dispatch_get_main_queue();
    dispatch_async(main_sync_queue, ^{
        NSLog(@"1-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_async(main_sync_queue, ^{
        NSLog(@"2-当前的线程是%@",[NSThread currentThread]);
    });
     NSLog(@"执行结束了吗");
}
#pragma mark 并行队列+同步执行
- (void)createQueue_concurrent_sync{
    //一个接一个执行，都在主线程中，所有任务都在打印的  开始 和结束之间，说明任务是添加到队列中马上执行的
    dispatch_queue_t concurrent_sync_queue = dispatch_queue_create("concurrent_sync_queue", DISPATCH_QUEUE_CONCURRENT);//创建一个并行队列
    NSLog(@"0-并行队列+同步执行开始执行了吗");
    dispatch_sync(concurrent_sync_queue, ^{
        NSLog(@"1-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent_sync_queue, ^{
        NSLog(@"2-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_sync(concurrent_sync_queue, ^{
        NSLog(@"3-当前的线程是%@",[NSThread currentThread]);
    });
    NSLog(@"执行结束了吗");
}
#pragma mark 并行队列+异步执行
- (void)createQueue_concurrent_async{
    //开辟了分线程，执行顺序由系统决定，任务是交替着同时执行的，所有任务都在打印的  开始 和结束之后，说明任务不是马上执行，而是将所有任务添加到队列之后才开始异步执行。
    dispatch_queue_t concurrent_async_queue = dispatch_queue_create("queue.concurrent_async", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"并行队列+异步执行开始执行了吗");
    dispatch_async(concurrent_async_queue, ^{
        NSLog(@"1-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_async(concurrent_async_queue, ^{
        NSLog(@"2-当前线的程是%@",[NSThread currentThread]);
    });
    dispatch_async(concurrent_async_queue, ^{
        NSLog(@"3-当前的线程是%@",[NSThread currentThread]);
    });
    NSLog(@"执行结束了吗");
    
}
#pragma mark 串行队列+同步执行
- (void)createQueue_serial_sycn{
    //一个接一个执行，所有任务都在打印的  开始 和结束之间，说明任务是添加到队列中马上执行的
    dispatch_queue_t serial_syan_queue = dispatch_queue_create("serial_syan_queue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"串行队列+同步执行开始执行了吗");
    dispatch_sync(serial_syan_queue, ^{
        NSLog(@"1-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_sync(serial_syan_queue, ^{
        NSLog(@"2-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_sync(serial_syan_queue, ^{
        NSLog(@"3-当前的线程是%@",[NSThread currentThread]);
    });
    NSLog(@"执行结束了吗");
    
}
#pragma mark 串行队列+异步执行
- (void)createQueue_serial_asycn{
    //开辟了分线程，只开辟了一个，顺序执行，所有任务都在打印的  开始 和结束之后，说明任务不是马上执行，而是将所有任务添加到队列之后才开始异步执行
    dispatch_queue_t serial_asycn_queue = dispatch_queue_create("serial_asycn_queue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"串行队列+异步执行开始执行了吗");
    dispatch_async(serial_asycn_queue, ^{
        NSLog(@"1-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_async(serial_asycn_queue, ^{
        NSLog(@"2-当前的线程是%@",[NSThread currentThread]);
    });
    dispatch_async(serial_asycn_queue, ^{
        NSLog(@"3-当前的线程是%@",[NSThread currentThread]);
    });
    NSLog(@"执行结束了吗");
}
#pragma mark ==线程之间的通信
- (void)noticeSync{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"这里是分线程,还没执行完");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"执行完了，回到主线程");
        });
    });
}
#pragma mark ====栅栏操作
- (void)barrier{
    //我们有时需要异步执行两组操作，而且第一组操作执行完之后，才能开始执行第二组操作。这样我们就需要一个相当于栅栏一样的一个方法将两组异步执行的操作组给分割起来，当然这里的操作组里可以包含一个或多个任务。这就需要用到dispatch_barrier_async方法在两个操作组间形成栅栏。执行完栅栏前面的操作之后，才执行栅栏操作，最后再执行栅栏后边的操作。
    
    dispatch_queue_t queue = dispatch_queue_create("12", DISPATCH_QUEUE_CONCURRENT); dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       dispatch_async(queue, ^{
           NSLog(@"这是第一个");
       });
       
       dispatch_async(queue, ^{
           NSLog(@"这是第二个");
       });
       dispatch_async(queue, ^{
           NSLog(@"这是第三个");
       });
       
       dispatch_async(queue, ^{
           NSLog(@"这是第五个");
       });
        dispatch_barrier_async(queue, ^{
            NSLog(@"这是第四个");
        });
        dispatch_async(queue, ^{
            NSLog(@"这是第6个");
        });
        dispatch_async(queue, ^{
            NSLog(@"这是第7个");
        });
   });
}
#pragma mark ====延时操作
- (void)afterTime{
    /*该方法的第一个参数是time，第二个参数是dispatch_queue，第三个参数是要执行的block。
    dispatch_time_t有两种形式的构造方式，第一种相对时间：DISPATCH_TIME_NOW表示现在，NSEC_PER_SEC表示的是秒数，它还提供了NSEC_PER_MSEC表示毫秒。第二种是绝对时间，通过dispatch_walltime函数来获取，dispatch_walltime需要使用一个timespec的结构体来得到dispatch_time_t。*/
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延时操作");
    });
}
#pragma mark ==定时器
- (void)createTimer{
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    __block NSInteger timeOut = 10;
    //设定时间，1秒执行一次
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"在这里实现定时器逻辑--%ld",(long)timeOut);
        if (timeOut<0) {
            NSLog(@"时间到了呀");
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_source_cancel(self.timer);//销毁
                self.timer = nil;
            });
        }else{
            timeOut--;
        }
    });
    //启动定时器
    dispatch_resume(self.timer);//启动
}
#pragma mark ===只执行一次，单例
- (void)createOnceQueue{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行一次");
    });
}
#pragma mark 信号量
- (void)createGroupQueue{
    //dispatch_group_enter(groupQueue);dispatch_group_leave(groupQueue);这两个一起使用，耗时操作开始前写enter，完成后leave
    //dispatch_semaphore_signal(semaphore);dispatch_wait(semaphore, DISPATCH_TIME_FOREVER);信号量，这两个一起使用
    
    //适用于多个耗时任务一起执行，都执行完毕后，回到主线程，刷新UI
    dispatch_group_t groupQueue = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_enter(groupQueue);
    dispatch_group_async(groupQueue, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"请求一");
           // dispatch_semaphore_signal(semaphore);
            dispatch_group_leave(groupQueue);
        });
        
    });
    dispatch_group_enter(groupQueue);
    dispatch_group_async(groupQueue, queue, ^{
        NSLog(@"这是第2个");
        //dispatch_semaphore_signal(semaphore);
        dispatch_group_leave(groupQueue);
    });
    dispatch_group_enter(groupQueue);
    dispatch_group_async(groupQueue, queue, ^{
        NSLog(@"这是第3个");
        dispatch_group_leave(groupQueue);
        //dispatch_semaphore_signal(semaphore);
    });
   /* dispatch_group_async(groupQueue, queue, ^{
        
        NSLog(@"这是第4个");
        dispatch_group_leave(groupQueue);
       // dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(groupQueue, queue, ^{
        NSLog(@"这是第5个");
        
        //dispatch_semaphore_signal(semaphore);
    });*/
    
    dispatch_group_notify(groupQueue, queue, ^{
      /*  dispatch_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_wait(semaphore, DISPATCH_TIME_FOREVER);*/
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"做完了，回到主线程");
        });
    });
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
