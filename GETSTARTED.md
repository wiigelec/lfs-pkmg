

### **Quick Start Guide for lfs-pkmg**

This guide details the workflow for building the LFS base packages, moving them to an HTTP server, creating a package list, and then installing the package list to a target drive or partition.

---

### **Prerequisites: System Partitions**

To use this workflow, your machine must have two separate partitions mounted.

* **Build Partition**: This is a temporary partition for the build and packaging process. An example mount point is /mnt/lfs-build.  
* **Target Partition**: This is the final, clean partition where your new LFS system will be installed. An example mount point is /mnt/target.

---

### **Step 1: Build the LFS System (Build Partition)**

First, you will build LFS into the temporary build partition. This process creates all the necessary package archives (.txz files).

1. **Clone Repositories**: Clone the LFS book and the jhalfs build tool repositories.  
   Bash  
   make git-lfs  
   make git-jhalfs

2. **Configure the Build Action**: Launch the menu to set your build parameters.  
   Bash  
   make select-action-params

   In the menu, you must set:  
   * **Action**: BUILD \-\> LFS  
   * **INSTALLROOT**: Set this to your **build partition** (e.g., /mnt/lfs-build)  
   * **REV**: Your init system (e.g., sysv)  
   * **BRANCH**: The LFS book branch  
3. **Run the Build and Packaging Sequence**: Execute the following targets in order to perform the build and create the packages.  
   Bash  
   make setup-lfs-jhalfs  
   make setup-lfs-difflog  
   make build-lfs  
   make setup-lfs-chroot  
   make build-lfs-chroot-scripts  
   make build-lfs-chroot-archives

   The package archives will be created at /mnt/lfs-build/var/lib/lpm/build/packages/.

---

### **Step 2: Host Packages on a File Server**

This step prepares your packages for remote installation by hosting them on a web server.

1. **Create Server Directories**: Create the required directory structure on your web server.  
   Bash  
   mkdir \-p /var/www/html/lfs-pkmg/12.1-sysv/packages  
   mkdir \-p /var/www/html/lfs-pkmg/12.1-sysv/lists

2. **Copy Packages**: Copy all the .txz archives created in Step 1 into the server's .../12.1-sysv/packages/ directory.

---

### **Step 3: Create and Host the Package List**

Generate the package list from your build partition's packages and place it on the server.

1. **Configure the Create List Action**: Launch the menu to configure the list creation process.  
   Bash  
   make select-action-params

   In the menu, you must set:  
   * **Action**: List \-\> Create directory list  
   * **Archive dir (LISTDIRPATH)**: /mnt/lfs-build/var/lib/lpm/build/packages/  
   * **List file (LISTFILE)**: /mnt/lfs/var/lib/lpm/build/lists/lfs-base.list  
2. **Run the Create List Target**: This target will read all package archives from the specified directory and create a new list file.  
   Bash  
   make list-create-dir

3. **Copy the List**: Copy the new list file to your web server.  
   Bash  
   cp lists/lfs-base.list /var/www/html/lfs-pkmg/12.1-sysv/lists/

---

### **Step 4: Create the Post-Install Hook**

Create the custom hook script inside your local lfs-pkmg project directory on the build machine.

1. **Create the directory**:  
   Bash  
   mkdir \-p custom/list

2. **Create the hook script file**: Create a file named after the list from Step 3 and make it executable.  
   * **File Path**: custom/list/lfs-base.list.post  
   * **Content**: Your interactive setup script.  
   * Make it executable: chmod \+x custom/list/lfs-base.list.post

---

### **Step 5: Install the System (Target Partition)**

This final workflow, run from the build machine, installs the packages from your server onto your clean target partition.

1. **Configure Installation**: Launch the menu to configure the installation.  
   Bash  
   make select-action-params

   In the menu, you must set all three of these options:  
   * **Action**: List \-\> Install  
   * **Repository Path (REPOPATH)**: The full URL to your build directory (e.g., http://your-server.com/lfs-pkmg/12.1-sysv)  
   * **INSTALLROOT**: Set this to your **final target partition** (e.g., /mnt/target)  
2. **Select Remote List**: This target reads the REPOPATH you just set. It automatically connects to the URL, finds the lists in the /lists subdirectory, and presents a menu for you to select one (e.g., lfs-base.list).  
   Bash  
   make select-repo-lists

3. **Execute Installation**: This target reads the configurations from the previous two steps and automatically installs every package. After the final package is installed, your custom/list/lfs-base.list.post hook will execute, launching your interactive configuration menu.  
   Bash  
   make list-install  
