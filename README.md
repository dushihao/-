# DSHDevelopToolCollections
常用的工具类
# 开发中工具类集合

## LayoutButton 
### usage

```
// 图片+文字按钮
self.imagePositionButton1 = [[LayoutButton alloc] init];
self.imagePositionButton1.backgroundColor = [UIColor redColor];
self.imagePositionButton1.imagePosition = QMUIButtonImagePositionTop;//将图片位置改为在文字上方
self.imagePositionButton1.spacingBetweenImageAndTitle = 8;
[self.imagePositionButton1 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
[self.imagePositionButton1 setTitle:@"图片在上方的按钮" forState:UIControlStateNormal];
self.imagePositionButton1.titleLabel.font = [UIFont systemFontOfSize:13];
[self.view addSubview:self.imagePositionButton1];
```
