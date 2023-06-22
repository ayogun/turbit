# Turbit Project
This repository contains the code and documentation for the tasks assigned by Turbit.

</br>

## :scroll: Table of Contents
- [About](#closed_bookabout)
- [Used Technologies](#computerused-technologies)
- [Usage](#wrenchusage)
- [Practical Tasks](#pushpinpractical-tasks)
	- [Task 1](#task-1-setting-up-a-vagrant-linux-vm-with-a-running-mongodb-using-an-ansible-playbook)
	- [Task 2](#task-2-setting-up-a-second-vagrant-linux-vm-for-regular-mongodb-backups-using-an-ansible-playbook)
	- [Task 3](#task-3-setting-up-a-vpn-server-in-one-vm-and-connecting-to-the-server-via-the-other-vm)
- [Theoretical Tasks](#pushpintheoretical-tasks)
	- [Task 1](#task-1-strategy-to-migrate-from-docker-swarm-to-kubernetes)
	- [Task 2](#task-2-action-plan-for-an-unreachable-web-app)
	- [Task 3](#task-3-monitoring-strategy-for-a-large-scale-infrastructure)



</br></br>

---
---

</br></br>

## :closed_book:About
 The tasks were divided into practical and theoretical sections. Below you will find the details and code snippets for the practical tasks, as well as the written answers to the theoretical tasks.


</br></br>


## :computer:Used Technologies
The following technologies were used to complete the tasks:
- Vagrant
- Ansible
- MongoDB
- Algo VPN
- Kali Linux
- Ubuntu
- MacOS ARM64
- VMWare Fusion

</br></br>


## :wrench:Usage
You can run `$ ./turbit.sh` to run the code. The script will install the necessary dependencies and run the *Vagrantfiles* and *ansible playbooks* for the practical tasks. It has been prepared to run on MacOS ARM64. If you are using a different OS, you can run the code manually. 

Nevertheless, still you may encounter some issues. In this case you may need to run the codes by yourself. You can find the necessary commands below.

1. Install Vagrant, VMWare Fusion and Ansible on your machine.
2. Run `$ cd ./Working_Solution/3 && vagrant up` and make sure that machine is up and running. Try to run the code twice if you encounter any issues.
3. Run `$ vagrant provision` to run the ansible playbook. Because of a bug that I couldn't solve, you may need to run this command twice. If you encounter any issues, you may have to ssh into the machine and finish the Algo VPN installation manually. You can find the necessary commands [here](https://github.com/trailofbits/algo).
4. Run `$ cd ../1 && vagrant up` and make sure that machine is up and running. Try to run the code twice if you encounter any issues.
5. Run `$ vagrant provision` to run the ansible playbook. Because of a bug that I couldn't solve, you may need to run this command twice. 
6. Run `$ cd ../2 && vagrant up` and make sure that machine is up and running. Try to run the code twice if you encounter any issues.
7. Run `$ vagrant provision` to run the ansible playbook. Because of a bug that I couldn't solve, you may need to run this command twice.


</br></br>


## :pushpin:Practical Tasks

### Task 1: 
Setting up a Vagrant Linux VM with a running MongoDB using an Ansible playbook.
The ansible playbook for setting up a Vagrant Linux VM with MongoDB can be found in the [mongo.yml](./Working_Solution/1/mongo.yml) file. It installs MongoDB and configures it to run on port 27017. It also installs the Algo VPN client and configures it to connect to the VPN server.

### Task 2: 
Setting up a second Vagrant Linux VM for regular MongoDB backups using an Ansible playbook.
The ansible playbook for setting up a second Vagrant Linux VM for regular MongoDB backups can be found in the [backup.yml](./Working_Solution/2/backup.yml) file. It installs mongo dump and configures it. It also creates a cron job to run a backup script every minutes. The backup script can be found in the [backup.sh](./Working_Solution/2/backup.sh) file. It creates a backup folder and runs the mongo dump command to create a backup of the database. It also installs the Algo VPN client and configures it to connect to the VPN server. 

### Task 3:

Setting up a VPN server in one VM and connecting to the server via the other VM.
The ansible playbook for setting up a VPN server in one VM and connecting to it via the other VM can be found in the [vpn.yml](./Working_Solution/3/vpn.yml) file. It installs Algo VPN and configures it. It also copies the client configuration file to the host machine. This is why, first this machine should be up and running. Then, the client machine should be up and running. After that, the client configuration file can be used to connect to the VPN server.

</br></br>

---

</br></br>

## :pushpin:Theoretical Tasks

</br>

### **Task 1:** Strategy to migrate from Docker Swarm to Kubernetes


To migrate from Docker Swarm to Kubernetes, the following strategy can be applied:

1. **Analyze the current setup:**
	
	Begin by thoroughly understanding your existing Docker Swarm deployment. Document the architecture, including the number of nodes, services, and their configurations. Identify any customizations, dependencies, and potential challenges that may arise during the migration.

2. **Plan the migration:** 
	
	Define a detailed migration plan that includes timelines, milestones, and potential rollback options. Identify the target Kubernetes cluster setup, such as the number and type of nodes, networking, storage, and other resources required. Then according to the; *Downtime Tolerance* and *Resource Availability* assess your situation carefully. If you have the capacity to run parallel deployments or maintain separate clusters for Docker Swarm and Kubernetes, hybrid or multi-cluster deployments can be considered. These strategies provide flexibility and allow you to migrate gradually without affecting the existing production environment.This is why, I'd make blue-green deployment because it increases application availability and reduces deployment risk by simplifying the rollback process if a deployment fails. However for a small scaled startup with limited amount of capacity and resources, I'd make a rolling deployment. This strategy is ideal for production environments as it allows you to deploy new versions of an application without downtime in a subset of nodes. It also provides a straightforward rollback process if the deployment fails. A/B Testing Deployment is also a good option for a small scaled startup. It allows you to test new versions of an application in a production environment by routing a subset of users to the new version. This strategy is ideal for validating new features or changes before rolling them out to all users. However, deployment strategy is highly dependent on the situation and stakeholders. Therefore, I'd discuss the situation with the stakeholders and decide on the best strategy for the certain requirements.

3. **Provision the Kubernetes cluster:**

	Set up a new Kubernetes cluster or choose a managed Kubernetes service provider. Configure the necessary resources, including nodes, networking, storage, and security. Ensure the cluster is properly secured and aligned with best practices for production environments.

4. **Convert Docker Swarm services to Kubernetes:**

	Review the existing Docker Compose files used in the Docker Swarm deployment and modify them to work with Kubernetes. Update the deployment manifests (e.g., YAML files) to define Kubernetes-native resources such as Deployments, Services, ConfigMaps, and Secrets. Consider leveraging tools like Kompose or Kubernetes-specific templating engines to automate this conversion process.

5. **Test and iterate:** 

	Before migrating production workloads, conduct thorough testing in a non-production environment. Validate the converted Kubernetes manifests, ensure service discovery and networking function as expected, and assess any performance differences or dependencies that may impact the migration. Iterate and address any issues or discrepancies found during testing.

6. **Deploy and monitor:** 

	Once testing is complete, start the migration by deploying services onto the Kubernetes cluster. Monitor the migration process closely, keeping an eye on resource utilization, service health, and any potential performance bottlenecks. Utilize Kubernetes-specific monitoring and observability tools to gain insights into cluster performance.

7. **Monitor and Optimize:** 

	Continuously monitor the Kubernetes cluster post-migration, identifying areas of improvement and optimizing resource allocation, scaling policies, and configuration settings. Ensure you have proper logging, monitoring, and alerting mechanisms in place to detect and respond to any issues promptly.

8. **Train and support the team:** 

	Provide training and support to the development and operations teams to help them understand Kubernetes concepts and best practices. This includes educating them on Kubernetes-specific tools, debugging techniques, and troubleshooting methodologies to enable efficient day-to-day operations.

9. **Document and update processes:**
 
 	Update your documentation to reflect the changes made during the migration. Include instructions for deploying new services on Kubernetes, troubleshooting common issues, and maintaining the cluster over time. Keep the documentation up to date as you evolve your Kubernetes deployment.

</br></br>

### **Task 2:** Action plan for an unreachable web app


Here's a detailed action plan to follow:

1. **Initial assessment:**
	* Verify the issue: Confirm that the web app is indeed unreachable by checking from multiple devices or networks.
	* Check related services: Ensure that supporting services such as databases, caches, or external APIs are functioning correctly.
	* Review monitoring alerts: Check if any monitoring system or error reporting tools have triggered alerts or provided insights into the issue.
	</br>

2. **Communication:**
	* Alert stakeholders: Notify the relevant stakeholders, including the development team, operations team, and management, about the issue and the investigation process.
	* Internal communication: Establish a communication channel or incident management tool for efficient collaboration and updates during the resolution process.

</br>

3. **Endpoint checking:**
	* Ping endpoints: Use network diagnostic tools such as ping or traceroute to check if the endpoints associated with the web app (such as the server IP, domain name, or load balancer IP) are responding to network requests.
	* Check port connectivity: Use tools like telnet or nc to validate if the required ports (typically port 80 for HTTP or 443 for HTTPS) are open and accessible for incoming web traffic.
	* SSL certificate validity: If using HTTPS, verify the SSL certificate associated with the web app's domain to ensure it is valid and not expired.

	</br>

4. **Log analysis and error handling:**
    * Access logs: Check the web server logs or relevant application logs for any error messages or anomalies that could indicate the cause of the issue.
    * Error handling: Review the error handling mechanisms within the application code to ensure that any unhandled exceptions or errors are being logged appropriately.
		
	</br>


5. **Infrastructure investigation:**
    * Server status: Check the server(s) hosting the web app to verify if they are up and running.
    * Network connectivity: Ensure that the network connection between the server(s) and the internet is stable and functioning correctly.
    * Firewall and security groups: Review the firewall rules and security group configurations to confirm that the necessary ports are open for web traffic.
    * Load balancer or reverse proxy: If applicable, inspect the load balancer or reverse proxy configuration to ensure proper routing of incoming traffic.

		
	</br>


6. **Application-level troubleshooting:**
    * Service/process status: Check if the web server or application process is running without errors or crashes. Restart the process if necessary.
    * Resource utilization: Review the server's resource utilization (CPU, memory, disk) to determine if there are any bottlenecks impacting the application's performance.
    * Dependency issues: Ensure that all dependencies (libraries, frameworks, modules) required by the web app are correctly installed and up to date.
    * Configuration review: Verify the application's configuration files for any misconfigurations that may prevent it from running or accepting incoming requests.

		
	</br>


7. **External factors:**
    * DNS configuration: Check the DNS settings to ensure that the domain or subdomain points to the correct IP address or load balancer.
    * Content delivery network (CDN): If using a CDN, verify that the CDN configuration is correctly caching and serving the web app's content.
    * Third-party services: Investigate if any third-party services integrated with the web app are experiencing issues that could affect its accessibility.

		
	</br>


8. **Rollback and mitigation:**
    * Rollback plan: If the root cause is not identified or a quick resolution is not feasible, consider rolling back to the previous known working version of the web app.
    * Mitigation steps: Determine if any temporary measures, such as deploying a maintenance page or providing alternate access methods, can be implemented to minimize the impact on users.

		
	</br>


9. **Resolution and testing:**
    * Implement fixes: Apply the necessary fixes based on the findings from the investigation.
    * Testing: Perform thorough testing to ensure the web app is reachable and functioning as expected before declaring the issue as resolved.
    * Monitoring: Reinforce monitoring systems to actively track the web app's health and be alerted to any potential future issues.

		
	</br>


10. **Post-incident analysis and documentation:**
    * Post-incident analysis: Conduct a post-incident analysis to understand the root cause, identify areas of improvement, and prevent similar issues in the future.
    * Documentation: Document the incident, including the timeline, actions taken, and lessons learned, to help with future incident response and troubleshooting.

	
	</br>



### Task 3: Monitoring strategy for a large-scale infrastructure

Here's a detailed monitoring strategy for a large-scale infrastructure:

1. **Identify critical endpoints:** 

	Determine the key endpoints of your application or service that need to be monitored. These endpoints may include APIs, web services, health checks, or specific URLs that represent critical functionality or user interactions.

</br>

2. **Define monitoring parameters:** 
	
	Determine the specific metrics and parameters you want to monitor for each endpoint. These can include response time, status codes, error rates, throughput, latency, and data transfer size. Define thresholds or benchmarks for these metrics to identify deviations or anomalies.

</br>

3. **Implement endpoint monitoring tools:** 

	Choose appropriate tools or services that specialize in endpoint monitoring. Some popular options include synthetic monitoring tools like Pingdom, New Relic Synthetics, or custom-built monitoring scripts using tools like Selenium or cURL. These tools simulate requests to the endpoints at regular intervals and collect data on response times and other relevant metrics.

</br>

4. **Configure monitoring frequency:** 

	Set up the monitoring tool to regularly send requests to the endpoints at predefined intervals. This frequency can vary depending on the criticality of the endpoint and the expected traffic patterns. For critical endpoints, monitoring may occur every few seconds, while for less critical ones, it could be less frequent.

</br>

5. **Set up alerting:** 

	Configure alerting mechanisms to notify the appropriate teams or individuals when an endpoint fails or exhibits abnormal behavior. Define thresholds or rules that trigger alerts based on specific conditions such as response time exceeding a certain threshold or a high error rate. Alerts can be sent via email, SMS, or integrated with incident management platforms like PagerDuty or OpsGenie.

</br>

6. **Monitor endpoint dependencies:** 

	If your endpoints rely on external services or APIs, ensure that you monitor the health and performance of those dependencies as well. Monitoring the upstream and downstream services helps in identifying issues that could impact the functionality of your endpoints.

</br>

7. **Performance monitoring:** 

	In addition to basic endpoint availability monitoring, consider implementing performance monitoring for critical endpoints. This involves capturing detailed performance metrics like response time breakdowns (DNS lookup, connection time, server processing time, etc.) and measuring the impact of endpoint performance on end-user experience.

</br>

8. **Logging and error handling:** 

	Implement robust logging and error handling mechanisms within your application or service. Capture relevant logs and errors associated with endpoint interactions. Monitor error rates, error types, and error messages to identify potential issues impacting the endpoints.

</br>

9. **Data visualization and analysis:** 

	Utilize monitoring tools or services that provide visualizations and analytics for endpoint data. This helps in identifying trends, patterns, and performance bottlenecks. Leverage dashboards and charts to gain insights into the health and behavior of the endpoints over time.

</br>

10. **Regular reviews and optimization:** 

	Regularly review the monitored endpoint data and analyze any performance or availability issues. Use the insights gained to optimize endpoint configurations, troubleshoot problems, and enhance the overall reliability and performance of the endpoints.


