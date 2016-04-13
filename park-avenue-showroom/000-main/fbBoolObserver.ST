FUNCTION_BLOCK fbBoolObserver
  VAR_INPUT
	  state        : bool;
  END_VAR
  VAR
      prevState : bool;
  END_VAR
  VAR_OUTPUT
      stateChanged : bool;
      rising       : bool;
      falling      : bool;
  END_VAR
  VAR_IN_OUT

  END_VAR
  VAR_TEMP

  END_VAR
      stateChanged := false;
      rising       := false;
      falling      := false;
      if state <> prevState then
         stateChanged := true;
         if state then
            rising := true;
         else
            falling := true;
         end_if;
         prevState := state;
      end_if;
END_FUNCTION_BLOCK
