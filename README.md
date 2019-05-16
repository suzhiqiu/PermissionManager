# UITableView_MVVM
UITableview_MMVM

1.定义一个协议 抽取共有方法。比如 类型type

@protocol IMYItemProtocol <NSObject>

@property(nonatomic, assign) NSInteger type;

2.生成各种model 都继承该协议


3.生成一个viewModel。
把uitableview 代理指向该viewModel


![image](https://github.com/suzhiqiu/UITableView_MVVM/blob/master/SDLiveVideoStream/%E7%BB%93%E6%9E%84%E5%9B%BE.png)
