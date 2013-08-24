/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 6 "../../lib/includes/stdarg.h"
typedef __builtin_va_list va_list;
#line 21 "../../lib/includes/stdlib.h"
extern void abort(void) ;
#line 25 "../../lib/includes/stdarg.h"
extern void *__va_arg(va_list *ap ) ;
#line 30
extern void __va_start(va_list *ap , void *pN ) ;
#line 35
extern void __va_end(va_list *ap ) ;
#line 40
extern void __va_copy(va_list *dst , va_list src ) ;
#line 6 "stdarg-1.c"
int foo_arg  ;
#line 6 "stdarg-1.c"
int bar_arg  ;
#line 7 "stdarg-1.c"
long x  ;
#line 8 "stdarg-1.c"
double d  ;
#line 9 "stdarg-1.c"
va_list gap  ;
#line 10 "stdarg-1.c"
va_list *pap  ;
#line 12 "stdarg-1.c"
void foo(int v , va_list ap ) 
{ void *tmp ;

  {
#line 15
  switch (v) {
  case 5: 
#line 17
  tmp = __va_arg(& ap);
#line 17
  foo_arg = *((int *)tmp);
#line 17
  break;
  default: 
#line 18
  abort();
  }
#line 20
  return;
}
}
#line 22 "stdarg-1.c"
void bar(int v ) 
{ void *tmp ;
  void *tmp___0 ;
  void *tmp___1 ;
  void *tmp___2 ;
  void *tmp___3 ;

  {
#line 25
  if (v == 16390) {
#line 27
    tmp = __va_arg(& gap);
#line 27
    if (*((double *)tmp) != 17.0) {
#line 29
      abort();
    } else {
#line 27
      tmp___0 = __va_arg(& gap);
#line 27
      if (*((long *)tmp___0) != 129L) {
#line 29
        abort();
      }
    }
  } else {
#line 31
    if (v == 16392) {
#line 33
      tmp___1 = __va_arg(pap);
#line 33
      if (*((long long *)tmp___1) != 14LL) {
#line 36
        abort();
      } else {
#line 33
        tmp___2 = __va_arg(pap);
#line 33
        if (*((long double *)tmp___2) != 131.0L) {
#line 36
          abort();
        } else {
#line 33
          tmp___3 = __va_arg(pap);
#line 33
          if (*((int *)tmp___3) != 17) {
#line 36
            abort();
          }
        }
      }
    }
  }
#line 38
  bar_arg = v;
#line 39
  return;
}
}
#line 41 "stdarg-1.c"
void f0(int i  , ...) 
{ 

  {
#line 44
  return;
}
}
#line 46 "stdarg-1.c"
void f1(int i  , ...) 
{ va_list ap ;

  {
#line 50
  __va_start(& ap, (void *)(& i));
#line 51
  __va_end(& ap);
#line 52
  return;
}
}
#line 54 "stdarg-1.c"
void f2(int i  , ...) 
{ va_list ap ;
  void *tmp ;

  {
#line 58
  __va_start(& ap, (void *)(& i));
#line 59
  bar((int )d);
#line 60
  tmp = __va_arg(& ap);
#line 60
  x = *((long *)tmp);
#line 61
  bar((int )x);
#line 62
  __va_end(& ap);
#line 63
  return;
}
}
#line 65 "stdarg-1.c"
void f3(int i  , ...) 
{ va_list ap ;
  void *tmp ;

  {
#line 69
  __va_start(& ap, (void *)(& i));
#line 70
  tmp = __va_arg(& ap);
#line 70
  d = *((double *)tmp);
#line 71
  __va_end(& ap);
#line 72
  return;
}
}
#line 74 "stdarg-1.c"
void f4(int i  , ...) 
{ va_list ap ;
  void *tmp ;

  {
#line 78
  __va_start(& ap, (void *)(& i));
#line 79
  tmp = __va_arg(& ap);
#line 79
  x = (long )*((double *)tmp);
#line 80
  foo(i, ap);
#line 81
  __va_end(& ap);
#line 82
  return;
}
}
#line 84 "stdarg-1.c"
void f5(int i  , ...) 
{ va_list ap ;

  {
#line 88
  __va_start(& ap, (void *)(& i));
#line 89
  __va_copy(& gap, ap);
#line 90
  bar(i);
#line 91
  __va_end(& ap);
#line 92
  __va_end(& gap);
#line 93
  return;
}
}
#line 95 "stdarg-1.c"
void f6(int i  , ...) 
{ va_list ap ;
  void *tmp ;
  void *tmp___0 ;
  void *tmp___1 ;

  {
#line 99
  __va_start(& ap, (void *)(& i));
#line 100
  bar((int )d);
#line 101
  tmp = __va_arg(& ap);
#line 102
  tmp___0 = __va_arg(& ap);
#line 103
  tmp___1 = __va_arg(& ap);
#line 103
  x = *((long *)tmp___1);
#line 104
  bar((int )x);
#line 105
  __va_end(& ap);
#line 106
  return;
}
}
#line 108 "stdarg-1.c"
void f7(int i  , ...) 
{ va_list ap ;

  {
#line 112
  __va_start(& ap, (void *)(& i));
#line 113
  pap = & ap;
#line 114
  bar(i);
#line 115
  __va_end(& ap);
#line 116
  return;
}
}
#line 118 "stdarg-1.c"
void f8(int i  , ...) 
{ va_list ap ;
  void *tmp ;

  {
#line 122
  __va_start(& ap, (void *)(& i));
#line 123
  pap = & ap;
#line 124
  bar(i);
#line 125
  tmp = __va_arg(& ap);
#line 125
  d = *((double *)tmp);
#line 126
  __va_end(& ap);
#line 127
  return;
}
}
#line 129 "stdarg-1.c"
int main(void) 
{ 

  {
#line 131
  f0(1);
#line 132
  f1(2);
#line 133
  d = 31.0;
#line 134
  f2(3, 28L);
#line 135
  if (bar_arg != 28) {
#line 136
    abort();
  } else {
#line 135
    if (x != 28L) {
#line 136
      abort();
    }
  }
#line 137
  f3(4, 131.0);
#line 138
  if (d != 131.0) {
#line 139
    abort();
  }
#line 140
  f4(5, 16.0, 128);
#line 141
  if (x != 16L) {
#line 142
    abort();
  } else {
#line 141
    if (foo_arg != 128) {
#line 142
      abort();
    }
  }
#line 143
  f5(16390, 17.0, 129L);
#line 144
  if (bar_arg != 16390) {
#line 145
    abort();
  }
#line 146
  f6(7, 12L, 14L, -31L);
#line 147
  if (bar_arg != -31) {
#line 148
    abort();
  }
#line 149
  f7(16392, 14LL, 131.0L, 17, 26.0);
#line 150
  if (bar_arg != 16392) {
#line 151
    abort();
  }
#line 152
  f8(16392, 14LL, 131.0L, 17, 27.0);
#line 153
  if (bar_arg != 16392) {
#line 154
    abort();
  } else {
#line 153
    if (d != 27.0) {
#line 154
      abort();
    }
  }
#line 155
  return (0);
}
}
