FUNCTION_BLOCK fbBlindController
  VAR_INPUT
    timeTo_up_down : time;
    open           : bool r_edge;
    close          : bool r_edge;
    stop           : bool r_edge;
    setPosition    : real;
  END_VAR
  VAR_OUTPUT
    up             : bool;
    down           : bool;
    currentPosition: real:=100;
  END_VAR
  VAR_IN_OUT
  
  END_VAR
  VAR
    t1             : time;
    timer          : fbTimer;
    direction      : bool;    (*True - UP, False - DOWN*)
    position       : real:=100;
    stopTtigg      : r_trig;
    openTrigg      : r_trig;
    closeTrigg     : r_trig;
  END_VAR
  VAR_TEMP
  
  END_VAR

  timer();
  if timer.isRun then
    if direction then
      position := position + ((time_to_real(timer.currentTime - t1)/10.)/
                              (time_to_real(timeTo_up_down)/1000.));
    else
      position := position - ((time_to_real(timer.currentTime - t1)/10.)/
                              (time_to_real(timeTo_up_down)/1000.));
    end_if;
    t1 := timer.currentTime;
  else
    t1 := t#0ms;
  end_if;


  currentPosition := position;

  if setPosition>0. then
     if setPosition>currentPosition then
        open:=true;
     end_if;
     if setPosition<currentPosition then
        close:=true;
     end_if;
  end_if;

  if currentPosition <= 0. or currentPosition >= 100. then
     stop:= true;
  end_if;

  if abs(setPosition - currentPosition) <= 0.05 then
     setPosition:=0.;
     stop:= true;
  end_if;

  openTrigg(CLK := open);
  if openTrigg.Q then
    timer(start := true, timeToCount := timeTo_up_down + t#20ms);
    t1 := t#0ms;
    up := true;
    down := false;
    direction := true;
  end_if;

  closeTrigg(CLK := close);
  if closeTrigg.Q then
    timer(start := true, timeToCount := timeTo_up_down + t#20ms);
    t1 := t#0ms;
    up := false;
    down := true;
    direction := false;
  end_if;

  stopTtigg(CLK := stop);
  if stopTtigg.Q then
     up:=false;
     down:=false;
     timer(reset:=true);
     setPosition:=0.;
  end_if;

  timer();
  if timer.isDone then
    timer(reset := true);
    up := false;
    down := false;
  end_if;
END_FUNCTION_BLOCK
