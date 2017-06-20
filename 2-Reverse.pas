PROGRAM gauss;
USES crt;
TYPE
  Matr = ARRAY [1..20, 1..20] OF REAL;
  Vect = ARRAY [1..20] OF REAL;

PROCEDURE MainEl(VAR a: Matr; VAR e: Matr; t, m: WORD);
VAR
  i,j,k,s: WORD;
  u,v: Vect;
  p: REAL;

BEGIN
  FOR j := t TO m DO
    BEGIN
      p := a[j,j];
      FOR i := j TO m DO
        BEGIN
          IF Abs(a[i,j]) >= Abs(p) THEN
            BEGIN
              p := a[i,j];
              s := i;
            END;
         END;
      FOR k := 1 TO m DO
        BEGIN
          u[k] := a[s,k];
          a[s,k] := a[j,k];
          a[j,k] := u[k];

          v[k] := e[s,k];
          e[s,k] := e[j,k];
          e[j,k] := v[k];
        END;

      IF Abs(a[j,j]) = 0 THEN
        BEGIN
          WriteLn;
          WriteLn('Matrix is degenerate!');
          ReadKey;
          Exit;
        END;
    END;
END;


  {Solution}

VAR
  a,x,e: Matr;
  i,j,n,m,k: WORD;
  t: REAL;

BEGIN
  ClrScr;
  Write('Input dimension = '); ReadLn(n);
  IF n < 2 THEN
    WriteLn('Need n >= 2!');

  FOR i := 1 TO n DO
    BEGIN
      FOR j := 1 TO n DO
        BEGIN
          Write('a(', i, ', ', j, ') = '); ReadLn(a[i,j]);
          IF i <> j THEN
            e[i,j] := 0
          ELSE e[i,j] := 1;
        END;
    END;

  FOR i := 1 TO n DO
    BEGIN
      MainEl(a,e,i,n);
      t := a[i,i];

      FOR j := 1 TO n DO
        BEGIN
          a[i,j] := a[i,j] / t;
          e[i,j] := e[i,j] / t;
        END;

      FOR k := (i+1) TO n DO
        BEGIN
          t := a[k,i];
          FOR j := 1 TO n DO
            BEGIN
              e[k,j] := e[k,j] - e[i,j] * t;
            END;
          FOR j := i TO n DO
            BEGIN
              a[k,j] := a[k,j] - a[i,j] * t;
            END;
        END;

      FOR k := (i-1) DOWNTO 1 DO
        BEGIN
          t := a[k,i];
          FOR j := 1 TO n DO
            BEGIN
              e[k,j] := e[k,j] - e[i,j] * t;
            END;
          FOR j := i TO n DO
            BEGIN
              a[k,j] := a[k,j] - a[i,j] * t;
            END;
        END;

    END;

  WriteLn;
  FOR i := 1 TO n DO
    BEGIN
      FOR j := 1 TO n DO
        BEGIN
          Write('    ', a[i,j]:3:1);
        END;
       WriteLn;
    END;

  WriteLn;
  FOR i := 1 TO n DO
    BEGIN
      FOR j := 1 TO n DO
        BEGIN
          Write('    ', e[i,j]:3:1);
        END;
      WriteLn;
    END;

  ReadKey;
END.
