typedef OneValueCallback<T> = void Function(T t);
typedef TwoValueCallback<T1, T2> = void Function(T1 t1, T2 t2);
typedef ThreeValueCallback<T1, T2, T3> = void Function(T1 t1, T2 t2, T3 t3);

typedef OneValueResult<T, R> = R Function(T t);
typedef TwoValueResult<T1, T2, R> = R Function(T1 t1, T2 t2);
typedef ThreeValueResult<T1, T2, T3, R> = R Function(T1 t1, T2 t2, T3 t3);
