#!/bin/bash

NUMID_DRONE=107
export AEROSTACK_PROJECT=${AEROSTACK_STACK}/projects/behavior_tree_quadrotor_simulator

. ${AEROSTACK_STACK}/config/mission/setup.sh

#---------------------------------------------------------------------------------------------
# INTERNAL PROCESSES
#---------------------------------------------------------------------------------------------
gnome-terminal  \
`#---------------------------------------------------------------------------------------------` \
`# Basic Behaviors                                                                             ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Basic Behaviors" --command "bash -c \"
roslaunch basic_quadrotor_behaviors basic_quadrotor_behaviors.launch --wait \
    namespace:=drone$NUMID_DRONE;
exec bash\"" \
`#---------------------------------------------------------------------------------------------` \
`# Quadrotor Motion With PID Control                                                           ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Quadrotor Motion With PID Control" --command "bash -c \"
roslaunch quadrotor_motion_with_pid_control quadrotor_motion_with_pid_control.launch --wait \
    namespace:=drone$NUMID_DRONE \
    robot_config_path:=${AEROSTACK_PROJECT}/configs/drone$NUMID_DRONE \
    uav_mass:=0.7;
exec bash\""  \
`#---------------------------------------------------------------------------------------------` \
`# Quadrotor simulator                                                                         ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Quadrotor Simulator" --command "bash -c \"
roslaunch quadrotor_simulator_process quadrotor_simulator.launch --wait \
    robot_namespace:=drone$NUMID_DRONE \
    robot_config_path:=${AEROSTACK_PROJECT}/configs/drone$NUMID_DRONE \
    rviz_config_path:=${AEROSTACK_PROJECT}/configs/rviz_files;
exec bash\""  \
`#---------------------------------------------------------------------------------------------` \
`# Belief Memory Viewer                                                                        ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Belief memory Viewer" --command "bash -c \"
roslaunch belief_memory_viewer belief_memory_viewer.launch --wait \
  robot_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE;
exec bash\""  \
`#---------------------------------------------------------------------------------------------` \
`# Behavior Execution Viewer                                                                   ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Behavior Execution Viewer" --command "bash -c \"
roslaunch behavior_execution_viewer behavior_execution_viewer.launch --wait \
  robot_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE \
  catalog_path:=${AEROSTACK_PROJECT}/configs/mission/behavior_catalog.yaml;
exec bash\""  \
`#---------------------------------------------------------------------------------------------` \
`# Belief Manager                                                                              ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Belief Manager" --command "bash -c \"
roslaunch belief_manager_process belief_manager_process.launch --wait \
    drone_id_namespace:=drone$NUMID_DRONE \
    drone_id:=$NUMID_DRONE \
    config_path:=${AEROSTACK_PROJECT}/configs/mission;
exec bash\""  \
`#---------------------------------------------------------------------------------------------` \
`# Belief Updater                                                                              ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Belief Updater" --command "bash -c \"
roslaunch belief_updater_process belief_updater_process.launch --wait \
    drone_id_namespace:=drone$NUMID_DRONE \
    drone_id:=$NUMID_DRONE;
exec bash\""  \
`#---------------------------------------------------------------------------------------------` \
`# Behavior Coordinator                                                                       ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Behavior coordinator" --command "bash -c \" sleep 2;
roslaunch behavior_coordinator behavior_coordinator.launch --wait \
  robot_namespace:=drone$NUMID_DRONE \
  catalog_path:=${AEROSTACK_PROJECT}/configs/mission/behavior_catalog.yaml;
exec bash\"" &

#---------------------------------------------------------------------------------------------
# USER INTERFACE PROCESSES
#---------------------------------------------------------------------------------------------
gnome-terminal  \
`#---------------------------------------------------------------------------------------------` \
`# Alphanumeric Viewer                                                                         ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Alphanumeric Viewer"  --command "bash -c \"
roslaunch alphanumeric_viewer alphanumeric_viewer.launch  --wait \
    drone_id_namespace:=drone$NUMID_DRONE;
exec bash\""  &
sleep 3
gnome-terminal \
`#---------------------------------------------------------------------------------------------` \
`# Behavior Tree Interpreter                                                                   ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Behavior Tree Interpreter" --command "bash -c \"
roslaunch behavior_tree_interpreter behavior_tree_interpreter.launch --wait \
  robot_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE \
  mission_configuration_folder:=${AEROSTACK_PROJECT}/configs/mission \
  catalog_path:=${AEROSTACK_PROJECT}/configs/mission/behavior_catalog.yaml;
exec bash\"" &
