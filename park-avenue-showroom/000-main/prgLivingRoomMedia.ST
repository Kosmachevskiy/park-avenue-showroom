VAR_GLOBAL CONSTANT
  TV_ON       : uint := 100;
  TV_OFF      : uint := 101;
  PLAYER_ON   : uint := 102;
  PLAYER_OFF  : uint := 103;
  RECEIVER_ON : uint := 104;
  RECEIVER_OFF: uint := 105;
END_VAR

PROGRAM prgLivingRoomMedia
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      generalPowerObserber     : fbBoolObserver;
      clock                 : fbTick;
      allOnState  : usint;
      allOffState : usint;
      init : bool;
  END_VAR
  VAR_TEMP
  END_VAR


  if not init then
  
    globalCacheCodes[TV_ON]        := 'sendir,1:1,1,36000,1,1,32,32,64,31,32,32,32,32,32,32,32,32,32,63,32,32,32,32,32,32,32,32,32,32,32,3600';
    globalCacheCodes[TV_OFF]       := 'sendir,1:1,1,36000,1,1,32,32,64,31,32,32,32,32,32,32,32,32,32,63,32,32,32,32,32,32,64,63,32,3600';
    globalCacheCodes[PLAYER_ON]    := 'sendir,1:1,1,38000,1,1,341,169,21,21,21,21,21,63,21,63,21,63,21,63,21,63,21,21,21,63,21,63,21,21,21,21,21,21,21,21,21,21,21,63,21,21,21,63,21,63,21,21,21,63,21,63,21,63,21,63,21,63,21,21,21,21,21,63,21,21,21,21,21,21,21,21,21,1515,341,85,21,3800';
    globalCacheCodes[PLAYER_OFF]   := 'sendir,1:1,1,38000,1,1,341,169,21,21,21,21,21,63,21,63,21,63,21,63,21,63,21,21,21,63,21,63,21,21,21,21,21,21,21,21,21,21,21,63,21,63,21,63,21,63,21,21,21,63,21,63,21,63,21,63,21,21,21,21,21,21,21,63,21,21,21,21,21,21,21,21,21,1515,341,85,21,3800';
    globalCacheCodes[RECEIVER_ON]  := 'sendir,1:2,1,38000,1,1,341,169,21,20,21,20,21,20,21,20,21,20,21,20,21,20,21,63,21,20,21,20,21,20,21,20,21,63,21,63,21,63,21,20,21,20,21,20,21,20,21,20,21,63,21,20,21,63,21,63,21,63,21,63,21,63,21,63,21,20,21,63,21,20,21,20,21,1513,341,84,21,3800';
    globalCacheCodes[RECEIVER_OFF] := 'sendir,1:2,1,38000,1,1,341,169,21,20,21,20,21,20,21,20,21,20,21,20,21,20,21,63,21,20,21,20,21,20,21,20,21,63,21,63,21,63,21,20,21,63,21,63,21,63,21,63,21,63,21,20,21,20,21,63,21,20,21,20,21,20,21,20,21,20,21,63,21,63,21,20,21,1517,341,85,21,3800';

  end_if;
  

  generalPowerObserber(state := generalPower);

  if panel.button[5].shortPress then
     allOnState := 1;
  end_if;
  
  if panel.button[6].shortPress  or generalPowerObserber.falling then
     allOffState := 1;
  end_if;
  
  clock(IN := true, PT := T#1000ms);
  
  if clock.Q then
      case allOnState of
          1:  allOnState := 2; //blank call
          2:
              globalCache.sendCode := TV_ON;
              allOnState := 3;
          3:
              globalCache.sendCode := PLAYER_ON;
              allOnState := 4;
          4:
              globalCache.sendCode := RECEIVER_ON;
              allOnState := 0;
      end_case;
      
      case allOffState of
          1:  allOffState := 2;
          2:
              globalCache.sendCode := TV_OFF;
              allOffState := 3;
          3:
              globalCache.sendCode := PLAYER_OFF;
              allOffState := 4;
          4:
              globalCache.sendCode := RECEIVER_OFF;
              allOffState := 0;
      end_case;
  end_if;
  
END_PROGRAM

