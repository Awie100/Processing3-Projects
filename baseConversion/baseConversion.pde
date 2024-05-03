int start, end;
int[] in;

void setup() {
 
  in = new int[]{1,1,1,0,1,1,0};
  start = 2;
  end = 16;
  
  println(toBase(in, start, end));
  
}

int[] toBase(int[] a, int b, int c) {
  
  if (a.length == 0 || b <= 1 || c <= 1) return new int[0];
  
  int[] r;
  int d = 0;
  
  for (int i : a) {
    d = d * b + i;
  }
  
  r = new int[(int)(log(d)/log(c))+1];
  
  for (int i = r.length - 1; d > 0; i--) {
    r[i] = d % c;
    d = d / c;
  }
  return r;
}
