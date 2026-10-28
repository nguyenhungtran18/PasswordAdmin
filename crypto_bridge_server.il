.assembly extern mscorlib {}
.assembly extern System.Core { .publickeytoken = (B7 7A 5C 56 19 34 E0 89 ) .ver 4:0:0:0 }
.assembly extern System { .publickeytoken = (B7 7A 5C 56 19 34 E0 89 ) .ver 4:0:0:0 }
.assembly extern System.Numerics { .publickeytoken = (B7 7A 5C 56 19 34 E0 89 ) .ver 4:0:0:0 }
.assembly TKVApp {}
.module TKVApp.exe

.class public sequential ansi sealed beforefieldinit TkvInt
       extends [mscorlib]System.ValueType
       implements class [mscorlib]System.IComparable`1<valuetype TkvInt>, [mscorlib]System.IComparable
{
  .field public int64 lo
  .field public object big
  .method public static valuetype TkvInt FromI64(int64 v) cil managed
  {
    .maxstack 8
    .locals init (valuetype TkvInt r)
    ldloca.s r
    ldarg.0
    stfld int64 TkvInt::lo
    ldloca.s r
    ldnull
    stfld object TkvInt::big
    ldloc.s r
    ret
  }
  .method public static valuetype TkvInt FromStr(string s) cil managed
  {
    .maxstack 8
    ldarg.0
    ldc.i4.7
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Parse(string, valuetype [mscorlib]System.Globalization.NumberStyles, class [mscorlib]System.IFormatProvider)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt FromBig(valuetype [System.Numerics]System.Numerics.BigInteger b) cil managed
  {
    .maxstack 8
    .locals init (valuetype TkvInt r)
    ldarg.0
    ldc.i8 0x8000000000000000
    call bool [System.Numerics]System.Numerics.BigInteger::op_GreaterThanOrEqual(valuetype [System.Numerics]System.Numerics.BigInteger, int64)
    brfalse.s BIGPATH
    ldarg.0
    ldc.i8 0x7FFFFFFFFFFFFFFF
    call bool [System.Numerics]System.Numerics.BigInteger::op_LessThanOrEqual(valuetype [System.Numerics]System.Numerics.BigInteger, int64)
    brfalse.s BIGPATH
    ldloca.s r
    ldarg.0
    call int64 [System.Numerics]System.Numerics.BigInteger::op_Explicit(valuetype [System.Numerics]System.Numerics.BigInteger)
    stfld int64 TkvInt::lo
    ldloca.s r
    ldnull
    stfld object TkvInt::big
    ldloc.s r
    ret
  BIGPATH:
    ldloca.s r
    ldc.i8 0
    stfld int64 TkvInt::lo
    ldloca.s r
    ldarg.0
    box [System.Numerics]System.Numerics.BigInteger
    stfld object TkvInt::big
    ldloc.s r
    ret
  }
  .method public static valuetype [System.Numerics]System.Numerics.BigInteger ToBig(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brfalse.s FASTPATH
    ldarga.s a
    ldfld object TkvInt::big
    unbox.any [System.Numerics]System.Numerics.BigInteger
    ret
  FASTPATH:
    ldarga.s a
    ldfld int64 TkvInt::lo
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Implicit(int64)
    ret
  }
  .method public static valuetype TkvInt AddSlow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Addition(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt SubSlow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Subtraction(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt MulSlow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Multiply(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static int32 Cmp(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue.s SLOWPATH
    ldarga.s b
    ldfld object TkvInt::big
    brtrue.s SLOWPATH
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloca.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    call instance int32 [mscorlib]System.Int64::CompareTo(int64)
    ret
  SLOWPATH:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call int32 [System.Numerics]System.Numerics.BigInteger::Compare(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static string Str(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (int64 x, valuetype [System.Numerics]System.Numerics.BigInteger b)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue.s SLOWPATH
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloca.s x
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [mscorlib]System.Int64::ToString(class [mscorlib]System.IFormatProvider)
    ret
  SLOWPATH:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s b
    ldloca.s b
    call class [mscorlib]System.Globalization.CultureInfo [mscorlib]System.Globalization.CultureInfo::get_InvariantCulture()
    call instance string [System.Numerics]System.Numerics.BigInteger::ToString(class [mscorlib]System.IFormatProvider)
    ret
  }
  .method public static int32 ToI32(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brtrue TOI32_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    conv.ovf.i4
    ret
  TOI32_BIG:
    ldstr "chi so int qua lon: khong vua int32."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public static int64 ToI64(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brtrue TOI64_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    ret
  TOI64_BIG:
    ldstr "gia tri int qua lon: khong vua int64."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public static float64 ToF64(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (valuetype [System.Numerics]System.Numerics.BigInteger b, float64 d)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue TOF64_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    conv.r8
    ret
  TOF64_BIG:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s b
    ldloc.s b
    call float64 [System.Numerics]System.Numerics.BigInteger::op_Explicit(valuetype [System.Numerics]System.Numerics.BigInteger)
    stloc.s d
    ldloc.s d
    call bool [mscorlib]System.Double::IsInfinity(float64)
    brtrue TOF64_OVF
    ldloc.s d
    ret
  TOF64_OVF:
    ldstr "gia tri int qua lon de chuyen thanh float."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public hidebysig newslot virtual final instance int32 CompareTo(valuetype TkvInt other) cil managed
  {
    .maxstack 8
    .override method instance int32 class [mscorlib]System.IComparable`1<valuetype TkvInt>::CompareTo(!0)
    ldarg.0
    ldobj valuetype TkvInt
    ldarg.1
    call int32 TkvInt::Cmp(valuetype TkvInt, valuetype TkvInt)
    ret
  }
  .method public hidebysig newslot virtual final instance int32 CompareTo(object other) cil managed
  {
    .maxstack 8
    .override [mscorlib]System.IComparable::CompareTo
    ldarg.0
    ldobj valuetype TkvInt
    ldarg.1
    unbox.any valuetype TkvInt
    call int32 TkvInt::Cmp(valuetype TkvInt, valuetype TkvInt)
    ret
  }
  .method public static valuetype TkvInt FloorDiv(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x, int64 y, int64 q, int64 r, valuetype [System.Numerics]System.Numerics.BigInteger ba, valuetype [System.Numerics]System.Numerics.BigInteger bb, valuetype [System.Numerics]System.Numerics.BigInteger bq, valuetype [System.Numerics]System.Numerics.BigInteger bdu)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue FD_SLOW
    ldarga.s b
    ldfld object TkvInt::big
    brtrue FD_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s y
    ldloc.s y
    ldc.i8 0
    beq FD_SLOW
    ldloc.s y
    ldc.i8 -1
    beq FD_SLOW
    ldloc.s x
    ldloc.s y
    div
    stloc.s q
    ldloc.s x
    ldloc.s y
    rem
    stloc.s r
    ldloc.s r
    ldc.i8 0
    beq FD_FAST_DONE
    ldloc.s x
    ldloc.s y
    xor
    ldc.i8 0
    bge FD_FAST_DONE
    ldloc.s q
    ldc.i8 1
    sub
    stloc.s q
  FD_FAST_DONE:
    ldloc.s q
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  FD_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s ba
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s bb
    ldloc.s ba
    ldloc.s bb
    ldloca.s bdu
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::DivRem(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger&)
    stloc.s bq
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldc.i4.0
    beq FD_SLOW_DONE
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldloca.s bb
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    beq FD_SLOW_DONE
    ldloc.s bq
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::get_One()
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Subtraction(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    stloc.s bq
  FD_SLOW_DONE:
    ldloc.s bq
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Mod(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x, int64 y, int64 q, int64 r, valuetype [System.Numerics]System.Numerics.BigInteger ba, valuetype [System.Numerics]System.Numerics.BigInteger bb, valuetype [System.Numerics]System.Numerics.BigInteger bq, valuetype [System.Numerics]System.Numerics.BigInteger bdu)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue MD_SLOW
    ldarga.s b
    ldfld object TkvInt::big
    brtrue MD_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s y
    ldloc.s y
    ldc.i8 0
    beq MD_SLOW
    ldloc.s y
    ldc.i8 -1
    beq MD_SLOW
    ldloc.s x
    ldloc.s y
    rem
    stloc.s r
    ldloc.s r
    ldc.i8 0
    beq MD_FAST_DONE
    ldloc.s r
    ldloc.s y
    xor
    ldc.i8 0
    bge MD_FAST_DONE
    ldloc.s r
    ldloc.s y
    add
    stloc.s r
  MD_FAST_DONE:
    ldloc.s r
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  MD_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s ba
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    stloc.s bb
    ldloc.s ba
    ldloc.s bb
    ldloca.s bdu
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::DivRem(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger&)
    stloc.s bq
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldc.i4.0
    beq MD_SLOW_DONE
    ldloca.s bdu
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    ldloca.s bb
    call instance int32 [System.Numerics]System.Numerics.BigInteger::get_Sign()
    beq MD_SLOW_DONE
    ldloc.s bdu
    ldloc.s bb
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Addition(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    stloc.s bdu
  MD_SLOW_DONE:
    ldloc.s bdu
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Pow(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 e)
    ldarga.s b
    ldfld object TkvInt::big
    brtrue PW_HUGE
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s e
    ldloc.s e
    ldc.i8 0
    blt PW_NEG
    ldloc.s e
    ldc.i8 2147483647
    bgt PW_HUGE
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldloc.s e
    conv.i4
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Pow(valuetype [System.Numerics]System.Numerics.BigInteger, int32)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  PW_NEG:
    ldstr "int ** so mu am tra ve float trong Python - TokenVector chua co duong int->float (moc 10). Doi ve f64 truoc khi luy thua."
    newobj instance void [mscorlib]System.NotSupportedException::.ctor(string)
    throw
  PW_HUGE:
    ldstr "int ** so mu qua lon (> 2^31-1): ket qua khong the vua bo nho."
    newobj instance void [mscorlib]System.OverflowException::.ctor(string)
    throw
  }
  .method public static valuetype TkvInt Neg(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (int64 x)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue NG_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloc.s x
    ldc.i8 0x8000000000000000
    beq NG_SLOW
    ldc.i8 0
    ldloc.s x
    sub
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  NG_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Negate(valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Add(valuetype TkvInt a, valuetype TkvInt b) cil managed
  {
    .maxstack 8
    .locals init (int64 x, int64 y, int64 r)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue AD_SLOW
    ldarga.s b
    ldfld object TkvInt::big
    brtrue AD_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldarga.s b
    ldfld int64 TkvInt::lo
    stloc.s y
    ldloc.s x
    ldloc.s y
    add
    stloc.s r
    ldloc.s x
    ldloc.s r
    xor
    ldloc.s y
    ldloc.s r
    xor
    and
    ldc.i8 0
    blt AD_SLOW
    ldloc.s r
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  AD_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    ldarg.1
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::op_Addition(valuetype [System.Numerics]System.Numerics.BigInteger, valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt Abs(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    .locals init (int64 x)
    ldarga.s a
    ldfld object TkvInt::big
    brtrue AB_SLOW
    ldarga.s a
    ldfld int64 TkvInt::lo
    stloc.s x
    ldloc.s x
    ldc.i8 0
    bge AB_POS
    ldloc.s x
    ldc.i8 0x8000000000000000
    beq AB_SLOW
    ldc.i8 0
    ldloc.s x
    sub
    call valuetype TkvInt TkvInt::FromI64(int64)
    ret
  AB_POS:
    ldarg.0
    ret
  AB_SLOW:
    ldarg.0
    call valuetype [System.Numerics]System.Numerics.BigInteger TkvInt::ToBig(valuetype TkvInt)
    call valuetype [System.Numerics]System.Numerics.BigInteger [System.Numerics]System.Numerics.BigInteger::Abs(valuetype [System.Numerics]System.Numerics.BigInteger)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static valuetype TkvInt FromF64(float64 d) cil managed
  {
    .maxstack 8
    ldarg.0
    newobj instance void [System.Numerics]System.Numerics.BigInteger::.ctor(float64)
    call valuetype TkvInt TkvInt::FromBig(valuetype [System.Numerics]System.Numerics.BigInteger)
    ret
  }
  .method public static int32 IsZero(valuetype TkvInt a) cil managed
  {
    .maxstack 8
    ldarga.s a
    ldfld object TkvInt::big
    brtrue IZ_BIG
    ldarga.s a
    ldfld int64 TkvInt::lo
    ldc.i8 0
    ceq
    ret
  IZ_BIG:
    ldc.i4.0
    ret
  }
}
.class public auto ansi beforefieldinit TkvRandom extends [mscorlib]System.Object
{
  .field private static class [mscorlib]System.Random rng
  .method public static class [mscorlib]System.Random Instance() cil managed
  {
    .maxstack 8
    ldsfld class [mscorlib]System.Random TkvRandom::rng
    brtrue TKVRANDOM_HAVE
    newobj instance void [mscorlib]System.Random::.ctor()
    stsfld class [mscorlib]System.Random TkvRandom::rng
  TKVRANDOM_HAVE:
    ldsfld class [mscorlib]System.Random TkvRandom::rng
    ret
  }
  .method public static void SetSeed(int32 n) cil managed
  {
    .maxstack 8
    ldarg.0
    newobj instance void [mscorlib]System.Random::.ctor(int32)
    stsfld class [mscorlib]System.Random TkvRandom::rng
    ret
  }
}

.class public auto ansi TKVApp extends [mscorlib]System.Object
{
  .method public static string 'generate_password'(int32 'length') cil managed
  {
    .maxstack 11
    .locals init (string 'pool', string 'result', valuetype TkvInt 'idx', string 'candidate', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    ldstr "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$%^&*()-_=+[]{}<>?"
    stloc.s 0
    ldarg.s 0
    ldc.i4 8
    clt
    brfalse generate_password_If1_else
    ldc.i4 8
    starg.s 0
  generate_password_If1_else:
    ldarg.s 0
    ldc.i4 64
    cgt
    brfalse generate_password_If2_else
    ldc.i4 64
    starg.s 0
  generate_password_If2_else:
    ldstr ""
    stloc.s 1
    ldc.i8 0
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 2
  generate_password_W3_start:
    ldloc.s 2
    ldarg.s 0
    conv.i8
    call valuetype TkvInt TkvInt::FromI64(int64)
    call int32 TkvInt::Cmp(valuetype TkvInt, valuetype TkvInt)
    ldc.i4.0
    clt
    brfalse generate_password_W3_end
    ldloc.s 0
    call class [mscorlib]System.Random TkvRandom::Instance()
    ldc.i4 0
    ldloc.s 0
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 1
    sub.ovf
    ldc.i4.1
    add
    callvirt instance int32 [mscorlib]System.Random::Next(int32, int32)
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    ldc.i4.1
    newobj instance void [mscorlib]System.String::.ctor(char, int32)
    stloc.s 3
    ldloc.s 1
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 0
    ceq
    dup
    brtrue generate_password_sc5_end
    pop
    ldloc.s 3
    ldloc.s 1
    ldloc.s 1
    callvirt instance int32 [mscorlib]System.String::get_Length()
    ldc.i4 1
    sub.ovf
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    ldc.i4.1
    newobj instance void [mscorlib]System.String::.ctor(char, int32)
    call bool [mscorlib]System.String::Equals(string, string)
    ldc.i4.0
    ceq
  generate_password_sc5_end:
    brfalse generate_password_If4_else
    ldloc.s 1
    ldloc.s 3
    call string [mscorlib]System.String::Concat(string, string)
    stloc.s 1
  generate_password_If4_else:
    ldloc.s 2
    ldc.i8 1
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 5
    stloc.s 4
    ldloca.s 4
    ldfld object TkvInt::big
    brtrue generate_password_int6_slow
    ldloca.s 5
    ldfld object TkvInt::big
    brtrue generate_password_int6_slow
    ldloca.s 4
    ldfld int64 TkvInt::lo
    ldloca.s 5
    ldfld int64 TkvInt::lo
    add
    stloc.s 7
    ldloca.s 4
    ldfld int64 TkvInt::lo
    ldloc.s 7
    xor
    ldloca.s 5
    ldfld int64 TkvInt::lo
    ldloc.s 7
    xor
    and
    ldc.i8 0
    blt generate_password_int6_slow
    ldloca.s 6
    ldloc.s 7
    stfld int64 TkvInt::lo
    ldloca.s 6
    ldnull
    stfld object TkvInt::big
    ldloc.s 6
    br generate_password_int6_done
  generate_password_int6_slow:
    ldloc.s 4
    ldloc.s 5
    call valuetype TkvInt TkvInt::AddSlow(valuetype TkvInt, valuetype TkvInt)
  generate_password_int6_done:
    stloc.s 2
    br generate_password_W3_start
  generate_password_W3_end:
    ldloc.s 1
    ret
  }
  .method public static int32 'main'() cil managed
  {
    .maxstack 10
    .locals init (class [mscorlib]System.Collections.Generic.List`1<string> 'args', valuetype TkvInt 'port', valuetype TkvInt 'length', valuetype TkvInt '__tkvint_a', valuetype TkvInt '__tkvint_b', valuetype TkvInt '__tkvint_r', int64 '__tkvint_x', valuetype [System.Numerics]System.Numerics.Complex '__tkvcplx_str', object '__arr2d_src', object '__arr2d_dst', int32 '__arr2d_i', int32 '__arr2d_n')
    call string[] [mscorlib]System.Environment::GetCommandLineArgs()
    newobj instance void class [mscorlib]System.Collections.Generic.List`1<string>::.ctor(class [mscorlib]System.Collections.Generic.IEnumerable`1<!0>)
    stloc.s 0
    ldloc.s 0
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    ldc.i4 1
    cgt
    dup
    brfalse main_sc2_end
    pop
    ldloc.s 0
    ldc.i4 1
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<string>::get_Item(int32)
    ldstr "--server"
    call bool [mscorlib]System.String::Equals(string, string)
  main_sc2_end:
    brfalse main_If1_else
    ldc.i8 8765
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 1
    ldc.i8 24
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 2
    ldloc.s 0
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    ldc.i4 2
    cgt
    brfalse main_If3_else
    ldloc.s 0
    ldc.i4 2
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<string>::get_Item(int32)
    call valuetype TkvInt TkvInt::FromStr(string)
    stloc.s 1
  main_If3_else:
    ldloc.s 0
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    ldc.i4 3
    cgt
    brfalse main_If4_else
    ldloc.s 0
    ldc.i4 3
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<string>::get_Item(int32)
    call valuetype TkvInt TkvInt::FromStr(string)
    stloc.s 2
  main_If4_else:
    ldstr "Crypto HTTP server listening on 127.0.0.1:"
    ldloc.s 1
    call string TkvInt::Str(valuetype TkvInt)
    call string [mscorlib]System.String::Concat(string, string)
    call void [mscorlib]System.Console::WriteLine(string)
    ldloc.s 1
    call int32 TkvInt::ToI32(valuetype TkvInt)
    ldloc.s 2
    call int32 TkvInt::ToI32(valuetype TkvInt)
    call int32 class TKVApp::TkvHttpServerGenerate(int32, int32)
    ret
  main_If1_else:
    ldc.i8 24
    call valuetype TkvInt TkvInt::FromI64(int64)
    stloc.s 2
    ldloc.s 0
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    ldc.i4 1
    cgt
    dup
    brfalse main_sc6_end
    pop
    ldloc.s 0
    ldc.i4 1
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<string>::get_Item(int32)
    ldstr "--generate"
    call bool [mscorlib]System.String::Equals(string, string)
  main_sc6_end:
    brfalse main_If5_else
    ldloc.s 0
    callvirt instance int32 class [mscorlib]System.Collections.Generic.List`1<string>::get_Count()
    ldc.i4 2
    cgt
    brfalse main_If7_else
    ldloc.s 0
    ldc.i4 2
    callvirt instance !0 class [mscorlib]System.Collections.Generic.List`1<string>::get_Item(int32)
    call valuetype TkvInt TkvInt::FromStr(string)
    stloc.s 2
  main_If7_else:
    ldloc.s 2
    call int32 TkvInt::ToI32(valuetype TkvInt)
    call string TKVApp::'generate_password'(int32)
    call void [mscorlib]System.Console::WriteLine(string)
    ldc.i4 0
    ret
  main_If5_else:
    ldstr "Usage: crypto_bridge.exe --generate [length]"
    call void [mscorlib]System.Console::WriteLine(string)
    ldc.i4 1
    ret
  }
  .method public static void Main(string[] args) cil managed
  {
    .entrypoint
    .maxstack 8
    .locals init (int32 __cli_ret)
    call int32 TKVApp::'main'()
    stloc.0
    ldloca.s 0
    call instance string [mscorlib]System.Int32::ToString()
    call void [mscorlib]System.Console::WriteLine(string)
    ret
  }
  .method public static string GetVaultPath() cil managed
  {
    .maxstack 8
    call class [mscorlib]System.Reflection.Assembly [mscorlib]System.Reflection.Assembly::GetExecutingAssembly()
    callvirt instance string [mscorlib]System.Reflection.Assembly::get_Location()
    call string [mscorlib]System.IO.Path::GetDirectoryName(string)
    ldstr "PasswordVault.vault.json"
    call string [mscorlib]System.IO.Path::Combine(string, string)
    ret
  }
  .method public hidebysig static int32 TkvHttpServerGenerate(int32 port, int32 length) cil managed
  {
    .maxstack 12
    .locals init (class [System]System.Net.HttpListener listener, class [System]System.Net.HttpListenerContext context, class [System]System.Net.HttpListenerResponse response, class [mscorlib]System.Security.Cryptography.RNGCryptoServiceProvider random, class [mscorlib]System.Text.StringBuilder builder, class [mscorlib]System.IO.StreamWriter writer, int32 index, string password, string body, uint8[] random_bytes, string path, string request_body, class [mscorlib]System.IO.StreamReader reader, string query, string length_text, int32 query_index, int32 amp_index, int32 requested_length, int32 effective_length)
    newobj instance void [System]System.Net.HttpListener::.ctor()
    stloc.0
    ldloc.0
    callvirt instance class [System]System.Net.HttpListenerPrefixCollection [System]System.Net.HttpListener::get_Prefixes()
    ldstr "http://127.0.0.1:"
    ldarga.s 0
    call instance string [mscorlib]System.Int32::ToString()
    ldstr "/"
    call string [mscorlib]System.String::Concat(string, string, string)
    callvirt instance void [System]System.Net.HttpListenerPrefixCollection::Add(string)
    ldloc.0
    callvirt instance void [System]System.Net.HttpListener::Start()
  server_loop:
    ldloc.0
    callvirt instance class [System]System.Net.HttpListenerContext [System]System.Net.HttpListener::GetContext()
    stloc.1
    ldloc.1
    callvirt instance class [System]System.Net.HttpListenerResponse [System]System.Net.HttpListenerContext::get_Response()
    stloc.2
    ldloc.2
    callvirt instance class [System]System.Net.WebHeaderCollection [System]System.Net.HttpListenerResponse::get_Headers()
    ldstr "Access-Control-Allow-Origin"
    ldstr "*"
    callvirt instance void [System]System.Net.WebHeaderCollection::Set(string, string)
    ldloc.1
    callvirt instance class [System]System.Net.HttpListenerRequest [System]System.Net.HttpListenerContext::get_Request()
    callvirt instance class [System]System.Uri [System]System.Net.HttpListenerRequest::get_Url()
    callvirt instance string [System]System.Uri::get_AbsolutePath()
    stloc.s path
    ldarg.1
    stloc.s 18
    // --- Cho phep ghi de do dai bang query ?length=N (8..64) ---
    ldloc.1
    callvirt instance class [System]System.Net.HttpListenerRequest [System]System.Net.HttpListenerContext::get_Request()
    callvirt instance class [System]System.Uri [System]System.Net.HttpListenerRequest::get_Url()
    callvirt instance string [System]System.Uri::get_Query()
    stloc.s 13
    ldloc.s 13
    brfalse.s length_override_done
    ldloc.s 13
    ldstr "length="
    callvirt instance int32 [mscorlib]System.String::IndexOf(string)
    stloc.s 15
    ldloc.s 15
    ldc.i4.m1
    beq.s length_override_done
    ldloc.s 13
    ldloc.s 15
    ldc.i4.7
    add
    callvirt instance string [mscorlib]System.String::Substring(int32)
    stloc.s 14
    ldloc.s 14
    ldc.i4.s 38
    callvirt instance int32 [mscorlib]System.String::IndexOf(char)
    stloc.s 16
    ldloc.s 16
    ldc.i4.m1
    beq.s length_override_parse
    ldloc.s 14
    ldc.i4.0
    ldloc.s 16
    callvirt instance string [mscorlib]System.String::Substring(int32, int32)
    stloc.s 14
  length_override_parse:
    ldloc.s 14
    ldloca.s 17
    call bool [mscorlib]System.Int32::TryParse(string, int32&)
    brfalse.s length_override_done
    ldloc.s 17
    ldc.i4.8
    blt.s length_override_done
    ldloc.s 17
    ldc.i4.s 64
    bgt.s length_override_done
    ldloc.s 17
    stloc.s 18
  length_override_done:
    ldloc.s path
    ldstr "/health"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue health_response
    ldloc.s path
    ldstr "/vault"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue vault_response
    newobj instance void [mscorlib]System.Security.Cryptography.RNGCryptoServiceProvider::.ctor()
    stloc.3
    ldc.i4.1
    newarr [mscorlib]System.Byte
    stloc.s random_bytes
    newobj instance void [mscorlib]System.Text.StringBuilder::.ctor()
    stloc.s builder
    ldc.i4.0
    stloc.s index
  password_loop:
    ldloc.s index
    ldloc.s 18
    bge password_done
    ldloc.s builder
    ldstr "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$%^&*()-_=+[]{}<>?"
    ldloc.3
    ldloc.s random_bytes
    callvirt instance void [mscorlib]System.Security.Cryptography.RNGCryptoServiceProvider::GetBytes(uint8[])
    ldloc.s random_bytes
    ldc.i4.0
    ldelem.u1
    ldc.i4.s 78
    rem
    callvirt instance char [mscorlib]System.String::get_Chars(int32)
    callvirt instance class [mscorlib]System.Text.StringBuilder [mscorlib]System.Text.StringBuilder::Append(char)
    pop
    ldloc.s index
    ldc.i4.1
    add
    stloc.s index
    br password_loop
  password_done:
    ldloc.s builder
    callvirt instance string [mscorlib]System.Text.StringBuilder::ToString()
    stloc.s password
    ldstr "{\"password\":\""
    ldloc.s password
    ldstr "\",\"source\":\"crypto_engine.exe\"}"
    call string [mscorlib]System.String::Concat(string, string, string)
    stloc.s body
    ldloc.2
    ldstr "application/json; charset=utf-8"
    callvirt instance void [System]System.Net.HttpListenerResponse::set_ContentType(string)
    ldloc.2
    callvirt instance class [mscorlib]System.IO.Stream [System]System.Net.HttpListenerResponse::get_OutputStream()
    newobj instance void [mscorlib]System.IO.StreamWriter::.ctor(class [mscorlib]System.IO.Stream)
    stloc.s writer
    ldloc.s writer
    ldloc.s body
    callvirt instance void [mscorlib]System.IO.TextWriter::Write(string)
    ldloc.s writer
    callvirt instance void [mscorlib]System.IO.TextWriter::Close()
    ldloc.2
    callvirt instance void [System]System.Net.HttpListenerResponse::Close()
    br server_loop
  health_response:
    ldloc.2
    ldstr "application/json; charset=utf-8"
    callvirt instance void [System]System.Net.HttpListenerResponse::set_ContentType(string)
    ldloc.2
    callvirt instance class [mscorlib]System.IO.Stream [System]System.Net.HttpListenerResponse::get_OutputStream()
    newobj instance void [mscorlib]System.IO.StreamWriter::.ctor(class [mscorlib]System.IO.Stream)
    stloc.s writer
    ldloc.s writer
    ldstr "{\"ok\":true}"
    callvirt instance void [mscorlib]System.IO.TextWriter::Write(string)
    ldloc.s writer
    callvirt instance void [mscorlib]System.IO.TextWriter::Close()
    br server_loop
  vault_response:
    ldloc.1
    callvirt instance class [System]System.Net.HttpListenerRequest [System]System.Net.HttpListenerContext::get_Request()
    callvirt instance string [System]System.Net.HttpListenerRequest::get_HttpMethod()
    ldstr "POST"
    call bool [mscorlib]System.String::op_Equality(string, string)
    brtrue vault_write
    call string TKVApp::GetVaultPath()
    stloc.s path
    ldloc.s path
    call bool [mscorlib]System.IO.File::Exists(string)
    brfalse vault_missing
    ldloc.s path
    call string [mscorlib]System.IO.File::ReadAllText(string)
    stloc.s body
    br vault_send
  vault_missing:
    ldloc.2
    ldc.i4 404
    callvirt instance void [System]System.Net.HttpListenerResponse::set_StatusCode(int32)
    ldstr ""
    stloc.s body
    br vault_send
  vault_write:
    ldloc.1
    callvirt instance class [System]System.Net.HttpListenerRequest [System]System.Net.HttpListenerContext::get_Request()
    callvirt instance class [mscorlib]System.IO.Stream [System]System.Net.HttpListenerRequest::get_InputStream()
    newobj instance void [mscorlib]System.IO.StreamReader::.ctor(class [mscorlib]System.IO.Stream)
    stloc.s reader
    ldloc.s reader
    callvirt instance string [mscorlib]System.IO.TextReader::ReadToEnd()
    stloc.s request_body
    call string TKVApp::GetVaultPath()
    ldloc.s request_body
    call void [mscorlib]System.IO.File::WriteAllText(string, string)
    ldloc.s request_body
    stloc.s body
  vault_send:
    ldloc.2
    ldstr "application/json; charset=utf-8"
    callvirt instance void [System]System.Net.HttpListenerResponse::set_ContentType(string)
    ldloc.2
    callvirt instance class [mscorlib]System.IO.Stream [System]System.Net.HttpListenerResponse::get_OutputStream()
    newobj instance void [mscorlib]System.IO.StreamWriter::.ctor(class [mscorlib]System.IO.Stream)
    stloc.s writer
    ldloc.s writer
    ldloc.s body
    callvirt instance void [mscorlib]System.IO.TextWriter::Write(string)
    ldloc.s writer
    callvirt instance void [mscorlib]System.IO.TextWriter::Close()
    br server_loop
    ldc.i4.0
    ret
  }
}
