/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 6 "../../lib/includes/stddef.h"
typedef unsigned int size_t;
#line 5 "pr35472.c"
struct S {
   int i[16] ;
};
#line 21 "../../lib/includes/stdlib.h"
extern void abort(void) ;
#line 4 "pr35472.c"
extern void *memset(void *s , int c , size_t n ) ;
#line 6 "pr35472.c"
struct S *p  ;
#line 7 "pr35472.c"
void ( __attribute__((__noinline__)) foo)(struct S *a , struct S *b ) 
{ 

  {
#line 8
  a->i[0] = -1;
#line 8
  p = b;
#line 8
  return;
}
}
#line 9 "pr35472.c"
void test(void) 
{ struct S a ;
  struct S b ;

  {
#line 12
  memset((void *)(& a.i[0]), '\000', (unsigned int )sizeof(a.i));
#line 13
  memset((void *)(& b.i[0]), '\000', (unsigned int )sizeof(b.i));
#line 14
  foo(& a, & b);
#line 15
  *p = a;
#line 16
  *p = b;
#line 17
  if (b.i[0] != -1) {
#line 18
    abort();
  }
#line 19
  return;
}
}
#line 20 "pr35472.c"
int main(void) 
{ 

  {
#line 22
  test();
#line 23
  return (0);
}
}
