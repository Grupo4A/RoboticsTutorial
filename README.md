Overview

Here you can see the simulation and code implementation for 3 tasks performed at the EPSON Lab. The EPSON 6-axis robot is equipped with a vacuum nozzle for precise manipulations in the following tasks: 

🤖Task 1: Pick&Place

This task is designed for the robot arm to efficiently pick tokens and blocks using its vacuum nozzle from a feeder located within the workspace of the robot. After picking each token/block, it places them into an alignment tray. Once aligned, the robot transfer the token/block to a tray with the corresponding shape. Upon completing the task for all features, the robot returns each of them to the feeder. 

  🕹️ Operation

	1.	Feature collection: The robot picks tokens from a feeder using the vacuum nozzle and places it on the alingment tray.
	2.	Alignment: Each token is aligned before placement, ensuring accurate positioning for the subsequent steps.
	3.	Final Tray Placement: Tokens are transferred to a tray with the corresponding shape, showcasing the robot’s ability to categorize and organize objects.
	4.	Feeder Refill: Once all tokens are placed, the robot returns each token to the feeder, ready for subsequent cycles.



🤖Task 2: Stacking

This task is designed so that the robot operates on the located tokens from the tray. It systematically stacks circular and square tokens alternately on a designated surface, in this case the alignment tray.

  🕹️ Operation

	1.	Feature Retrieval: The robot retrieves tokens and blocks from the tray using the vacuum nozzle.
	2.	Stacking: Tokens are systematically stacked on a surface, with circular and square tokens alternately arranged.



🤖Task 3: Boosted Pick&Place with I/O Control 🔴🟠🟢🔵⚪️🔴

Task 3 introduces an enhanced pick and place operation for the Epson 6-axis robot, integrating a vacuum nozzle, pressure switch, cylinder piston and an I/O box for control. 

✅♿  Objectives 

	•	Dinamic detection of the quatity of tokens and blocks available in the feeder and the status of the tray using the pressure switch.
	•	The detected information is maintained in the robot’s memory, enabling intelligent decision-making for efficient pick and place operations. 
	•	To control the robot operation by I/O box, allowing functions as start, pause, rest and stop actions.

💡  Features

	•	Dynamic Detection: The pressure switch is utilized to dynamically detect the quantity of tokens and blocks in the feeder, ensuring the robot is aware of the available resources.
	•	Tray Status Monitoring: The pressure switch also monitors the status of the tray, determining whether it is available or occupied. This information is crucial for initiating the pick and place operation.
	•	Memory Integration: Detected information is stored in the robot’s memory, allowing it to make informed decisions based on the current state of the environment.
 	•	I/O Box Control: The robot’s operation is controlled by an I/O box, providing buttons for start, pause, reset, and stop actions. Each button is configured to perform the corresponding operation.

 🕹️ Operation

	1.	Initialization: Configure the I/O box and ensure the proper setup of the Epson 6-axis robot with the vacuum nozzle, pressure switch, and cylinder piston.
	2.	Detection Phase: The robot uses the pressure switch to determine the quantity of tokens and blocks in the feeder and checks the status of the tray.
	3.	Decision Making: Based on the detected information stored in memory, the robot awaits user input from the I/O box for start, pause, reset, or stop actions.
	4.	Pick and Place Operation: The robot uses the vacuum nozzle to pick tokens and blocks and places them in the alingment tray, with the cylinder piston the feature is alinged. Once alinged the robot sistematocally places the token/block in the vacant space of the tray. The action is repeated until all available spaces are filled.
  
