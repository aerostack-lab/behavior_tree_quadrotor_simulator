#!/bin/bash

NUMID_DRONE=107
DRONE_SWARM_ID=1
export AEROSTACK_PROJECT=${AEROSTACK_STACK}/projects/behavior_tree_quadrotor_simulator

. ${AEROSTACK_STACK}/config/mission/setup.sh

gnome-terminal \
`#---------------------------------------------------------------------------------------------` \
`# Behavior Tree Editor                                                                        ` \
`#---------------------------------------------------------------------------------------------` \
--tab --title "Behavior Tree Editor" --command "bash -c \"
roslaunch behavior_tree_editor behavior_tree_editor.launch --wait \
  robot_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE \
  mission_config_path:=${AEROSTACK_PROJECT}/configs/mission \
  catalog_path:=${AEROSTACK_PROJECT}/configs/mission/behavior_catalog.yaml;
exec bash\""  &

