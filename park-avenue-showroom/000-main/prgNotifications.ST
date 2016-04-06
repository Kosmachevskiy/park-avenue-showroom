FUNCTION_BLOCK fbBoolObserver
  VAR_INPUT
      in : bool;
  END_VAR
  VAR
      prevState : bool;
  END_VAR
  VAR_OUTPUT
      stateChanged : bool;
      state        : bool;
      rising       : bool;
      falling      : bool;
  END_VAR
      stateChanged := false;
      rising       := false;
      falling      := false;
      state        := in;
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

FUNCTION_BLOCK fbRealObserver
  VAR_INPUT
      in : ptr_to real;
  END_VAR
  VAR
      prevValue : real;
  END_VAR
  VAR_OUTPUT
      valueChanged : bool;
      value        : real;
      rising       : bool;
      falling      : bool;
  END_VAR
      valueChanged := false;
      rising       := false;
      falling      := false;
      value        := in^;

      if value <> prevValue then
         valueChanged := true;
         if value > prevValue then
            rising := true;
         else
            falling := true;
         end_if;
         prevValue := value;
      end_if;
END_FUNCTION_BLOCK
