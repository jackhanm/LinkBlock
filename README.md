#LinkBlock
![LinkBlock icon](http://ico.ooopic.com/ajax/iconpng/?id=98399.png)

## What is this?
* 这是一个objc扩展集合`链式编程`，为的是告别换行和[]，用最简短的一句话尽可能多的完成功能。
* 框架封装原生Fundation最基本功能和最常见功能。
* This is objective-c link block , to `chain programming`.
* Frame encapsulation of native Foundation is the most basic and the most common functions.

##Simple to use LinkBlock ;
```objc
LinkBlock.h
```

##Bye CGRectMake(xxxx);
```objc
//Such written before 
//手绘UI动不动就要创建4，5个变量，而这明明是可以省略的步骤
UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
btn.frame= CGRectMake(20, 20, 150, 80);
UIColor *color = [UIColor colorWithRed:255/255.0 green:22/255.0 blue:150/255.0 alpha:1.0];
btn.backgroundColor = color;
[btn setTitle:@"click change color" forState:UIControlStateNormal];
[self.view addSubview:btn];
```
##Now， just a.b.c...
```objc
//现在只需要一行，大部分工作可以在思路不断的情况下一气呵成
//now just using one line.Most work can be wrapped up in the idea of ​​ongoing cases
btn.viewSetFrame(20,20,150,80).viewBGColor(@"0xff22cc".strToColorFromHexStr())
.viewAddToView(self.view).btnTitle(@"click change color", UIControlStateNormal);
```
##Very good string functions
```objc
NSString* str;
NSComparisonResult result = @"".setTo(&str).strAppend(@"abc1.txt").strCompareNumberSensitive(@"abc2.txt");

@"0xff22cc".strToColorFromHexStr();
@"#ff22cc".strToColorFromHexStr();
@"ff22cc".strToColorFromHexStr();
```
##NSDictionary get value safely
```objc
dict.dictGetNoNSNull(@"key");
dict.dictGetBOOLNoNullType(@"key");
dict.dictGetArrNoNullType(@"key");
dict.dictGetViewNoNullType(@"key");
```
##Do animation quickly
```objc
view.viewAnimateShakeHorizental(0.5);
btn.viewAnimateRemove();
btn.viewAnimateFlipFromTop(0.5,1,YES);
... ...
```

##end()
```objc
//如果你想在链条结尾获取绝对真实的对象值(继承NSObject)你需要在最后使用end()
//因为你可能得到的是LinkError对象
//If you want get real type of vale.you should using 'end()' at chain end.
//Because you may get LinkError
NSString *str2 = str1.strAppend(str0).strAt(15).end();
```

##What is LinkError
* 由于objc是有弱类型语言特征的语言，block是作为了扩展的属性，才可以被'.'出来。当中间一个链条返回的对象是nil，或者非预期的类型，那么下一根链条就会断裂，报错。为了让链条能够在安全的情况下容错走通，那么引入一个新的单例的类型LinkError
。这个对象响应所有扩展属性调用，但是仅仅返回自己到下一根链条。
* LinkError can response all extesion property,but just return self.So the chain can be not break and not throw out exception.

##Bug-mail address，join us address  *[quxingyi@outlook.com](quxingyi@outlook.com)*
##欢迎大家支持链式编程这种编程方式
