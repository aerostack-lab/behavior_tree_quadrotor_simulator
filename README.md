# behavior_tree_quadrotor_simulator

This application illustrates how a drone execute a simple mission. The mission is formulated as a behavior tree. During the mission execution, it is possible to pause and continue the mission execution. While the mission is paused, the user can teleoperate manually the drone using the keyboard.

In order to execute the mission, perform the following steps:

- Execute the script that launches the Rviz simulator and the Aerostack components for this project:

        $ ./main_launcher.sh

- Wait until the following window is presented:

<img src="https://i.ibb.co/C2spPfV/Captura-de-pantalla-de-2021-06-04-13-53-32.png" width=600>

As a result of this command, a set of windows are presented to monitor the execution of the mission. These windows include:
- Alphanumeric behavior viewer
- Belief viewers 

In order to start the execution of the mission, press the button "start mission" (window behavior tree interpreter). The mission is previously stored as a behavior tree in configs/mission/behavior_tree_mission_file.yaml

The following video illustrates how to launch the project:

[ ![Launch](https://i.ibb.co/C2spPfV/Captura-de-pantalla-de-2021-06-04-13-53-32.png)](https://www.youtube.com/watch?v=5H5ElS89rxo)


The following video shows the content of belief memory viewer and the alphanumeric behavior execution viewer during the mission execution:
  
[ ![Airplane inspection gazebo](https://i.ibb.co/QCMYNPD/Captura-de-pantalla-de-2021-06-04-13-56-36.png)](https://youtu.be/KZDYf39EHsY)
