![106926923_p0](https://img2023.cnblogs.com/blog/1892247/202305/1892247-20230516142055828-881758820.png)

因为做到Hog的Problem7才发觉应该要做笔记，所以之前的就没有了，从那个题开始，[GitHub仓库地址](https://github.com/520Enterprise/UCB-CS61A-20su)

# 关于Debug

可以通过下面的语句来Debug而不引发OK系统的错判

```python
print("DEBUG:", x) 
```

# Homework 2: Higher-Order Functions

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

注意要用命令 `winpty python -i lab05.py`

# Homework 4: Data Abstraction, Trees

## Q5: Preorder

如果用到这个 `sum`函数就会很方便，可以用来合并数组

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

注意当 `assert`错误时在OK系统中要输出 `AssertionError`，今天因为这个sb错误调了二十分钟

# Lab 6: Nonlocal, Mutability

注意 `nonlocal`关键字的使用，可以修改父帧的变量

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

注意Python里面的 `remove`函数是删除这个值而不是这个位置

# Homework 5: Nonlocal, Iterators & Generators

## Q4: Merge

注意 `yield`的用法，下面是一些粗浅的理解:
当一个函数 `foo`里面有 `yield`而不是 `return`的时候，调用 `foo()`会返回一个迭代器(所以也就不会执行里面的语句)，其他的直接参考下面的代码即可理解

```python
def foo():
    print("starting...")
    while True:
        res = yield 4
        print("res:",res)
g = foo()
#没有输出
print(next(g))
#输出: starting...
#输出: 4
print("*"*20)
#输出: ********************
print(next(g))
#输出: res: None
#输出: 4
```

## Q6: Remainder Generator

这个题要用高阶生成器做，有点难度，看了网站上的视频感觉没任何有用信息，之后又在AI的提示下做出来的(AI一开始也不对，乐)

```python
def remainders_generator(m):
    """
    Yields m generators. The ith yielded generator yields natural numbers whose
    remainder is i when divided by m.

    >>> import types
    >>> [isinstance(gen, types.GeneratorType) for gen in remainders_generator(5)]
    [True, True, True, True, True]
    >>> remainders_four = remainders_generator(4)
    >>> for i in range(4):
    ...     print("First 3 natural numbers with remainder {0} when divided by 4:".format(i))
    ...     gen = next(remainders_four)
    ...     for _ in range(3):
    ...         print(next(gen))
    First 3 natural numbers with remainder 0 when divided by 4:
    4
    8
    12
    First 3 natural numbers with remainder 1 when divided by 4:
    1
    5
    9
    First 3 natural numbers with remainder 2 when divided by 4:
    2
    6
    10
    First 3 natural numbers with remainder 3 when divided by 4:
    3
    7
    11
    """
    "*** YOUR CODE HERE ***"
    def gen(x):
        while True:
            yield x
            x += m
    for i in range(m):
        if i == 0:
            yield gen(m)
        else:
            yield gen(i)
```

# Lab 8: Object-Oriented Programming 

There are also some built-in functions that take in iterables and return useful results:

* `map(f, iterable)` - Creates iterator over `f(x)` for each `x` in `iterable`
* `filter(f, iterable)` - Creates iterator over `x` for each `x` in `iterable` if `f(x)`
* `zip(iter1, iter2)` - Creates iterator over co-indexed pairs (x, y) from both input iterables
* `reversed(iterable)` - Creates iterator over all the elements in the input iterable in reverse order
* `list(iterable)` - Creates a list containing all the elements in the input iterable
* `tuple(iterable)` - Creates a tuple containing all the elements in the input iterable
* `sorted(iterable)` - Creates a sorted list containing all the elements in the input iterable

## Q1: WWPD

注意以下语法，其实我们在Python中遍历数组的时候也是在用迭代器

```python
>>> r = range(6)
>>> r_iter = iter(r)
>>> next(r_iter)
0

>>> [x + 1 for x in r]
[1, 2, 3, 4, 5, 6]

>>> [x + 1 for x in r_iter]
[2, 3, 4, 5, 6]
```

## Q2: Generators generator

这个题有点难，一开始没搞明白，看了答案才懂
主要的难点在于想到用 `for entry in g():`
这种题用辅助函数也是容易想到的(但是我没想到，乐)

```python
def make_generators_generator(g):
    """Generates all the "sub"-generators of the generator returned by
    the generator function g.

    >>> def every_m_ints_to(n, m):
    ...     i = 0
    ...     while (i <= n):
    ...         yield i
    ...         i += m
    ...
    >>> def every_3_ints_to_10():
    ...     for item in every_m_ints_to(10, 3):
    ...         yield item
    ...
    >>> for gen in make_generators_generator(every_3_ints_to_10):
    ...     print("Next Generator:")
    ...     for item in gen:
    ...         print(item)
    ...
    Next Generator:
    0
    Next Generator:
    0
    3
    Next Generator:
    0
    3
    6
    Next Generator:
    0
    3
    6
    9
    """
    "*** YOUR CODE HERE ***"
    def gen_helper(num):
        gen = g()
        for i in range(num):
            yield next(gen)
    i = 1
    for entry in g():
        yield gen_helper(i)
        i += 1
```

# Homework 6: Object-Oriented Programming, Linked Lists, Trees 
## Q8: Deep Map
>Hint: You may find the built-in isinstance function useful. You can also use the type(link) == Link to check whether an object is a linked list (like you did in homework 3 question 1).

注意这个辅助函数的用法，可以用来判断是否为 `Link`类型

```python
def helper(link):
        if link is Link.empty:
            return Link.empty
        elif type(link.first) == Link:
            return Link(helper(link.first), helper(link.rest))
        else:
            return Link(f(link.first), helper(link.rest))
```

# Project 2: Cats

## Extra Credit Problem 2: Efficiency

![image-20230522100108656](https://img2023.cnblogs.com/blog/1892247/202305/1892247-20230522100109299-800366657.png)

ChatGPT告诉我们

>这段代码是一个测试代码片段，用于验证在`typing_test.py`中是否正确定义了特定的函数和函数名称。
>
>首先，代码尝试导入一些函数：`key_distance_diff`、`meowstake_matches`、`autocorrect`、`lines_from_file`、`faster_autocorrect`和`shifty_shifts`。然后，它从文件中加载单词列表，并检查导入是否成功。如果导入失败，则会引发`ImportError`并给出相应的错误信息。
>
>接下来，代码使用`trace`模块和`io.StringIO`上下文管理器来捕获函数的调用信息。它运行了`key_distance_diff`函数，并将输出重定向到`buf`。然后，它从输出中提取出调用函数的相关行信息，并提取出函数名称。最后，它将提取的函数名称与预期的函数名称集合进行比较，即`{'counted', 'key_distance_diff', 'memoized'}`。
>
>如果比较结果为`True`，则意味着`key_distance_diff`函数是在代码中唯一被使用的函数。否则，可能意味着其他函数也被调用了，需要进行检查。
>
>这段代码主要用于代码质量控制和测试，以确保程序正确地调用了特定的函数并遵守预期行为。

一开始我用的迭代式的DP而不是递归式做的，结果就寄了(原因不确定)



注意这个`memo`函数的实现，这里`memo`是每次只要进入函数就会有`count`所以要过关要求的是不能进入

`key_distance_diff`函数

```python
def memo(f):
    """A memoization function as seen in John Denero's lecture on Growth"""

    cache = {}

    def memoized(*args):
        if args not in cache:
            cache[args] = f(*args)
        return cache[args]

    return memoized
```

那么只有当`f`采用递归实现的时候`memo`才有意义，所以`key_distance_diff`应该修改一下

```python
def key_distance_diff(start, goal, limit):
    """ A diff function that takes into account the distances between keys when
    computing the difference score."""

    start = start.lower()  # converts the string to lowercase
    goal = goal.lower()  # converts the string to lowercase

    # BEGIN PROBLEM EC1
    "*** YOUR CODE HERE ***"
    # dp = [[0 for j in range(len(goal) + 1)] for i in range(len(start) + 1)]
    # for i in range(len(start) + 1):
    #     for j in range(len(goal) + 1):
    #         if i == 0:
    #             dp[i][j] = j
    #         elif j == 0:
    #             dp[i][j] = i
    #         elif start[i - 1] == goal[j - 1]:
    #             dp[i][j] = dp[i - 1][j - 1]
    #         else:
    #             dp[i][j] = min(1 + dp[i][j - 1], 1 + dp[i - 1][j],
    #                            key_distance[start[i - 1], goal[j - 1]] + dp[i - 1][j - 1])
    # if dp[len(start)][len(goal)] > limit:
    #     return float('inf')
    # return dp[len(start)][len(goal)]
    if limit < 0:
        return float('inf')
    if len(start) == 0 or len(goal) == 0:
        # BEGIN
        "*** YOUR CODE HERE ***"
        return len(start) + len(goal)
        # END
    elif start[0] == goal[0]:
        return key_distance_diff(start[1:], goal[1:], limit)
    else:
        add_diff = 1 + key_distance_diff(start, goal[1:], limit - 1)
        remove_diff = 1 + key_distance_diff(start[1:], goal, limit - 1)
        kd = key_distance[(start[0], goal[0])]
        substitute_diff = kd + key_distance_diff(start[1:], goal[1:], limit - 1)
        # BEGIN
        "*** YOUR CODE HERE ***"
        return min(min(add_diff, remove_diff), substitute_diff)
    # END PROBLEM EC1
```

另外注意这里的写法(Python是真的方便)

```python
words_diff = [diff_function(user_word, w, limit) for w in valid_words]
similar_word, similar_diff = min(zip(valid_words, words_diff), key=lambda item: item[1])
```



调了很久破案了，原来是因为这个，什么OI常用技巧，这也要记忆化是吧，乐

```python
min_diff = limit + 1
for valid_word in valid_words:
    if diff_function(user_word, valid_word, limit) < min_diff:
        min_diff = diff_function(user_word, valid_word, limit)
        min_word = valid_word
```

正确代码如下

```python
min_diff = limit + 1
for valid_word in valid_words:
    diff = diff_function(user_word, valid_word, limit)
    if diff < min_diff:
        min_diff = diff
        min_word = valid_word
```

