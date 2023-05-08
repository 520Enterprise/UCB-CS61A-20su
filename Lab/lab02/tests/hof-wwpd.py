test = {
  'name': 'Higher Order Functions',
  'points': 0,
  'suites': [
    {
      'cases': [
        {
          'code': r"""
          >>> def even(f):
          ...     def odd(x):
          ...         if x < 0:
          ...             return f(-x)
          ...         return f(x)
          ...     return odd
          >>> steven = lambda x: x
          >>> stewart = even(steven)
          >>> stewart
          Function
          >>> stewart(61)
          61
          >>> stewart(-4)
          4
          """,
          'hidden': False,
          'locked': False
        },
        {
          'code': r"""
          >>> def cake():
          ...    print('beets')
          ...    def pie():
          ...        print('sweets')
          ...        return 'cake'
          ...    return pie
          >>> chocolate = cake()
          beets
          >>> chocolate
          Function
          >>> chocolate()
          sweets
          'cake'
          >>> more_chocolate, more_cake = chocolate(), cake
          sweets
          >>> more_chocolate
          7fccab88a7c3c0cbffe0142e723d1984
          # locked
          >>> def snake(x, y):
          ...    if cake == more_cake:
          ...        return chocolate
          ...    else:
          ...        return x + y
          >>> snake(10, 20)
          4f02258d689b15b516174b381ad2aef8
          # locked
          >>> snake(10, 20)()
          28f5a700252060ec3bbc4bf4ca744c56
          7fccab88a7c3c0cbffe0142e723d1984
          # locked
          >>> cake = 'cake'
          >>> snake(10, 20)
          c06666e98ec36af7add28e636f1488ee
          # locked
          """,
          'hidden': False,
          'locked': True
        }
      ],
      'scored': False,
      'type': 'wwpp'
    }
  ]
}
