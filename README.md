# Pontryagin-s-Min.-Principle

This is a model explanation as to how Pontryagin's Minimum Principle can be used to find the optimal path for a control variable like Battery Power, in this case. Of course, the values used in this case are fictional, and not actual real-world values. There are many ways to implement this algorithm: Use 'dsolve' command, use NLP solvers like casadi or use a simple nested 'for-loop' to check for the optimal value. Here, we use a simple nested 'for-loop' to implement PMP. In addition, we can also use a shooting method in order to estimate the initialization of the costate. 

An explantion of this principle and the code can be found at : https://kaputtengineers.wixsite.com/home/post/pontryagin-s-minimum-principle

I hope this article has helped you to gain a better understanding of this widely-used technique and its application from the perspective of Hybrid-Electric Vehicles. 
