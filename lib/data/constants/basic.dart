typedef OneValueCallback<T> = void Function(T t);
typedef TwoValueCallback<T1, T2> = void Function(T1 t1, T2 t2);
typedef ThreeValueCallback<T1, T2, T3> = void Function(T1 t1, T2 t2, T3 t3);
typedef FourValueCallback<T1, T2, T3, T4> = void Function(
    T1 t1, T2 t2, T3 t3, T4 t4);
typedef FiveValueCallback<T1, T2, T3, T4, T5> = void Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5);
typedef SixValueCallback<T1, T2, T3, T4, T5, T6> = void Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6);
typedef SevenValueCallback<T1, T2, T3, T4, T5, T6, T7> = void Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6, T7 t7);
typedef EightValueCallback<T1, T2, T3, T4, T5, T6, T7, T8> = void Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6, T7 t7, T8 t8);

typedef OneValueResult<T, R> = R Function(T t);
typedef TwoValueResult<T1, T2, R> = R Function(T1 t1, T2 t2);
typedef ThreeValueResult<T1, T2, T3, R> = R Function(T1 t1, T2 t2, T3 t3);
typedef FourValueResult<T1, T2, T3, T4, R> = R Function(
    T1 t1, T2 t2, T3 t3, T4 t4);
typedef FiveValueResult<T1, T2, T3, T4, T5, R> = R Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5);
typedef SixValueResult<T1, T2, T3, T4, T5, T6, R> = R Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6);
typedef SevenValueResult<T1, T2, T3, T4, T5, T6, T7, R> = R Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6, T7 t7);
typedef EightValueResult<T1, T2, T3, T4, T5, T6, T7, T8, R> = R Function(
    T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6, T7 t7, T8 t8);
