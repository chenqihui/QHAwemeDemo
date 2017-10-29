# QHAwemeDemo


>模仿抖音App的主导航框架

## 特性

- [x] 手势 push 
- [x] 为单个控制器关闭 pop 手势支持
- [x] 为所有控制器关闭 pop 手势支持
- [x] Present 的 push 和 pop 动画

## 预览

![image](https://github.com/chenqihui/QHAwemeDemo/blob/master/screenshots/QHAwemeDemoGif.gif)

## 说明
>手势push跟下面链接的JPNavigationController类似，不过这里的实现是添加全局手势之后，没有改变原来的pop的手势，然后通过手势回调区分是否出发对应的手势功能。相对而去不用担心替换系统pop手势的target问题。
然后对于支持屏幕边缘滑动的手势push，其实也是可以，当是由于业务需求，还没增加对这部分的出来，所以暂时不能忽略，后续再补上。

## 参考
 
- [JPNavigationController](https://github.com/newyjp/JPNavigationController)
- [开发中的疑惑点---手势位置locationInView、velocityInView、translationInView](http://www.jianshu.com/p/be29e46fb2c4)
[iOS7下滑动返回与ScrollView共存二三事](http://www.cnblogs.com/lexingyu/p/3702742.html)
* [JPNavigationController](https://github.com/newyjp/JPNavigationController)
* [自定义控制器的转场动画（Push、Pop）](http://www.jianshu.com/p/59224648828b)
* [iOS动画之自定义转场动画(push)](http://www.jianshu.com/p/4d2fea0f6ecc)
