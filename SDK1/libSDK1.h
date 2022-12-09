
__attribute__((visibility("default"))) void SDK1();

template <typename DType>
__attribute__((visibility("default"))) DType FuncSum(DType a) {
  printf("%s:%d\n", __FILE__, __LINE__);
  DType ret = 0;
  for (int i0 = 0; i0 < a; ++i0) {
    ret += i0;
  }
  return ret;
}