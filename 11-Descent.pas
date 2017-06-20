PROGRAM spusk;
USES crt;
TYPE
  Vect = ARRAY [1..20] OF REAL;
  Matr = ARRAY [1..20, 1..20] OF REAL;

{---Spusk method for algebrian system---}
{---Matrix G must be symmetrix & "+" defined---}

FUNCTION skal(m: WORD; a: Vect; b: Vect): REAL;
VAR
  i: WORD;
  s: REAL;
BEGIN
  s := 0;
  FOR i := 1 TO m DO
    BEGIN
      s := s + a[i] * b[i];
    END;
  skal := s;
END;


PROCEDURE matrXvect(m: WORD; A: Matr; b: Vect; VAR y: Vect);
VAR
  i, j: WORD;
BEGIN
  FOR i := 1 TO m DO
    BEGIN
      y[i] := 0;
      FOR j := 1 TO m DO
        BEGIN
          y[i] := y[i] + A[i,j] * b[j];
        END;
    END;
END;

{Solution}

VAR
  i, j, m, k, n: WORD;
  G: Matr;
  a, d, w, y: Vect;
  t, u, eps: REAL;

BEGIN
  ClrScr;
  Write('Input stepen = '); ReadLn(m);
  Write('Input pogreshnost = '); ReadLn(eps);

  FOR i := 1 TO m DO
    BEGIN
      FOR j := 1 TO m DO
        BEGIN
          Write('G(', i,', ', j, ') = '); ReadLn(G[i,j]);
        END;
    END;

  FOR i := 1 TO m DO
    BEGIN
      Write('a(', i, ') = '); ReadLn(a[i]);
    END;

  FOR i := 1 TO m DO
    BEGIN
      Write('d(', i, ') = '); ReadLn(d[i]);
    END;

  matrXvect(m, G, a, w);
  FOR i := 1 TO m DO
    BEGIN
      w[i] := w[i] - d[i];
    END;
  matrXvect(m, G, w, y);

  u := skal(m,y,w);
  eps := sqr(eps);
  k := 0;
  WHILE u >= eps DO
    BEGIN
      t := skal(m,w,w);
      t := t/u;
      k := k + 1;
      FOR i := 1 TO m DO
        BEGIN
          a[i] := a[i] - t * w[i];
          w[i] := w[i] - t * y[i];
        END;
      matrXvect(m, G, w, y);
      u := skal(m,y,w);
    END;

  WriteLn;
  WriteLn('Kolichestvo iterazii = ', k);
  FOR i := 1 TO m DO
    BEGIN
      WriteLn('a(', i, ') = ', a[i]);
    END;
  ReadKey;
END.
