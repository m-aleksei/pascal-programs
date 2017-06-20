PROGRAM puasson;
USES crt;
TYPE
  Vect = ARRAY [0..100] OF REAL;

VAR
  x, y, h, tau, f, r: REAL;
  x0, xM: REAL;
  y0, yN: REAL;
  i, N, j, M, k: INTEGER;
  dd, u: Vect;

FUNCTION func(xx, yy: REAL): REAL; {checked}
VAR
  t2: REAL;
BEGIN
  t2 := 2 * (yy-1) * sqr(yy) * (3*xx-2) + 2 * xx * sqr(xx-1) * (3*yy-1);
  func := t2;
END;

FUNCTION skal(kk: INTEGER; aa, bb: Vect): REAL;
VAR
  jj: INTEGER;
  ss: REAL;

BEGIN
  ss := 0;
  FOR jj := 1 TO kk DO
    BEGIN
       ss := ss + aa[jj] * bb[jj];
    END;
  skal := ss;
END;

PROCEDURE matrXvect(p: INTEGER; hh, ttau: REAL; b: Vect; VAR y1: Vect);
VAR
  g, v, c, ii: INTEGER;
  z, tau1, tau2: REAL;

BEGIN
  g := 0; v := 0;
  hh := sqr(hh);
  ttau := sqr(ttau);
  z := (-2) * (hh + ttau);
  tau1 := ttau; tau2 := ttau;

  y1[1] := z * b[1] + tau2 * b[2] + hh * b[M];

    FOR ii := 2 TO (M-1) DO
      BEGIN
        IF (ii = M-1) THEN
          BEGIN
            tau2 := 0;
          END;
        y1[ii] := z * b[ii] + tau1 * b[ii-1] + tau2 * b[ii+1] + hh * b[ii+M-1];
        tau2 := ttau;
      END;

  c := 1;
  g := c * (M-1) + 1;
  v := c * (M-1);

    FOR ii := M TO (p-M+1) DO
      BEGIN
        IF (ii = g) THEN
          BEGIN
            tau1 := 0;
            c := c + 1;
            g := c * (M-1) + 1;
            v := c * (M-1);
          END;
        IF (ii = v) THEN
          BEGIN
            tau2 := 0;
          END;
        y1[ii] := z * b[ii] + tau1 * b[ii-1] + tau2 * b[ii+1] + hh * b[ii+M-1] + hh * b[ii-M+1];
        tau1 := ttau; tau2 := ttau;
      END;

    FOR ii := (p-M+2) TO (p-1) DO
      BEGIN
        IF (ii = p-M+2) THEN
          BEGIN
            tau1 := 0;
          END;
        y1[ii] := z * b[ii] + tau1 * b[ii-1] + tau2 * b[ii+1] + hh * b[ii-M+1];
        tau1 := ttau;
      END;

    y1[p] := z * b[p] + tau1 * b[p-1] + hh * b[p-M+1];

END;

PROCEDURE spusk(mm: INTEGER; d: Vect; VAR a: Vect);
VAR
  uu, eps, tt: REAL;
  i1: INTEGER;
  w, y: Vect;
  h1, tau1: REAL;

BEGIN
  eps := 0.000000000000000001; {max is 18 zeros}
  h1 := h;
  tau1 := tau;

  FOR i1 := 1 TO mm DO
    BEGIN
      y[i1] := 0;
      w[i1] := 0;
    END;

  matrXvect(mm, h1, tau1, a, w);

  FOR i1 := 1 TO mm DO
    BEGIN
      w[i1] := w[i1] - d[i1];
    END;

  matrXvect(mm, h1, tau1, w, y);

  uu := skal(mm,y,w);
  eps := sqr(eps);

  WHILE Abs(uu) >= eps DO
    BEGIN
      tt := skal(mm,w,w);
      tt := tt / uu;
      FOR i1 := 1 TO mm DO
        BEGIN
          a[i1] := a[i1] - tt * w[i1];
          w[i1] := w[i1] - tt * y[i1];
        END;
      matrXvect(mm, h1, tau1, w, y);
      uu := skal(mm,y,w);
    END;
END;

{Solution}

BEGIN
  ClrScr;
{  Write('Input x0 = '); ReadLn(x0);
  Write('Input xM = '); ReadLn(xM);
  Write('Input partition of segment M = '); ReadLn(M);
  Write('Input y0 = '); ReadLn(y0);
  Write('Input yN = '); ReadLn(yN);
  Write('Input partition of segment N = '); ReadLn(yN);
}
  x0 := 0; xM := 1; M := 10; N := 10; y0 := 0; yN := 1;

  h := (xM - x0) / M;
  tau := (yN - y0) / N;
  r := sqr(tau) * sqr(h);

  k := 0;
  FOR i := 1 TO (N-1) DO
    BEGIN
      y := i * tau;
      FOR j := 1 TO (M-1) DO
        BEGIN
          x := j * h;
          f := func(x,y);
          k := k + 1;
          dd[k] := r * f;
        END;
    END;

  FOR i := 1 TO k DO {first vector of spusk method}
    BEGIN
      u[i] := 0;
    END;

  spusk(k,dd,u);

  i := 0;

  WHILE i < N DO
    BEGIN
      Write('Layer: '); ReadLn(i);
      IF (i <= 0) OR (i > N) THEN
        BEGIN
          WriteLn('You out of layers! ');
          ReadKey;
          Exit;
        END;
      k := i * (M-1);
      FOR j := (k-M+2) TO k DO
        BEGIN
          WriteLn(' u(', j, ') = ', u[j]:8:8);
        END;
    END;

  ReadKey;
END.
