// Another module in our architecture is the data module. 
//Together with the presentation module, 
//this module also exists in the outer levels of clean architecture.
// However, it has a dependency only on the domain module, and cannot talk to the presentation module directly.

class Data{
  static void init(){}
}