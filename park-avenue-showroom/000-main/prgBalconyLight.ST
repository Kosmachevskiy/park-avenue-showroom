PROGRAM prgBalconyLight
  VAR_INPUT
  END_VAR
  VAR_OUTPUT
  END_VAR
  VAR
      out_Lamp1 : ptr_to bool;
      Lamp1     : fbManualRelay;
      
      init      : bool;
  END_VAR
  VAR_TEMP
  END_VAR

  if not init then
     out_Lamp1                  := adr(MODULE1_OUT.DOs.DO4);
     init := true;
  end_if;

  lamp1( trigButton := r3_1BalconyLight,
         state      => out_Lamp1^);

END_PROGRAM

