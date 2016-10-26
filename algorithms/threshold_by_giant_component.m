function threshold At = compute_threshold_by_giant_component(A)

t = threshold_by_giant_component(A);
At = threshold_absolute(A,t);