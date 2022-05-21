class Domain {
  static void init() {}
}


// The inner layer of our architecture is the domain module. 
// So, the other two modules, presentation, and data, directly depend on the domain.
// This module is where we encapsulate all our business rules.