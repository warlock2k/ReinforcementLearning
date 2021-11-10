# ReinforcementLearning

Here I document all my learnings about the topic Reinforcement Learning.

## multiarmedbandit.m

Plots average rewards vs step size of greedy, and epsilon-greedy approaches to the n-armed bandit problem. We have an n-armed bandit, a version of the 1-armed bandit. Depending on which arm we choose to pull we receive a different payout/reward for that action. We have several (but finite) tries during a play, with the goal to maximize our total reward during the whole play. During this process we continually update the rewards we assign to different arms, with the goal to find the arm with the highest actual reward.

Greedy algorithm: picks the arm with the current highest reward and sticks with that.

Epsilon-greedy algorithm: explores the different arms with epsilon probability, chooses the current highest reward (i.e greedy approach) with (1-epsilon) prob.

## bellman_optimality_recycling_robot.m

Used bellman optimality equations to create equations for states high and low abd chosen the pair of equations that led to the maximum state values.

## policy_iteration_gridworld.m

This file contains code that evaluates the given policy for a 5x5 grid world until it converges and then generates a new policy by by selecting max(action values) at each state and then repeats this process until the policy converges until optimal policy is reached.

Note: Policy iteration uses bellman expectation equation and then chooses state action values greedily.

## policy_iteration_recycling robot.m

This file contains code that evaluates the given policy for the recycling robot problem until it converges and then generates a new policy by by selecting max(action values) at each state and then repeats this process until optimal policy is reached.

Note: Policy iteration uses bellman expectation equation and then chooses state action values greedily.

## value_iteration_grid_world.m

This file contains code that finds opimtal state values for a recycling robot problem using value iteration.

Note: Value iteration using bellman optimality equation.

## first_visit_MC_prediction_recycling_robot.m

This file contains code that evaluates a policy using first visit MC algorithm.

## first_visit_MC_control_recycling_robot.m

This file contains code that finds optimal policy using first visit MC algorithm.

## sarsa_recycling_robot_control.m

This file contains code that finds optimal policy of a recycling robot problem using sarsa algorithm.

## td_zero_recycling_robot_prediction

This file evaluates a certain policy for the recycling robot problem using td_zero_algorithm

## sarsa_recycling_robot_control.m

This file contains code that applies expected sarsa algorithm to find the optimal policy for a recycling robot problem.

## q_learning_recycling_robot_control

This file contains code that applied q-learning to a recycling robot problem to find optimal policy.

## td_zero_gradient_descent_grid_world.m

This file contains code that performs linear approximation of the value function using stochastic gradient descent with TD(0) for a grid world problem. 
