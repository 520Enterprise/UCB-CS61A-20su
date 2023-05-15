因为做到Hog的Problem7才发觉应该要做笔记，所以之前的就没有了，从那个题开始，[GitHub仓库地址](https://github.com/520Enterprise/UCB-CS61A-20su)

# 关于Debug

可以通过下面的语句来Debug而不引发OK系统的错判

```python
print("DEBUG:", x) 
```

# Homework 2

关于Church数

https://www.cnblogs.com/ZHDreamer/p/15929157.html

# Hog

这是要写一个~~赌博游戏~~

终于在5月9号凌晨写完了

## Problem 7

没啥好说的，就是我最后返回 `last_score+score`还查错了好久就显得很蠢

## Problem 8/9/10/11

很快地写完了，没啥好说的

# Lab 5

## Q4: Sprout leaves

```python
if is_leaf(t):
    return tree(label(t), [tree(x) for x in leaves])
return tree(label(t), [sprout_leaves(x, leaves) for x in branches(t)])
```

注意这里要用他给出 `tree`函数来进行合成，而不是自己在前后加括号搞个数组(一开始我就这么做，很难调试，最主要的是违反了抽象原则)

> When writing functions that use an ADT, we should use the constructor(s) and selector(s) whenever possible instead of assuming the ADT's implementation. Relying on a data abstraction's underlying implementation is known as violating the abstraction barrier, and we never want to do this!

## Q6: Add trees

> *Hint* : You may want to use the built-in zip function to iterate over multiple sequences at once.

用法如下

```python
>>> a = [1,2,3]
>>> b = [4,5,6]
>>> c = [4,5,6,7,8]
>>> zipped = zip(a,b)     # 返回一个对象
>>> zipped
<zip object at 0x103abc288>
>>> list(zipped)  # list() 转换为列表
[(1, 4), (2, 5), (3, 6)]
>>> list(zip(a,c))              # 元素个数与最短的列表一致
[(1, 4), (2, 5), (3, 6)]

>>> a1, a2 = zip(*zip(a,b))          # 与 zip 相反，zip(*) 可理解为解压，返回二维矩阵式
>>> list(a1)
[1, 2, 3]
>>> list(a2)
[4, 5, 6]
>>>
```
解答如下，稍微有点复杂
```python
if is_leaf(t1):
    return tree(label(t1) + label(t2), branches(t2))
if is_leaf(t2):
    return tree(label(t1) + label(t2), branches(t1))
if len(branches(t1)) < len(branches(t2)):
    t1, t2 = t2, t1
t2_new = tree(label(t2), branches(t2) + [tree(0) for i in range(len(branches(t1)) - len(branches(t2)))])
zip_tree = zip(branches(t1), branches(t2_new))
return tree(label(t1) + label(t2), [add_trees(x, y) for x, y in zip_tree])
```

## Putting it all together
注意要用命令`winpty python -i lab05.py`

# Homework 4

## Q5: Preorder
如果用到这个`sum`函数就会很方便，可以用来合并数组
```python
lst = [[1, 2], [3, 4]]
print(sum(lst, [])) 
#[1, 2, 3, 4]
```

## Q6: Has Path
用any会很方便
`any()` 函数用于判断给定的可迭代参数 `iterable` 是否全部为 `False`，则返回 `False`，如果有一个为 `True`，则返回 `True`。
元素除了是 `0`、空、`False` 外都算 `True`。
```python
>>> any(['a', 'b', 'c', 'd'])  # 列表list，元素都不为空或0
True
>>> any(['a', 'b', '', 'd'])   # 列表list，存在一个为空的元素
True
>>> any([0, '', False])        # 列表list,元素全为0,'',false
False
>>> any(('a', 'b', 'c', 'd'))  # 元组tuple，元素都不为空或0
True
>>> any(('a', 'b', '', 'd'))   # 元组tuple，存在一个为空的元素
True
>>> any((0, '', False))        # 元组tuple，元素全为0,'',false
False
>>> any([]) # 空列表
False
>>> any(()) # 空元组
False
```

## Q9: Div Interva
注意当`assert`错误时在OK系统中要输出`AssertionError`，今天因为这个sb错误调了二十分钟

# Lab 6
注意`nonlocal`关键字的使用，可以修改父帧的变量
```python
def make_withdraw(balance):
    """Returns a function which can withdraw
    some amount from balance

    >>> withdraw = make_withdraw(50)
    >>> withdraw(25)
    25
    >>> withdraw(25)
    0
    """
    def withdraw(amount):
        nonlocal balance
        if amount > balance:
            return "Insufficient funds"
        balance = balance - amount
        return balance
    return withdraw
``` 

## Q3: List-Mutation
注意Python里面的`remove`函数是删除这个值而不是这个位置