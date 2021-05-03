# 実行時間

CPU: Intel Core i9-9900KF

```
$ time MYTH_NUM_WORKERS=1 ./ray
real    0m2.208s
user    0m2.201s
sys     0m0.008s
```

```
$ time MYTH_NUM_WORKERS=2 ./ray
real    0m1.159s
user    0m2.302s
sys     0m0.010s
```

```
$ time MYTH_NUM_WORKERS=4 ./ray
real    0m0.602s
user    0m2.350s
sys     0m0.029s
```

```
$ time MYTH_NUM_WORKERS=8 ./ray
real    0m0.319s
user    0m2.360s
sys     0m0.053s
```

```
$ time MYTH_NUM_WORKERS=16 ./ray
real    0m0.816s
user    0m12.092s
sys     0m0.362s
```
