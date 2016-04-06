FUNCTION_BLOCK fbTimer
  VAR_INPUT
      start      : bool r_edge;
      reset      : bool r_edge;
      timeToCount: time;
  END_VAR
  VAR_OUTPUT
      isRun : bool;
      isDone: bool;
      currentTime : time;
  END_VAR
  VAR_IN_OUT
  END_VAR
  VAR
      timer: TON;
  END_VAR
  VAR_TEMP
  END_VAR

         if start and not isRun then
            timer.IN := true;
            start    := false;
            isRun    := true;
            isDone   := false;
            timer.PT := timeToCount;
         end_if;

         if start and isRun then
            timer(IN :=false);
            timer(IN :=true);
         end_if;

         if isRun then
            timer();
            if timer.ET>=timer.PT then
               isDone:=true;
               isRun :=false;
               timer.IN:=false;
               timer();
            end_if;
         end_if;

         if reset then
            timer.IN:=false;
            isDone:=false;
            isRun:=false;
            timer();
         end_if;

         timer();
         currentTime:=timer.ET;
END_FUNCTION_BLOCK
