class FunctionCall {
  FunctionContainer functionContainer; //actions document
  int callFrame;
  FunctionCall (FunctionContainer functionContainer, int callFrame) {
    this.functionContainer = functionContainer;
    this.callFrame = callFrame;
  }
}
class RoutineHandler {
  ArrayList <FunctionCall> routines;
  RoutineHandler () {
    routines = new ArrayList <FunctionCall> ();
  }
  void Update () {
    FunctionCall routine;
    while ((routine = routines.get (0)).callFrame < frameCount) {
       routine.functionContainer.Function ();
    }
  }
  void AddRoutine (FunctionCall functionCall) {
    int numberOfRoutines = routines.size ();
    for (int i = 0; i < numberOfRoutines; i++) {
      if (routines.get (i).callFrame > functionCall.callFrame) {
        routines.add (i, functionCall);
        return;
      }
    }
    routines.add (functionCall);
  }
}