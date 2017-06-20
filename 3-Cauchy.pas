PROGRAM kosh;
USES crt;

VAR
  x0, y0, xN, h0, eps: REAL;
  y1, h: REAL;


FUNCTION func (x,y:REAL): REAL;
BEGIN
  func := 2 * x * exp(x) + y;
END;

FUNCTION Step (x, y, h: REAL): REAL; { approximation to y(x+h) }
VAR
  Fi0, Fi1, Fi2, Fi3: REAL;
BEGIN
  Fi0 := h * func(x,y);
  Fi1 := h * func(x + h/2, y + Fi0/2);
  Fi2 := h * func(x + h/2, y + Fi1/2);
  Fi3 := h * func(x + h, y + Fi2);
  Step := y + (Fi0 + 2 * Fi1 + 2 * Fi2 + Fi3)/6; { by Simpson method }
END;

PROCEDURE Jump (h0, x0, y0: REAL; VAR h, y1: REAL); { changing steps }
VAR
  y05, y11: REAL;
BEGIN
  y1 := Step(x0, y0, h0);
  h := h0/2;
  y05 := Step(x0, y0, h);
  y11 := Step(x0+h, y05, h);

  WHILE (Abs(y1 - y11) >= eps) DO
    BEGIN
      y1 := y05;
      h := h/2;
      y05 := Step(x0, y0,h);
      y11 := Step(x0+h, y05, h);
    END;
  h := 2 * h;
END;

{Solution}

BEGIN
  ClrScr;
  Write('Input x0 = '); ReadLn(x0);
  Write('Input xN = '); ReadLn(xN);
  Write('Input y0 = '); ReadLn(y0);
  Write('Input tochnost eps = '); ReadLn(eps);
  Write('Input start step: '); ReadLn(h0);

{ x0 := 0; xN := 1; y0 := 0; eps := 0.00001; h0 := 0.3; - test }

  WHILE (xN - x0) > 0 DO
    BEGIN
      IF (xN - x0) < h0 THEN
        h0 := xN - x0;

      Jump (h0, x0, y0, h, y1);
      x0 := x0 + h;

      WriteLn;
      Write('  Step = ', h:8:8);
      Write(' x = ', x0:8:8); Write('   y = ', y1:8:8);
      WriteLn;
      y0 := y1;
    END;

  h := exp(1);
  eps := Abs(h - y1);
  WriteLn;
  Write('Pogresh: ', eps:8:8);
  ReadKey;
END.
