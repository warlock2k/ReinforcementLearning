# ReinforcementLearning

This is space where I document all my learnings from the topic Reinforcement Learning.

## multiarmedbandit.m

Plots average rewards vs step size of greedy, and epsilon-greedy approaches to the n-armed bandit problem. We have an n-armed bandit, a version of the 1-armed bandit. Depending on which arm we choose to pull we receive a different payout/reward for that action. We have several (but finite) tries during a play, with the goal to maximize our total reward during the whole play. During this process we continually update the rewards we assign to different arms, with the goal to find the arm with the highest actual reward.

Greedy algorithm: picks the arm with the current highest reward and sticks with that.

Epsilon-greedy algorithm: explores the different arms with epsilon probability, chooses the current highest reward (i.e greedy approach) with (1-epsilon) prob.
