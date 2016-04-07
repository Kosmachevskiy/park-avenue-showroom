FUNCTION_BLOCK fbBlindController
  VAR_INPUT
    timeTo_up_down : time;
    open           : bool r_edge;
    close          : bool r_edge;
    stop           : bool r_edge;
  END_VAR
  Var_in_out
    position       :real;
  end_var
  VAR_OUTPUT
    up             : bool;
    down           : bool;
  END_VAR
  VAR
   currentPosition   :real:= 0.0;
   timeOfUpDown      :udint;
   set               :real:= 0.0;
   timer             :fbtick;
   slider            :bool;
   key               :bool;
   reverseDelayTimer :TON;
   reverseToDown     :bool;
   reverseToUp       :bool;
  END_VAR
  VAR_TEMP
  END_VAR


  timeOfUpDown := TIME_TO_UDINT(timeTo_up_down/100);

  timer(IN :=true, PT := UDINT_TO_TIME(timeOfUpDown));

  reverseDelayTimer(PT := t#500ms);

  if (currentPosition > 100.) then
     currentPosition := 100.;
     position := currentPosition;
  end_if;

  if (currentPosition < 0.) then
     currentPosition := 0.;
     position := currentPosition;
  end_if;

  if position > 100. then
     position := 100.;
  end_if;

  if position < 0. then
     position := 0.;
  end_if;

  if open then
     position := 100.;
  end_if;

  if close then
     position := 0.;
  end_if;

  if stop then
     position := currentPosition;
  end_if;

  if position <> currentPosition then
     if position > currentPosition then
        if down then
           reverseToUp := true;
        else
        up := true;
        down := false;
        end_if;
     end_if;
     if position < currentPosition then
        if up then
           reverseToDown := true;
        else
        up := false;
        down := true;
        end_if;
     end_if;
  else
      up   := false;
      down := false;
      reverseDelayTimer.IN := false;
      reverseToDown        := false;
      reverseToUp          := false;
  end_if;

  if reverseToUp or reverseToDown then
     reverseDelayTimer.IN := true;
  end_if;

  if reverseDelayTimer.IN then
     up   := false;
     down := false;
  end_if;

  if reverseDelayTimer.Q then
     if reverseToUp then
        up := true;
        reverseToUp := false;
     end_if;
     if reverseToDown then
        down := true;
        reverseToDown := false;
     end_if;
     reverseDelayTimer.IN := false;
  end_if;

  if up and timer.Q then
     currentPosition := currentPosition + 1.;
  end_if;

  if down and timer.Q then
     currentPosition := currentPosition - 1.;
  end_if;

END_FUNCTION_BLOCK


